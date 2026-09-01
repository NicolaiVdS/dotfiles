local overseer = require("overseer")

return {
	generator = function(search, cb)
		if vim.fn.filereadable(search.dir .. "/Cargo.toml") ~= 1 then
			cb({})
			return
		end

		vim.fn.jobstart({ "cargo", "metadata", "--no-deps", "--format-version", "1" }, {
			cwd = search.dir,
			stdout_buffered = true,
			on_stdout = function(_, output)
				local ok, data = pcall(vim.json.decode, table.concat(output, ""))
				if not ok or not data.packages then
					cb({})
					return
				end

				local members = {}
				for _, pkg in ipairs(data.packages) do
					table.insert(members, pkg.name)
				end
				table.sort(members)

				local templates = {}

				for _, member in ipairs(members) do
					table.insert(templates, {
						name = "cargo build " .. member,
						builder = function()
							return { cmd = { "cargo" }, args = { "build", "-p", member }, components = { "default" } }
						end,
						tags = { overseer.TAG.BUILD },
					})
					table.insert(templates, {
						name = "cargo run " .. member,
						builder = function()
							return { cmd = { "cargo" }, args = { "run", "-p", member }, components = { "default" } }
						end,
						tags = { overseer.TAG.RUN },
					})
					table.insert(templates, {
						name = "cargo test " .. member,
						builder = function()
							return { cmd = { "cargo" }, args = { "test", "-p", member }, components = { "default" } }
						end,
						tags = { overseer.TAG.TEST },
					})
					table.insert(templates, {
						name = "cargo clippy " .. member,
						builder = function()
							return {
								cmd = { "cargo" },
								args = { "clippy", "-p", member, "--all-targets", "--all-features" },
								components = { "default" },
							}
						end,
					})
				end

				table.insert(templates, {
					name = "cargo build (all)",
					builder = function()
						return { cmd = { "cargo" }, args = { "build", "--workspace" }, components = { "default" } }
					end,
					tags = { overseer.TAG.BUILD },
				})
				table.insert(templates, {
					name = "cargo test (all)",
					builder = function()
						return { cmd = { "cargo" }, args = { "test", "--workspace" }, components = { "default" } }
					end,
					tags = { overseer.TAG.TEST },
				})
				table.insert(templates, {
					name = "cargo clippy (all)",
					builder = function()
						return {
							cmd = { "cargo" },
							args = { "clippy", "--workspace", "--all-targets", "--all-features" },
							components = { "default" },
						}
					end,
				})

				cb(templates)
			end,
		})
	end,
	cache_key = function(opts)
		return vim.fs.find("Cargo.toml", { upward = true, type = "file", path = opts.dir })[1]
	end,
}

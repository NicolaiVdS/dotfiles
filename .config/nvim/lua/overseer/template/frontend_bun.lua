return {
	generator = function(search, cb)
		local frontend_pkg = search.dir .. "/frontend/package.json"
		if vim.fn.filereadable(frontend_pkg) ~= 1 then
			cb({})
			return
		end

		cb({
			{
				name = "bun dev (frontend)",
				builder = function()
					return {
						cmd = { "bun", "run", "dev" },
						cwd = search.dir .. "/frontend",
						components = { "default" },
					}
				end,
			},
			{
				name = "bun build (frontend)",
				builder = function()
					return {
						cmd = { "bun", "run", "build" },
						cwd = search.dir .. "/frontend",
						components = { "default" },
					}
				end,
			},
		})
	end,
	cache_key = function(opts)
		return opts.dir .. "/frontend/package.json"
	end,
}

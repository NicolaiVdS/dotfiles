return {
	"mrcjkb/rustaceanvim",
	version = "^9",
	lazy = false,
	ft = { "rust" },
	config = function()
		vim.g.rustaceanvim = {
			tools = {
				float_win_config = {
					border = "rounded",
				},
			},
			server = {
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "<leader>ca", function()
						vim.cmd.RustLsp("codeAction")
					end, { desc = "Code Action", buffer = bufnr })

					vim.keymap.set("n", "<leader>rr", function()
						vim.cmd.RustLsp("runnables")
					end, { desc = "Rust Runnables", buffer = bufnr })

					vim.keymap.set("n", "<leader>rt", function()
						vim.cmd.RustLsp("testables")
					end, { desc = "Rust Testables", buffer = bufnr })

					vim.keymap.set("n", "<leader>re", function()
						vim.cmd.RustLsp("expandMacro")
					end, { desc = "Expand Macro", buffer = bufnr })

					vim.keymap.set("n", "K", function()
						vim.cmd.RustLsp({ "hover", "actions" })
					end, { desc = "Hover", buffer = bufnr })
				end,
				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						check = {
							command = "clippy",
						},
						procMacro = {
							enable = true,
						},
					},
				},
			},
		}
	end,
}

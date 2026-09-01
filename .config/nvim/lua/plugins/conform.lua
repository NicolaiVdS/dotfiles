return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				css = { "prettier" },
				html = function(bufnr)
					local name = vim.api.nvim_buf_get_name(bufnr)
					if name:match("%.tera%.html$") or name:match("/templates/") or name:match("data/index%.html$") then
						return {} -- skip formatting Tera-flavored files
					end
					return { "prettier" }
				end,
			},
			format_on_save = {
				timeout_ms = 3000,
				lsp_fallback = true,
			},
		})

		vim.keymap.set("n", "<leader>gf", function()
			require("conform").format({ async = true })
		end, { desc = "Format file" })
	end,
}

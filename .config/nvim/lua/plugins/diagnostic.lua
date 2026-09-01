return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		config = function()
			require("tiny-inline-diagnostic").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {},
		keys = {
			{
				"<leader>xx",
				function()
					require("trouble").open("diagnostics")
				end,
				desc = "Trouble: Diagnostics (workspace)",
			},
			{
				"<leader>xX",
				function()
					require("trouble").open("diagnostics", { filter = { buf = 0 } })
				end,
				desc = "Trouble: Diagnostics (buffer)",
			},
			{
				"<leader>xr",
				function()
					require("trouble").open("lsp_references")
				end,
				desc = "Trouble: LSP References",
			},
		},
	},
}

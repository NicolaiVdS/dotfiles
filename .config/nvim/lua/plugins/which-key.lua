return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup()

		-- Register group names so the menu is organized
		wk.add({
			{ "<leader>c", group = "code" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "goto" },
			{ "<leader>h", group = "hunks" },
			{ "<leader>r", group = "rust" },
			{ "<leader>t", group = "terminal" },
			{ "<leader>d", group = "debug" },
		})
	end,
}

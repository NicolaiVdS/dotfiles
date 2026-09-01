return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
				follow_current_file = {
					enabled = true,
				},
			},
			window = {
				width = 30,
			},
		})

		vim.keymap.set("n", "<C-n>", function()
			require("neo-tree.command").execute({
				action = "focus",
				source = "filesystem",
				position = "left",
			})
		end, { desc = "Neo-tree" })
	end,
}

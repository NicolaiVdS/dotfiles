return {
	"andweeb/presence.nvim",
	config = function()
		require("presence").setup({
			auto_update = true,
			neovim_image_text = "Neovim",
			main_image = "neovim",
			enable_line_number = false,
			buttons = true,

			editing_text = "",
			file_explorer_text = "",
			git_commit_text = "",
			plugin_manager_text = "",
			reading_text = "",
			workspace_text = "Working on %s",
			line_number_text = "",
		})
	end,
}

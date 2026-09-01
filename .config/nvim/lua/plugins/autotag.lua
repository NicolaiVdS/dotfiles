return {
	"windwp/nvim-ts-autotag",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "InsertEnter",
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename matching HTML/JSX tags
				enable_close_on_slash = true, -- Auto close on trailing </
			},
		})
	end,
}

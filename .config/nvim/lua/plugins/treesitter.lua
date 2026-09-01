return {
	"romus204/tree-sitter-manager.nvim",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSManager" }, -- Provides a UI similar to Mason if you run :TSManager
	config = function()
		require("tree-sitter-manager").setup({
			-- Auto-download and update missing parsers on file open
			auto_install = true,

			-- Ensure these are immediately ready for your stack
			ensure_installed = { "typescript", "javascript", "tsx", "html", "css", "bash", "tera" },

			-- Prevent conflicts with core Neovim 0.12 pre-bundled parsers
			noauto_install = { "c", "lua", "markdown", "vim", "vimdoc" },
		})
	end,
}

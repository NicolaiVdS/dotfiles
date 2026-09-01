return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"vtsls",
				"tailwindcss",
				"clangd",
				"bashls",
				"emmet_language_server",
			},
			automatic_installation = true,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettier", -- Formatter
				"eslint_d", -- Linter
				"stylua", -- Lua formatter
				"clang-format", -- C/C++ formatter
				"shellcheck", -- Shell linter
				"shfmt", -- Shell formatter
				"js-debug-adapter", -- Debugger backend
			},
			run_on_start = true,
		},
	},
}

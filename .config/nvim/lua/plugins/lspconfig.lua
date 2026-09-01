return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		vim.filetype.add({
			extension = {
				tera = "tera",
				jinja2 = "jinja2",
				tsx = "typescriptreact",
				qml = "qml",
			},
		})

		vim.lsp.config.lua_ls = {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
							-- include all lazy plugins
							vim.fn.stdpath("data") .. "/lazy/nvim",
						},
					},
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		}

		vim.lsp.config.vtsls = {}
		vim.lsp.config.tailwindcss = {}
		vim.lsp.config.bashls = {}

		vim.lsp.config.jinja_lsp = {
			filetypes = { "jinja", "jinja2", "tera" },
			root_markers = { ".git", "Cargo.toml", "package.json" },
			root_dir = function(fname)
				local util = require("lspconfig.util")
				-- Zoekt eerst naar projectbestanden, gebruikt anders de map van het bestand zelf
				return util.root_pattern(".git", "Cargo.toml")(fname) or util.path.dirname(fname)
			end,
		}

		vim.lsp.config.emmet_language_server = {
			filetypes = { "tsx", "html", "css", "typescriptreact" },
			init_options = {
				-- 🚀 Force Emmet to treat TSX/JSX as pure HTML so it outputs class="..."
				includeLanguages = {
					typescriptreact = "html",
					javascriptreact = "html",
				},
				preferences = {
					["jsx.enforceParameterAttribute"] = false,
					["markup.attributes/class"] = "class",
				},
			},
		}

		vim.lsp.config.clangd = {
			cmd = {
				"clangd",
				"--background-index",
				"--header-insertion=iwyu",
				"--query-driver=**/xtensa-esp32*/bin/*",
				"--clang-tidy",
				"--fallback-style=none",
			},
			filetypes = { "c", "cpp", "objc", "objcpp" },
			root_markers = {
				"compile_commands.json",
				"compile_flags.txt",
				".git",
				"platformio.ini",
			},
		}

		vim.lsp.config.qmlls = {
			cmd = { "/usr/lib/qt6/bin/qmlls" },
			filetypes = { "qml" },
			root_markers = { ".qmlls.ini", "shell.qml", ".git" },
		}

		vim.lsp.enable({
			"lua_ls",
			"vtsls",
			"tailwindcss",
			"clangd",
			"bashls",
			"emmet_language_server",
			"jinja_lsp",
			"qmlls",
		})

		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
		vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
	end,
}

-- Basic settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes" -- always show, prevents layout jumping

vim.opt.spelllang = { "en_us", "nl" }
vim.opt.spellsuggest = "best,9"

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "gitcommit", "text", "tex" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- Folding
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Indenting
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Dedent" })

-- Diagnostic
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

vim.keymap.set("n", "]s", "]s", { desc = "Next misspelled word" })
vim.keymap.set("n", "[s", "[s", { desc = "Prev misspelled word" })
vim.keymap.set("n", "z=", "z=", { desc = "Spelling suggestions" })
vim.keymap.set("n", "zg", "zg", { desc = "Add word to dictionary" })
vim.keymap.set("n", "zw", "zw", { desc = "Mark word as wrong" })

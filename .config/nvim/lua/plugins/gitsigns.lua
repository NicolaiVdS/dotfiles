return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "]c", gs.next_hunk, { desc = "Next hunk", buffer = bufnr })
        vim.keymap.set("n", "[c", gs.prev_hunk, { desc = "Prev hunk", buffer = bufnr })
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk", buffer = bufnr })
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk", buffer = bufnr })
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk", buffer = bufnr })
        vim.keymap.set("n", "<leader>hb", gs.blame_line, { desc = "Blame line", buffer = bufnr })
      end,
    })
  end,
}

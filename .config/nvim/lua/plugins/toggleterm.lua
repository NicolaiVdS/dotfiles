return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local cargo_run = Terminal:new({ cmd = "cargo run", hidden = true, direction = "float" })
    local cargo_test = Terminal:new({ cmd = "cargo test", hidden = true, direction = "float" })
    local cargo_build = Terminal:new({ cmd = "cargo build", hidden = true, direction = "float" })

    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float terminal" })
    vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal terminal" })
    vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", { desc = "Vertical terminal" })
    vim.keymap.set("n", "<leader>cr", function() cargo_run:toggle() end, { desc = "Cargo run" })
    vim.keymap.set("n", "<leader>cb", function() cargo_build:toggle() end, { desc = "Cargo build" })
    vim.keymap.set("n", "<leader>ct", function() cargo_test:toggle() end, { desc = "Cargo test" })
  end,
}

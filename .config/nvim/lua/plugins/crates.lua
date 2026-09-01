return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  config = function()
    require("crates").setup({
      popup = {
        border = "rounded",
      },
    })

    vim.keymap.set("n", "<leader>cv", function()
      require("crates").show_versions_popup()
    end, { desc = "Crate versions" })

    vim.keymap.set("n", "<leader>cf", function()
      require("crates").show_features_popup()
    end, { desc = "Crate features" })

    vim.keymap.set("n", "<leader>cu", function()
      require("crates").update_crate()
    end, { desc = "Update crate" })

    vim.keymap.set("n", "<leader>cU", function()
      require("crates").update_all_crates()
    end, { desc = "Update all crates" })
  end,
}

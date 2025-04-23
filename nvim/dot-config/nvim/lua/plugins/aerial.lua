return {
  "stevearc/aerial.nvim",
  opts = {
    -- optional: automatically open on lsp attach
    on_attach = function(bufnr)
      -- keymaps for aerial
      vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { buffer = bufnr, desc = "Toggle Aerial Outline" })
    end,
    layout = {
      max_width = { 40, 0.2 },
      min_width = 20,
    },
    filter_kind = false, -- show all symbol kinds by default
    show_guides = true,
  },
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function(_, opts)
    require("aerial").setup(opts)
  end,
}

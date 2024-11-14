return {
  {
    -- Telescope plugin and integration with git-worktree
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "ThePrimeagen/git-worktree.nvim" },
    config = function()
      local telescope = require("telescope")

      -- Load Telescope and git-worktree extensions
      telescope.setup({
        defaults = {
          prompt_prefix = "> ",
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
        },
        extensions = {
          -- Optional: add specific extensions or configurations here
        },
      })

      -- Load the git-worktree extension for Telescope
      telescope.load_extension("git_worktree")

      -- Set up keymaps for Telescope git-worktree extension
      vim.keymap.set("n", "<leader>gtw", function()
        telescope.extensions.git_worktree.git_worktrees()
      end, { noremap = true, silent = true, desc = "List Git Worktrees" })
      vim.keymap.set("n", "<leader>gtn", function()
        telescope.extensions.git_worktree.create_git_worktree()
      end, { noremap = true, silent = true, desc = "Create New Git Worktree" })
    end,
  },
}

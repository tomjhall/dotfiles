-- ~/.config/nvim/lua/plugins/git-worktree.lua
return {
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      local worktree = require("git-worktree")

      -- Optionally configure git-worktree
      worktree.setup({
        -- Set up options here (these are the defaults)
        change_directory_command = "cd", -- Command to change directory
        update_on_change = true, -- Automatically update root directory when switching worktrees
        update_on_change_command = "e .", -- Command to execute when switching worktrees
        clearjumps_on_change = true, -- Clear jumps when worktree changes
        autopush = false, -- Auto-push worktrees when switching
      })

      -- Optionally, you can set up some useful keymaps for git-worktree
      vim.keymap.set("n", "<leader>gwc", function()
        worktree.create_worktree()
      end, { noremap = true, silent = true, desc = "Create Git Worktree" })
      vim.keymap.set("n", "<leader>gws", function()
        worktree.switch_worktree()
      end, { noremap = true, silent = true, desc = "Switch Git Worktree" })
      vim.keymap.set("n", "<leader>gwd", function()
        worktree.delete_worktree()
      end, { noremap = true, silent = true, desc = "Delete Git Worktree" })
    end,
  },
}

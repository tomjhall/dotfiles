-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>cb", ":make<CR>", { desc = "Build/Compile" })
vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", ":cprev<CR>", { desc = "Prev quickfix" })

-- Seamless herdr <-> nvim split navigation.
-- Move between nvim splits; when already at the edge split, hand focus to the
-- neighbouring herdr pane. (No tmux in the stack, so we talk to herdr directly.)
local function herdr_nav(vim_dir, herdr_dir)
  return function()
    local prev = vim.fn.winnr()
    vim.cmd("wincmd " .. vim_dir)
    if vim.fn.winnr() == prev then
      -- nvim didn't move -> we're at the edge, so move herdr's pane focus.
      vim.fn.system({ "herdr", "pane", "focus", "--direction", herdr_dir, "--current" })
    end
  end
end

vim.keymap.set("n", "<C-h>", herdr_nav("h", "left"), { silent = true, desc = "Nav left (nvim/herdr)" })
vim.keymap.set("n", "<C-j>", herdr_nav("j", "down"), { silent = true, desc = "Nav down (nvim/herdr)" })
vim.keymap.set("n", "<C-k>", herdr_nav("k", "up"), { silent = true, desc = "Nav up (nvim/herdr)" })
vim.keymap.set("n", "<C-l>", herdr_nav("l", "right"), { silent = true, desc = "Nav right (nvim/herdr)" })

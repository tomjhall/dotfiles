-- vim-tmux-navigator is disabled: there is no tmux in the stack (nvim runs
-- directly inside a herdr pane), so it can never cross the pane boundary.
-- Ctrl+h/j/k/l are handled by herdr-aware keymaps in lua/config/keymaps.lua,
-- which move between nvim splits and hand off to herdr panes at the edge.
return {
  "christoomey/vim-tmux-navigator",
  enabled = false,
}

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.dbs = {
  local_db = "postgres://postgres:postgres@localhost:5432/postgres",
  comp_local = "postgres://postgres:postgres@localhost:5436/postgres",
}

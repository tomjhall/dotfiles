vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.opt_local.makeprg = "yarn build"
    -- Handle ttsc/tsc error format: file(line,col): error TS####: message
    vim.opt_local.errorformat = "%f(%l\\,%c): %trror TS%n: %m,%f(%l\\,%c): %tarning TS%n: %m,%-G%.%#"
    -- or for TypeScript checking:
    -- vim.opt_local.makeprg = "npx tsc --noEmit --pretty false"
    -- vim.opt_local.errorformat = "%f(%l\\,%c): %trror TS%n: %m,%f(%l\\,%c): %tarning TS%n: %m"
  end,
})

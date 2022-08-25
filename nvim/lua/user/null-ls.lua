local ok, null_ls = pcall(require, 'null-ls')
if not ok then
  return
end

local M = {}
M.setup = function(attach)
  null_ls.setup {
    on_attach = attach,
    sources = {
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.prettierd,
    },
    cmd = { "nvim" },
    debounce = 250,
    debug = true,
    default_timeout = 5000,
    diagnostics_format = "#{m}",
    fallback_severity = vim.diagnostic.severity.ERROR,
    log_level = "info",
    notify_format = "[null-ls] %s",
    on_init = nil,
    on_exit = nil,
    update_in_insert = false,
  }
end

return M

local state = {}

local run_watch = function()
  vim.api.nvim_command('!' .. state.command)
end

local set_watch = function(opts)
  if opts.args == '' then
    if state.autocmd then
      vim.api.nvim_del_autocmd(state.autocmd)
    end
    state = {}
  end

  state.command = opts.args
  state.autocmd = vim.api.nvim_create_autocmd("BufWritePost", {
    callback = run_watch,
  })

end

local review_watch = function()
  if not state.autocmd then
    return
  end
  vim.api.nvim_notify(state.command, vim.log.levels.INFO, {})
end

local unset_watch = function()
  if not state.autocmd then
    vim.api.nvim_notify('No Watch to unset', vim.log.levels.INFO, {})
    return
  end
  vim.api.nvim_del_autocmd(state.autocmd)
end

vim.api.nvim_create_user_command('Watch', set_watch, { nargs = '*', complete = 'shellcmd' })
vim.api.nvim_create_user_command('WatchPeek', review_watch, {})
vim.api.nvim_create_user_command('WatchStop', unset_watch, {})

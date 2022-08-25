local ok, fterm = pcall(require, 'FTerm')
if not ok then
  return
end

fterm.setup {
  ---Filetype of the terminal buffer
  ---@type string
  ft = 'FTerm',

  ---Neovim's native window border. See `:h nvim_open_win` for more configuration options.
  border = 'rounded',

  ---Close the terminal as soon as shell/command exits.
  ---Disabling this will mimic the native terminal behaviour.
  ---@type boolean
  auto_close = true,

  ---Transparency of the floating window. See `:h winblend`
  ---@type integer
  -- blend = 0,

  dimensions = {
    height = 0.9, -- Height of the terminal window
    width = 0.9, -- Width of the terminal window
    x = 0.5, -- X axis of the terminal window
    y = 0.5, -- Y axis of the terminal window
  },
}

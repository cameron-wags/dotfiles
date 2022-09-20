local ok, indent_blankline = pcall(require, 'indent_blankline')
if not ok then
  return
end

vim.opt.listchars:append('space:⋅')

indent_blankline.setup {
  use_treesitter = true,
  filetype_exclude = { 'packer', 'toggleterm', 'help', 'SplashScreen' },
  space_char_blankline = ' ',
  show_current_context = true,
  show_current_context_start = false,
}

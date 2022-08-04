vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha
local catppuccin_ok, catppuccin = pcall(require, 'catppuccin')
if not catppuccin_ok then
  return
end

catppuccin.setup {
  dim_inactive = {
    enabled = false,
    shade = 'dark',
    percentage = 0.15,
  },
  transparent_background = false,
  term_colors = true,
  compile = {
    enabled = true,
    path = vim.fn.stdpath 'cache' .. '/catppuccin',
    suffix = '_compiled',
  },
  styles = {
    comments = { 'italic', 'bold' },
    functions = { 'italic' },
    keywords = { 'italic' },
    strings = {},
    variables = {},
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
    bufferline = true,
    cmp = true,
    dashboard = true,
    gitsigns = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    nvimtree = {
      enabled = true,
      show_root = true,
    },
    telescope = true,
  },
}

local colorscheme = 'catppuccin'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  return
end

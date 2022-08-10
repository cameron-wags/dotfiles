vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha

local catppuccin_ok, catppuccin = pcall(require, 'catppuccin')
if not catppuccin_ok then
  return
end

local palettes_ok, palettes = pcall(require, 'catppuccin.palettes')
if not palettes_ok then
  return
end
local mocha = palettes.get_palette 'mocha'

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
  highlight_overrides = {
    mocha = {
      VertSplit = {
        fg = mocha.text,
      },
      Comment = {
        fg = mocha.overlay0,
      }
    },
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
    coc_nvim = false,
    lsp_trouble = false,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    leap = false,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = true,
    },
    dap = {
      enabled = false,
      enable_ui = false,
    },
    which_key = false,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = false,
    ts_rainbow = true,
    hop = false,
    notify = true,
    symbols_outline = true
  },
}

local colorscheme = 'catppuccin'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  return
end

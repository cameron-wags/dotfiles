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
  transparent_background = false,
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
  custom_highlights = function(colors)
    return {
      Cursor = {
        fg = colors.base,
        bg = colors.text,
      },
      lCursor = {
        fg = colors.base,
        bg = colors.text,
      },
    }
  end,
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

-- local set_gruvbox = function()
-- local ok, gruvbox = pcall(require, 'gruvbox')
-- if not ok then
--   return
-- end

-- gruvbox.setup {
--   undercurl = true,
--   underline = true,
--   bold = true,
--   italic = true,
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = true,
--   invert_intend_guides = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "hard", -- can be "hard", "soft" or empty string
--   overrides = {},
--   dim_inactive = false,
--   transparent_mode = false,
-- }

-- vim.o.background = 'light'
-- vim.api.nvim_command('colo gruvbox')
-- end

-- vim.api.nvim_create_user_command('Lights', set_gruvbox, {})

local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

local symbols = {
  -- unix = ' ',
  unix = '',
  dos = ' ',
  mac = ' ',
}

-- Tell me if the file isn't utf-8 or unix line endings.
local fileinfo_ignore_norms = function()
  local ret, _ = (vim.bo.fenc or vim.go.enc):gsub('^utf%-8$', '')
  local fmt = vim.bo.fileformat
  ret = ret .. (symbols[fmt] or fmt)
  return ret
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'toggleterm' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch' },
      {
        'diff',
        symbols = { added = ' ', modified = '柳', removed = ' ' },
        diff_color = {
          added = { fg = '#98be65' },
          modified = { fg = '#FF8800' },
          removed = { fg = '#ec5f67' },
        },
      },
    },
    lualine_c = {
      { 'filename', path = 1, color = { fg = '#ffffff' } },
      { 'filesize' },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        -- colored = false,
        update_in_insert = false,
        always_visible = false,
        symbols = {
          error = '✗',
          warn = '!',
          info = '',
          hint = '',
        },
        -- padding = { left = 1, right = 2 },
      },
      fileinfo_ignore_norms,
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { 'nvim-tree' },
  tabline = {
    lualine_a = {
      {
        'buffers',
        show_filename_only = true, -- Shows shortened relative path when set to false.
        hide_filename_extension = false, -- Hide filename extension when set to true.
        show_modified_status = true, -- Shows indicator when the buffer is modified.

        mode = 0,

        max_length = vim.o.columns, -- Maximum width of buffers component,
        -- it can also be a function that returns
        -- the value of `max_length` dynamically.
        filetype_names = {
          TelescopePrompt = 'Telescope',
          packer = 'Packer',
        },

        padding = 2,

        symbols = {
          modified = ' ●', -- Text to show when the buffer is modified
          alternate_file = '', -- Text to show to identify the alternate file
          directory = '', -- Text to show when the buffer is a directory
        },
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}

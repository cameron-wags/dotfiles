local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

local encoding_ignore_utf8 = function()
  local ret, _ = (vim.bo.fenc or vim.go.enc):gsub('^utf%-8$', '')
  return ret
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
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
    lualine_x = { encoding_ignore_utf8, 'fileformat', 'filetype' },
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
}

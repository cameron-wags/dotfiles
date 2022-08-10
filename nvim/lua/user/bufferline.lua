local bufferline_ok, bufferline = pcall(require, 'bufferline')
if not bufferline_ok then
  return
end

bufferline.setup {
  options = {
    mode = 'buffers',
    numbers = 'none',
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match('error') and ' ' or ' '
      return icon .. count
    end,
    separator_style = 'thick',
    show_buffer_close_icons = false,
    show_close_icon = false,
    offsets = { {
      filetype = 'NvimTree',
      text = function()
        return vim.fn.getcwd()
      end,
      highlight = 'Directory',
      text_align = 'left'
    } }
  }
}

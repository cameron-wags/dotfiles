local bufferline_ok, bufferline = pcall(require, 'bufferline')
if not bufferline_ok then
  return
end

bufferline.setup {
  options = {
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match('error') and ' ' or ' '
      return ' ' .. icon .. count
    end,
    separator_style = 'thick',
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

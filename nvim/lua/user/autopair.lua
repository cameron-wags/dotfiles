local status_ok, nvim_autopairs = pcall(require, 'nvim-autopairs')
if not status_ok then
  return
end

nvim_autopairs.setup {
  check_ts = true,
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
    java = false,
  },
  disable_filetype = { 'TelescopePrompt' },
  disable_in_macro = true,
  disable_in_visualblock = true,
  enable_check_bracket_line = true,
  fast_wrap = {
    map = '<M-a>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0, -- Offset from pattern match
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'PmenuSel',
    highlight_grey = 'LineNr',
  },
}

-- Integrate autopairs with cmp
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

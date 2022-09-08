local version = vim.api.nvim_exec(':version', true)
local maxlen = 0
local lines = {}
for line in string.gmatch(version, '([^\r\n]+)') do
  local l = string.len(line)
  if l > maxlen then
    maxlen = l
  end
  table.insert(lines, line)
end

require 'splash'.setup {
  text = lines,
  text_width = maxlen,
}

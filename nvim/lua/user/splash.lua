local ok, splash = pcall(require, 'splash')
if not ok then
  return
end

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

splash.setup {
  text = lines,
  text_width = maxlen,
}

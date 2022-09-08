local ext_map = {
  lsp = {}
}

local map = function(mode, bind, action, opts)
  opts = opts or { noremap = true }
  vim.keymap.set(mode, bind, action, opts)
end

--Clear hlsearch with return
map('n', '<CR>', '<Cmd>noh<CR>')

-- Linewise toggle current line using C-/
map('n', '<C-/>', '<Plug>(comment_toggle_linewise_current)')
-- Linewise toggle on visual selection using C-/
map('x', '<C-/>', '<Plug>(comment_toggle_linewise_visual)')
-- C-/ sends this on some platforms
map('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)')
map('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)')

-- Disable Arrow keys in Normal mode
map('', '<up>', '')
map('', '<down>', '')
map('', '<left>', '')
map('', '<right>', '')

-- Disable Arrow keys in Insert mode
map('i', '<up>', '')
map('i', '<down>', '')
map('i', '<left>', '')
map('i', '<right>', '')

-- Buffer cycle
map('n', '<S-TAB>', '<Cmd>bnext<CR>')
-- map('n', '<C-S-TAB>', '<Cmd>bprevious<CR>')
map('n', '<leader>h', '<Cmd>bprevious<CR>')
map('n', '<leader>l', '<Cmd>bnext<CR>')
map('n', '<leader>q', '<Cmd>bdelete!<CR>')
map('n', '<leader>t', '<Cmd>enew<CR>')

-- Resize with arrows
map('n', '<C-Up>', '<Cmd>resize +2<CR>')
map('n', '<C-Down>', '<Cmd>resize -2<CR>')
map('n', '<C-Left>', '<Cmd>vertical resize -2<CR>')
map('n', '<C-Right>', '<Cmd>vertical resize +2<CR>')

-- Change windows
map('n', '<M-h>', '<Cmd>winc h<CR>')
map('n', '<M-j>', '<Cmd>winc j<CR>')
map('n', '<M-k>', '<Cmd>winc k<CR>')
map('n', '<M-l>', '<Cmd>winc l<CR>')

-- Integrated terminal
map('n', '<M-i>', require 'FTerm'.toggle)
map('t', '<M-i>', require 'FTerm'.toggle, {})

-- Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Telescope formatters
local tscope = require('telescope.builtin')
map('n', '<leader>,', tscope.buffers)
map('n', '<leader>.', tscope.find_files)
map('n', '<leader>fr', tscope.oldfiles)
map('n', '<leader>fg', tscope.live_grep)
map('n', '<leader>fh', tscope.help_tags)
map('n', '<leader>gr', tscope.lsp_references)
map('n', '<leader>gd', tscope.lsp_definitions)
map('n', '<leader>gs', tscope.lsp_document_symbols)

-- Moving the selected line from Visual Mode
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Nvim Tree
map('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>')

local lsp_map = function(m, b, a)
  table.insert(ext_map.lsp, { mode = m, bind = b, action = a })
end

lsp_map('n', 'gD', vim.lsp.buf.declaration)
lsp_map('n', 'gd', vim.lsp.buf.definition)
lsp_map('n', 'K', vim.lsp.buf.hover)
-- lsp_map('n', 'gi', vim.lsp.buf.implementation)
lsp_map('n', '<C-k>', vim.lsp.buf.signature_help)
lsp_map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
lsp_map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
lsp_map('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
lsp_map('n', 'gr', vim.lsp.buf.references)
lsp_map('n', '<leader>rn', vim.lsp.buf.rename)
lsp_map('n', '<leader>ca', vim.lsp.buf.code_action)
lsp_map('n', '<leader>of', vim.diagnostic.open_float)
lsp_map('n', '[d', vim.diagnostic.goto_prev)
lsp_map('n', ']d', vim.diagnostic.goto_next)
lsp_map('n', '<leader>p', function() vim.lsp.buf.format { async = true } end)

return ext_map

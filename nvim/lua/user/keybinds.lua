local ext_map = {
  lsp = {}
}

local map = function(mode, bind, action, opts)
  opts = opts or { noremap = true }
  vim.keymap.set(mode, bind, action, opts)
end

--Remap space as leader key
map('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '

--Clear hlsearch with return
map('n', '<CR>', ':noh<CR>')

-- Linewise toggle current line using C-/
map('n', '<C-/>', '<Plug>(comment_toggle_current_linewise)')
-- Linewise toggle on visual selection using C-/
map('x', '<C-/>', '<Plug>(comment_toggle_linewise_visual)')
-- C-/ sends this on some platforms
map('n', '<C-_>', '<Plug>(comment_toggle_current_linewise)')
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
map('n', '<S-TAB>', ':bnext<CR>')
map('n', '<C-S-TAB>', ':bprevious<CR>')
map('n', '<leader>q', ':bdelete!<CR>')
map('n', '<C-s>', ':w<CR>')
map('n', '<leader>t', ':enew<CR>')

-- Resize with arrows
map('n', '<C-Up>', ':resize +2<CR>')
map('n', '<C-Down>', ':resize -2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- Change windows
map('n', '<M-h>', ':winc h<CR>')
map('n', '<M-j>', ':winc j<CR>')
map('n', '<M-k>', ':winc k<CR>')
map('n', '<M-l>', ':winc l<CR>')

-- Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Telescope formatters
map('n', '<leader>fr', require 'telescope.builtin'.oldfiles)
map('n', '<leader>fb', require 'telescope.builtin'.buffers)
map('n', '<leader>fo', require 'telescope.builtin'.find_files)
map('n', '<leader>fg', require 'telescope.builtin'.live_grep)
map('n', '<leader>fh', require 'telescope.builtin'.help_tags)

-- Moving the selected line from Visual Mode
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Nvim Tree
map('n', '<M-e>', ':NvimTreeToggle<CR>')
map('n', '<leader>e', ':NvimTreeToggle<CR>')

local lsp_map = function(m, b, a)
  table.insert(ext_map.lsp, { mode = m, bind = b, action = a })
end

lsp_map('n', 'gD', vim.lsp.buf.declaration)
lsp_map('n', 'gd', vim.lsp.buf.definition)
lsp_map('n', 'K', vim.lsp.buf.hover)
lsp_map('n', 'gi', vim.lsp.buf.implementation)
lsp_map('n', '<C-k>', vim.lsp.buf.signature_help)
lsp_map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
lsp_map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
lsp_map('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
lsp_map('n', '<leader>rn', vim.lsp.buf.rename)
lsp_map('n', '<leader>ca', vim.lsp.buf.code_action)
lsp_map('n', 'gr', vim.lsp.buf.references)
lsp_map('n', '<leader>of', vim.diagnostic.open_float)
lsp_map('n', '[d', vim.diagnostic.goto_prev)
lsp_map('n', ']d', vim.diagnostic.goto_next)
lsp_map('n', '<leader>ff', vim.lsp.buf.formatting)
-- lsp_map('n', '<leader>q', vim.diagnostic.setloclist)

return ext_map

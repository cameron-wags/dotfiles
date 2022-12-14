local map = function(mode, bind, action, opts)
	opts = opts or { noremap = true }
	vim.keymap.set(mode, bind, action, opts)
end

--Clear hlsearch with return
map('n', '<leader><CR>', '<Cmd>noh<CR>')

-- Linewise toggle current line using C-/
-- map('n', '<C-/>', '<Plug>(comment_toggle_linewise_current)')
-- Linewise toggle on visual selection using C-/
-- map('x', '<C-/>', '<Plug>(comment_toggle_linewise_visual)')
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
map('n', '<leader>h', '<Cmd>bp<CR>')
map('n', '<leader>l', '<Cmd>bn<CR>')
map('n', '<C-h>', '<Cmd>bp<CR>')
map('n', '<C-l>', '<Cmd>bn<CR>')
-- map('n', '<leader>q', '<Cmd>bd!<CR>')
map('n', '<leader>q', '<Cmd>bp|bd!#<CR>')
map('n', '<leader>t', '<Cmd>enew<CR>')

-- Resize with arrows
map('n', '<M-Up>', '<Cmd>resize +2<CR>')
map('n', '<M-Down>', '<Cmd>resize -2<CR>')
map('n', '<M-Left>', '<Cmd>vertical resize -2<CR>')
map('n', '<M-Right>', '<Cmd>vertical resize +2<CR>')

-- Change windows
map('n', '<M-h>', '<Cmd>winc h<CR>')
map('n', '<M-j>', '<Cmd>winc j<CR>')
map('n', '<M-k>', '<Cmd>winc k<CR>')
map('n', '<M-l>', '<Cmd>winc l<CR>')

-- Integrated terminal
map('n', '<M-;>', function() require 'FTerm'.toggle() end)
map('t', '<M-;>', function() require 'FTerm'.toggle() end, {})

-- Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Telescope formatters
local function tscope(fn)
	return function()
		require 'telescope.builtin'[fn]()
	end
end

map('n', '<leader>,', tscope 'buffers')
map('n', '<leader>.', tscope 'find_files')
map('n', '<leader>fr', tscope 'oldfiles')
map('n', '<leader>fg', tscope 'live_grep')
map('n', '<leader>fh', tscope 'help_tags')
map('n', '<leader>gr', tscope 'lsp_references')
map('n', '<leader>gd', tscope 'lsp_definitions')
map('n', '<leader>gs', tscope 'lsp_document_symbols')

-- Moving the selected line from Visual Mode
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Nvim Tree
map('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>')

-- open urls under the cursor
if vim.fn.has('mac') then
	map('n', 'gx', '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>')
elseif vim.fn.has('unix') then
	map('n', 'gx', '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>')
else
	vim.api.nvim_notify("It's time to set up open again", vim.log.levels.WARN, {})
end

map('n', '<leader>p', function() vim.lsp.buf.format { async = true } end)
map('n', '<leader>rn', vim.lsp.buf.rename)
map('n', '<leader>ca', vim.lsp.buf.code_action)
map('n', '<leader>d', vim.diagnostic.open_float)

-- return ext_map

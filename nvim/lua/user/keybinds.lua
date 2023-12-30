local function mkmap(mode, noremap)
	return function(bind, action, desc)
		vim.keymap.set(mode, bind, action, { noremap = noremap, desc = desc })
	end
end

local nn = mkmap('n', true)
local xn = mkmap('x', true)
local vn = mkmap('v', true)
local ino = mkmap('i', true)
local tma = mkmap('t', false)

--Clear hlsearch with return
nn('<leader><CR>', '<Cmd>noh<CR>', 'Clear search highlights')

local esc = vim.api.nvim_replace_termcodes(
	'<ESC>', true, false, true
)
nn('<C-/>', function() require 'Comment.api'.toggle.linewise.current() end, 'Comment - toggle current line')
xn('<C-/>',
	function()
		vim.api.nvim_feedkeys(esc, 'nx', false)
		require 'Comment.api'.toggle.linewise(vim.fn.visualmode())
	end, 'Comment - toggle visual selection')
-- C-/ sends this on some platforms
nn('<C-_>', function() require 'Comment.api'.toggle.linewise.current() end, 'Comment - toggle current line')
xn('<C-_>', function()
	vim.api.nvim_feedkeys(esc, 'nx', false)
	require 'Comment.api'.toggle.linewise(vim.fn.visualmode())
end, 'Comment - toggle visual selection')

-- Buffer cycle
nn('<leader>h', '<Cmd>bp<CR>', 'Buffer - goto previous')
nn('<leader>l', '<Cmd>bn<CR>', 'Buffer - goto next')
nn('<C-h>', '<Cmd>bp<CR>', 'Buffer - goto previous')
nn('<C-l>', '<Cmd>bn<CR>', 'Buffer - goto next')
nn('<leader>q', '<Cmd>bp|bd!#<CR>', 'Buffer - close without saving')
nn('<leader>w', '<Cmd>w<CR>', 'Buffer - Write')
nn('<leader>t', '<Cmd>enew<CR>', 'Buffer - create new')

-- Resize with arrows
nn('<M-Up>', '<Cmd>resize +2<CR>', 'Split - make taller')
nn('<M-Down>', '<Cmd>resize -2<CR>', 'Split - make shorter')
nn('<M-Left>', '<Cmd>vertical resize -2<CR>', 'Split - make narrower')
nn('<M-Right>', '<Cmd>vertical resize +2<CR>', 'Split - make wider')

-- Change windows
nn('<M-h>', '<Cmd>winc h<CR>', 'Window - navigate left')
nn('<M-j>', '<Cmd>winc j<CR>', 'Window - navigate down')
nn('<M-k>', '<Cmd>winc k<CR>', 'Window - navigate up')
nn('<M-l>', '<Cmd>winc l<CR>', 'Window - navigate right')

-- Moving the selected line from Visual Mode
vn('J', ":m '>+1<CR>gv=gv", 'Move visual selection down')
vn('K', ":m '<-2<CR>gv=gv", 'Move visual selection up')

-- Integrated terminal
local fterm_lazygit = nil
nn('<M-;>', function()
	if fterm_lazygit then
		fterm_lazygit:close()
	end
	require 'FTerm'.open()
end, 'FTerm - toggle')

tma('<M-;>', function()
	if fterm_lazygit then
		fterm_lazygit:close()
	end
	require 'FTerm'.close()
end, 'FTerm - toggle')

nn('<leader>s', function()
	if not fterm_lazygit then
		fterm_lazygit = require 'FTerm':new {
			cmd = 'lazygit',
			border = 'rounded',
			auto_close = true,
			dimensions = {
				height = 1.0,
				width = 1.0,
				x = 0.5,
				y = 0.5,
			},
		}
	end
	fterm_lazygit:open()
end, 'Lazygit - open')

nn('<leader>o', function() require 'oil'.open_float() end, 'Oil - open')

-- Stay in indent mode
vn('<', '<gv', 'Unindent line(s)')
vn('>', '>gv', 'Indent lines(s)')

-- Telescope formatters
local function tscope(fn)
	return function()
		require 'telescope.builtin'[fn]()
	end
end

nn('<leader>,', tscope 'buffers', 'Telescope - buffers')
nn('<leader>.', tscope 'find_files', 'Telescope - project files')
nn('<leader>fr', tscope 'oldfiles', 'Telescope - oldfiles')
nn('<leader>fg', tscope 'live_grep', 'Telescope - grep in project')
nn('<leader>fh', tscope 'help_tags', 'Telescope - vim help')
nn('<leader>gr', tscope 'lsp_references', 'Telescope - current symbol references')
nn('<leader>gd', tscope 'lsp_definitions', 'Telescope - current symbol definitions')
nn('<leader>gs', tscope 'lsp_document_symbols', 'Telescope - current file symbols')

-- Nvim Tree
nn('<leader>e', '<Cmd>NvimTreeToggle<CR>', 'NvimTree - toggle')

-- open urls under the cursor
if vim.fn.has('mac') then
	nn('gx', '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>', 'Open URL under cursor')
elseif vim.fn.has('unix') then
	nn('gx', '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', 'Open URL under cursor')
else
	vim.api.nvim_notify("It's time to set up open again", vim.log.levels.WARN, {})
end

nn('<leader>p', function() vim.lsp.buf.format { async = true } end, 'Format document')
nn('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
nn('<leader>ca', vim.lsp.buf.code_action, 'Code actions')
nn('<leader>d', vim.diagnostic.open_float, 'Diagnostics - open float')

local function mkmap(mode, noremap)
	return function(bind, action, desc, opts)
		opts = opts or {}
		vim.keymap.set(mode, bind, action, vim.tbl_deep_extend('keep', opts, { noremap = noremap, desc = desc }))
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
		vim.schedule(function()
			vim.cmd.checktime()
		end)
	end
	require 'FTerm'.close()
end, 'FTerm - toggle')

nn('<leader>g', '<cmd>:Git<CR>', 'Fugitive - open')

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

-- open urls under the cursor
if vim.fn.has('mac') then
	nn('gx', '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>', 'Open URL under cursor')
elseif vim.fn.has('unix') then
	nn('gx', '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', 'Open URL under cursor')
else
	vim.api.nvim_notify("It's time to set up open again", vim.log.levels.WARN, {})
end

local function close_floats()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative == "win" then
			vim.api.nvim_win_close(win, false)
		end
	end
end
-- keep an eye on this one
nn('<Esc>', close_floats, 'Close floats', { noremap = nil })

nn('<leader>e', '<Cmd>NvimTreeToggle<CR>', 'NvimTree - toggle')

nn('<leader>,', tscope 'buffers', 'Telescope - buffers')
nn('<leader>.', tscope 'find_files', 'Telescope - project files')
nn('<leader>fr', tscope 'oldfiles', 'Telescope - oldfiles')
nn('<leader>fg', tscope 'live_grep', 'Telescope - grep in project')
nn('<leader>fh', tscope 'help_tags', 'Telescope - vim help')

-- lsp related keybinds
nn('gr', tscope 'lsp_references', 'Telescope - current symbol references')
nn('gd', tscope 'lsp_definitions', 'Telescope - current symbol definitions')
nn('gs', tscope 'lsp_document_symbols', 'Telescope - current file symbols')

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local opts = { buffer = event.buf }

		nn('K', vim.lsp.buf.hover, 'LSP Hover', opts)
		nn('gD', vim.lsp.buf.declaration, 'Goto declaration', opts)
		nn('gi', vim.lsp.buf.implementation, 'Goto implementation', opts)
		nn('go', vim.lsp.buf.type_definition, 'Goto type definition', opts)
		ino('<C-k>', vim.lsp.buf.signature_help, 'Signature help', opts)
		nn('<leader>p', function() vim.lsp.buf.format { async = true } end, 'Format document', opts)
		nn('<leader>rn', vim.lsp.buf.rename, 'Rename symbol', opts)
		nn('<leader>ca', vim.lsp.buf.code_action, 'Code actions', opts)
	end
})

nn('[d', vim.diagnostic.goto_prev, 'Diagnostic - goto previous')
nn(']d', vim.diagnostic.goto_next, 'Diagnostic - goto next')
nn('<leader>d', vim.diagnostic.open_float, 'Diagnostics - open float')

nn('<leader>D', function()
	require 'lsp_lines'
	if vim.b.lsp_lines_enabled then
		vim.b.lsp_lines_enabled = false
		vim.diagnostic.config {
			virtual_text = true,
			virtual_lines = false,
		}
	else
		vim.b.lsp_lines_enabled = true
		vim.diagnostic.config {
			virtual_text = false,
			virtual_lines = true,
		}
	end
end, 'Diagnostics - enable lsp_lines')

-- git stuff
nn(']c', function()
	if vim.wo.diff then
		vim.cmd.normal({ ']c', bang = true })
	else
		require 'gitsigns'.nav_hunk('next', { preview = true, })
		vim.api.nvim_feedkeys('zz', 'n', false)
	end
end)

nn('[c', function()
	if vim.wo.diff then
		vim.cmd.normal({ '[c', bang = true })
	else
		require 'gitsigns'.nav_hunk('prev', { preview = true, })
		vim.api.nvim_feedkeys('zz', 'n', false)
	end
end)

nn('<leader>hl', function()
		require 'gitsigns'.refresh()
		require 'gitsigns'.setqflist('all', { use_location_list = true })
	end,
	'Gitsigns - Location list hunks')
nn('<leader>s', function()
	require 'gitsigns'.stage_hunk()
	close_floats()
end, 'Gitsigns - Stage hunk')
vn('<leader>s', function() require 'gitsigns'.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
	'Gitsigns - Stage range')
nn('<leader>S', function() require 'gitsigns'.stage_buffer() end, 'Gitsigns - Stage buffer')
nn('<leader>hu', function() require 'gitsigns'.undo_stage_hunk() end, 'Gitsigns - Undo last stage hunk')
nn('<leader>hr', function() require 'gitsigns'.reset_hunk() end, 'Gitsigns - Reset hunk')
vn('<leader>hr', function() require 'gitsigns'.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
	'Gitsigns - Reset range')

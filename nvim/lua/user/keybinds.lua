local function mkmap(mode, noremap)
	return function(bind, action, desc, opts)
		opts = opts or {}
		vim.keymap.set(mode, bind, action,
			vim.tbl_deep_extend('keep', opts, { remap = not noremap, desc = desc }))
	end
end

local nn = mkmap('n', true)
local nm = mkmap('n', false)
local xm = mkmap('x', false)
local vn = mkmap('v', true)
local ino = mkmap('i', true)
local tno = mkmap('t', true)

nn('<leader><CR>', '<Cmd>noh<CR>', 'Clear search highlights')

nm('<C-/>', 'gcc', 'Comment - toggle current line')
nm('<C-_>', 'gcc', 'Comment - toggle current line')
xm('<C-/>', 'gc', 'Comment - toggle selected lines')
xm('<C-_>', 'gc', 'Comment - toggle selected lines')

nn('<leader>q', '<Cmd>bp|bd!#<CR>', 'Buffer - close without saving') -- todo make this ctrl-o after closing the buffer
nn('<leader>t', '<Cmd>enew<CR>', 'Buffer - create new')
nn('<leader>w', function()
	pcall(vim.lsp.buf.format)
	vim.schedule(function() vim.cmd.w() end)
end, 'Buffer - Format and Write')

nn('<M-Up>', '<Cmd>resize +2<CR>', 'Split - make taller')
nn('<M-Down>', '<Cmd>resize -2<CR>', 'Split - make shorter')
nn('<M-Left>', '<Cmd>vertical resize -2<CR>', 'Split - make narrower')
nn('<M-Right>', '<Cmd>vertical resize +2<CR>', 'Split - make wider')

nn('<M-h>', '<Cmd>winc h<CR>', 'Window - navigate left')
nn('<M-j>', '<Cmd>winc j<CR>', 'Window - navigate down')
nn('<M-k>', '<Cmd>winc k<CR>', 'Window - navigate up')
nn('<M-l>', '<Cmd>winc l<CR>', 'Window - navigate right')
nn('<leader>h', '<Cmd>winc h<CR>', 'Window - navigate left')
nn('<leader>j', '<Cmd>winc j<CR>', 'Window - navigate down')
nn('<leader>k', '<Cmd>winc k<CR>', 'Window - navigate up')
nn('<leader>l', '<Cmd>winc l<CR>', 'Window - navigate right')

vn('J', ":m '>+1<CR>gv=gv", 'Move visual selection down')
vn('K', ":m '<-2<CR>gv=gv", 'Move visual selection up')
vn('<', '<gv', 'Unindent visual selection')
vn('>', '>gv', 'Indent visual selection')

nn('<leader>;', function()
	vim.cmd 'Term'
end, 'Terminal - open')
tno(';;', function()
	vim.cmd 'TermClose'
end, 'Terminal - close')

nn('<leader>g', '<cmd>:tab G<CR>', 'Fugitive - open')
nn('<leader>o', function() require 'oil'.open_float() end, 'Oil - open')


nn('gx', function()
	local url = vim.fn.expand("<cfile>")
	if vim.fn.has('mac') then
		vim.system({ 'open', url }, { detach = true })
	elseif vim.fn.has('unix') then
		vim.system({ 'xdg-open', url }, { detach = true })
	else
		vim.notify("It's time to set up open again", vim.log.levels.WARN)
	end
end, 'Open URL under cursor')

nn('<leader>ft', '<Cmd>TodoTelescope<CR>', 'Telescope - Project TODOs')

-- keep an eye on this one
local function close_floats()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative == "win" then
			vim.api.nvim_win_close(win, false)
		end
	end
end
nn('<Esc>', close_floats, 'Close floats', { noremap = nil })

local function tscope(fn)
	return function()
		require 'telescope.builtin'[fn]()
	end
end
nn('<leader>,', tscope 'buffers', 'Telescope - buffers')
nn('<leader>.', function()
	require 'telescope.builtin'.find_files { cwd = vim.fn.getcwd() }
end, 'Telescope - project files')
nn('<leader>fr', tscope 'oldfiles', 'Telescope - oldfiles')
nn('<leader>fg', tscope 'live_grep', 'Telescope - grep in project')
nn('<leader>fh', tscope 'help_tags', 'Telescope - vim help')

nn('gr', tscope 'lsp_references', 'Telescope - current symbol references')
nn('gd', tscope 'lsp_definitions', 'Telescope - current symbol definitions')
nn('gs', tscope 'lsp_document_symbols', 'Telescope - current file symbols')

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local opts = { buffer = event.buf }

		nn('gD', vim.lsp.buf.declaration, 'Goto declaration', opts)
		nn('gi', vim.lsp.buf.implementation, 'Goto implementation', opts)
		nn('go', vim.lsp.buf.type_definition, 'Goto type definition', opts)
		ino('<C-k>', vim.lsp.buf.signature_help, 'Signature help', opts)
		nn('<leader>p', function() vim.lsp.buf.format { async = true } end, 'Format document', opts)
		nn('<leader>ca', vim.lsp.buf.code_action, 'Code actions', opts)
	end
})

nn('[d', function() vim.diagnostic.jump { count = -1, float = true } end, 'Diagnostic - goto previous')
nn(']d', function() vim.diagnostic.jump { count = 1, float = true } end, 'Diagnostic - goto next')
nn('<leader>d', vim.diagnostic.open_float, 'Diagnostics - open float')

nn('<leader>D', function()
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

local ftbinds = {
	-- buffer-local keybinds based on filetype
	-- NOTE: all maps should be buffer-local `{ buffer = true }`
	['fugitive'] = function(args)
		nm('<Esc>', 'gq', 'Fugitive - close', { buffer = true })
		-- todo commit & push
	end
}

local ft_bufs = {}
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '*',
	callback = function(args)
		if ftbinds[vim.bo.filetype] then
			ftbinds[vim.bo.filetype](args)
			ft_bufs[vim.bo.filetype .. args.buf] = true
		end
	end
})

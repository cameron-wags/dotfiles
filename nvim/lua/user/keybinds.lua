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
local tma = mkmap('t', false)

local function make_lazy_require_module(mod)
	return setmetatable({}, {
		__index = function(_, k)
			return function(...)
				local theargs = { ... }
				return function() require(mod)[k](unpack(theargs)) end
			end
		end
	})
end

nn('<leader><CR>', '<Cmd>noh<CR>', 'Clear search highlights')

nm('<C-/>', 'gcc', 'Comment - toggle current line')
nm('<C-_>', 'gcc', 'Comment - toggle current line')
xm('<C-/>', 'gc', 'Comment - toggle selected lines')
xm('<C-_>', 'gc', 'Comment - toggle selected lines')

nn('<leader>q', '<Cmd>bp|bd!#<CR>', 'Buffer - close without saving')
nn('<leader>w', '<Cmd>w<CR>', 'Buffer - Write')
nn('<leader>t', '<Cmd>enew<CR>', 'Buffer - create new')

nn('<M-Up>', '<Cmd>resize +2<CR>', 'Split - make taller')
nn('<M-Down>', '<Cmd>resize -2<CR>', 'Split - make shorter')
nn('<M-Left>', '<Cmd>vertical resize -2<CR>', 'Split - make narrower')
nn('<M-Right>', '<Cmd>vertical resize +2<CR>', 'Split - make wider')

nn('<M-h>', '<Cmd>winc h<CR>', 'Window - navigate left')
nn('<M-j>', '<Cmd>winc j<CR>', 'Window - navigate down')
nn('<M-k>', '<Cmd>winc k<CR>', 'Window - navigate up')
nn('<M-l>', '<Cmd>winc l<CR>', 'Window - navigate right')

vn('J', ":m '>+1<CR>gv=gv", 'Move visual selection down')
vn('K', ":m '<-2<CR>gv=gv", 'Move visual selection up')
vn('<', '<gv', 'Unindent visual selection')
vn('>', '>gv', 'Indent visual selection')

nn('<M-;>', function()
	require 'FTerm'.open()
end, 'FTerm - open')
tma('<M-;>', function()
	require 'FTerm'.close()
	vim.schedule(function()
		vim.cmd.checktime()
	end)
end, 'FTerm - close')

nn('<leader>g', '<cmd>:Git<CR>', 'Fugitive - open')
nn('<leader>o', function() require 'oil'.open_float() end, 'Oil - open')
nn('<leader>e', '<Cmd>NvimTreeToggle<CR>', 'NvimTree - toggle')


nn('gx', function()
	local url = vim.fn.expand("<cfile>")
	if vim.fn.has('mac') then
		vim.system({ 'open', url }, { detach = true })
	elseif vim.fn.has('unix') then
		vim.system({ 'xdg-open', url }, { detach = true })
	else
		vim.api.nvim_notify("It's time to set up open again", vim.log.levels.WARN, {})
	end
end, 'Open URL under cursor')

-- keep an eye on this one
local function close_floats()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative == "win" then
			vim.api.nvim_win_close(win, false)
		end
	end
end
nn('<Esc>', close_floats, 'Close floats', { noremap = nil })

local tscope = make_lazy_require_module 'telescope.builtin'
nn('<leader>,', tscope.buffers(), 'Telescope - buffers')
nn('<leader>.', tscope.find_files(), 'Telescope - project files')
nn('<leader>fr', tscope.oldfiles(), 'Telescope - oldfiles')
nn('<leader>fg', tscope.live_grep(), 'Telescope - grep in project')
nn('<leader>fh', tscope.help_tags(), 'Telescope - vim help')

nn('gr', tscope.lsp_references(), 'Telescope - current symbol references')
nn('gd', tscope.lsp_definitions(), 'Telescope - current symbol definitions')
nn('gs', tscope.lsp_document_symbols(), 'Telescope - current file symbols')

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local opts = { buffer = event.buf }

		nn('K', vim.lsp.buf.hover, 'LSP - Hover', opts)
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

local gitsigns = make_lazy_require_module 'gitsigns'
nn(']c', function()
	if vim.wo.diff then
		vim.cmd.normal({ ']c', bang = true })
	else
		gitsigns.nav_hunk('next', { preview = true })()
		vim.cmd.normal({ 'zz', bang = true })
	end
end, 'Git - Goto next hunk')

nn('[c', function()
	if vim.wo.diff then
		vim.cmd.normal({ '[c', bang = true })
	else
		gitsigns.nav_hunk('prev', { preview = true, })()
		vim.cmd.normal({ 'zz', bang = true })
	end
end, 'Git - Goto previous hunk')

nn('<leader>hl', function()
		gitsigns.refresh()()
		gitsigns.setqflist('all', { use_location_list = true })()
	end,
	'Gitsigns - Location list hunks')
nn('<leader>s', function()
	gitsigns.stage_hunk()()
	close_floats()
end, 'Gitsigns - Stage hunk')
vn('<leader>s', gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') },
	'Gitsigns - Stage range')
nn('<leader>S', gitsigns.stage_buffer(), 'Gitsigns - Stage buffer')
nn('<leader>hu', gitsigns.undo_stage_hunk(), 'Gitsigns - Undo last stage hunk')
nn('<leader>hr', gitsigns.reset_hunk(), 'Gitsigns - Reset hunk')
vn('<leader>hr', gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') },
	'Gitsigns - Reset range')

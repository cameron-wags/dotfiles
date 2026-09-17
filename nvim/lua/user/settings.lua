local opt = vim.opt

opt.completeopt = { 'menuone', 'noselect', 'fuzzy' }
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.cursorline = true
opt.fileencoding = 'utf-8'
opt.ignorecase = true
opt.list = true -- an innocent name for displaying whitespace characters
opt.listchars = { space = ' ', leadmultispace = '» ', tab = '→ ', trail = '•', nbsp = '+' }
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.pumheight = 10
opt.scrolloff = 6
opt.shiftwidth = 2
opt.showmode = false -- don't show -- INSERT -- anymore because statusline plugins do that
opt.showtabline = 0
opt.sidescrolloff = 8
opt.signcolumn = 'yes:1' -- always show the sign column 1 wide, otherwise it would shift the text each time
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = 2
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.tabstop = 2
opt.textwidth = 80
opt.undofile = true
opt.updatetime = 300 -- faster completion (4000ms default)
opt.visualbell = true
opt.formatoptions:append('nr')
opt.wrap = true
opt.whichwrap = 'b,s,<,>,[,],h,l'
opt.shortmess:append('c')

opt.title = true
opt.titlestring = '%t - Nvim'
opt.titlelen = 20
opt.titleold = vim.fn.expand('$TERMINAL')
opt.termguicolors = true
opt.guicursor = {
	'n-v-c:block',
	'i-ci-ve:ver25',
	'r-cr:hor20',
	'o:hor50',
	'a:blinkwait500-blinkoff400-blinkon250-Cursor',
	'sm:block-blinkwait175-blinkoff150-blinkon175'
}

-- treat dash separated words as a word text object
-- vim.opt.iskeyword = vim.opt.iskeyword + '-'

--Remap space as leader key
vim.keymap.set('', '<Space>', '<Nop>', { silent = true, noremap = true })
vim.g.mapleader = ' '

vim.cmd.filetype 'on'

vim.filetype.add {
	pattern = {
		['*.rest'] = 'http',
		['*.http'] = 'http',
	},
}

vim.api.nvim_exec2([[autocmd TermOpen * startinsert]], { output = false })
vim.api.nvim_exec2([[autocmd WinLeave * checktime]], { output = false })

-- highlight yanked text for 250ms using the "Visual" highlight group
vim.api.nvim_create_autocmd('TextYankPost',
	{
		group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
		pattern = '*',
		callback = function()
			vim.highlight.on_yank { higroup = 'CurSearch', timeout = 200 }
		end,
	})

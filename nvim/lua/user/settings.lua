local options = {
	backup = false,                         -- creates a backup file
	clipboard = 'unnamedplus',
	cmdheight = 1,                          -- more space in the neovim command line for displaying messages
	completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
	conceallevel = 0,                       -- so that `` is visible in markdown files
	cursorline = true,                      -- highlight the current line
	expandtab = false,                      -- convert tabs to spaces
	fileencoding = 'utf-8',                 -- the encoding written to a file
	formatoptions = 'jncrq',
	guicursor = {
		'n-v-c:block',
		'i-ci-ve:ver25',
		'r-cr:hor20',
		'o:hor50',
		'a:blinkwait500-blinkoff400-blinkon250-Cursor',
		'sm:block-blinkwait175-blinkoff150-blinkon175'
	},
	hlsearch = true,      -- highlight all matches on previous search pattern
	ignorecase = true,    -- ignore case in search patterns
	incsearch = true,     -- preview search matches
	list = true,          -- an innocent name for displaying whitespace characters
	mouse = 'a',          -- allow the mouse to be used in neovim
	number = true,        -- set numbered lines
	numberwidth = 2,      -- set number column width to 2 {default 4}
	pumheight = 10,       -- pop up menu height
	relativenumber = true, -- set relative numbered lines
	scrolloff = 6,        -- is one of my fav
	shiftwidth = 2,       -- the number of spaces inserted for each indentation
	showmode = false,     -- don't show -- INSERT -- anymore because statusline plugins do that
	showtabline = 0,      -- always show buffer tabs
	sidescrolloff = 8,
	signcolumn = 'yes:1', -- always show the sign column 1 wide, otherwise it would shift the text each time
	smartcase = true,     -- smart case
	smartindent = true,   -- make indenting smarter again
	smarttab = true,      -- <Tab>s follow tabstop
	softtabstop = 2,      -- 0 ignores softtabstop feature and uses tabstop width
	splitbelow = true,    -- force all horizontal splits to go below current window
	splitright = true,    -- force all vertical splits to go to the right of current window
	swapfile = true,      -- creates a swapfile
	tabstop = 2,          -- insert 2 spaces for a tab
	termguicolors = true, -- set term gui colors (most terminals support this)
	textwidth = 80,
	title = true,
	undofile = true,    -- enable persistent undo
	updatetime = 300,   -- faster completion (4000ms default)
	visualbell = true,
	wrap = true,        -- display lines as one long line
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}
for key, value in pairs(options) do
	vim.opt[key] = value
end

--Remap space as leader key
vim.keymap.set('', '<Space>', '<Nop>', { silent = true, noremap = true })
vim.g.mapleader = ' '

vim.opt.whichwrap = vim.opt.whichwrap + '<,>,[,],h,l'

-- treat dash separated words as a word text object
-- vim.opt.iskeyword = vim.opt.iskeyword + '-'

vim.g.do_filetype_lua = 1
vim.cmd('filetype on')

vim.opt.shortmess:append('c')
vim.o.listchars = 'space: ,leadmultispace: ,tab:→ ,trail:•,nbsp:+'

TERMINAL = vim.fn.expand('$TERMINAL')
vim.cmd('let &titleold="' .. TERMINAL .. '"')
vim.o.titlestring = '%<%F - Nvim'

-- highlight yanked text for 250ms using the "Visual" highlight group
vim.api.nvim_create_autocmd('TextYankPost',
	{
		group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
		pattern = '*',
		callback = function()
			vim.highlight.on_yank { higroup = 'CurSearch', timeout = 250 }
		end,
	})

-- Neovide on Mac:
--   launchctl setenv NEOVIDE_FRAME buttonless
--   launchctl setenv NEOVIDE_MULTIGRID true
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_cursor_animation_length = 0.02
vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_remember_window_size = true
vim.g.neovide_transparency = 1.0
-- vim.g.neovide_fullscreen = true
vim.g.transparency = 1.0
vim.opt.guifont = 'JetBrainsMono Nerd Font Mono:h11.5'

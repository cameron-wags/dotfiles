local options = {
  backup = false, -- creates a backup file
  clipboard = 'unnamedplus',
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  cursorline = true, -- highlight the current line
  expandtab = true, -- convert tabs to spaces
  fileencoding = 'utf-8', -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  list = false, -- an innocent name for displaying whitespace characters
  mouse = 'a', -- allow the mouse to be used in neovim
  number = true, -- set numbered lines
  numberwidth = 2, -- set number column width to 2 {default 4}
  pumheight = 10, -- pop up menu height
  relativenumber = true, -- set relative numbered lines
  scrolloff = 5, -- is one of my fav
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  sidescrolloff = 8,
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  softtabstop = 2,
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = true, -- creates a swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  title = true,
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  visualbell = true,
  wrap = true, -- display lines as one long line
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

--Remap space as leader key
vim.keymap.set('', '<Space>', '<Nop>', { silent = true, noremap = true })
vim.g.mapleader = ' '

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.opt.formatoptions = vim.opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    + "o" -- O and o continue comments
    + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments when J'ing lines
    - "2" -- I'm not in gradeschool anymore

-- Neovide on Mac:
--   launchctl setenv NEOVIDE_FRAME buttonless
--   launchctl setenv NEOVIDE_MULTIGRID true
if vim.fn.exists("g:neovide") then
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_remember_window_size = true
  vim.opt.guifont = 'JetBrainsMono Nerd Font Mono:h11.5'
end

vim.g.do_filetype_lua = 1
vim.opt.shortmess:append('c')
vim.cmd('set whichwrap+=<,>,[,],h,l')
TERMINAL = vim.fn.expand('$TERMINAL')
vim.cmd('let &titleold="' .. TERMINAL .. '"')
vim.o.titlestring = '%<%F - Nvim'
vim.cmd('filetype on')

vim.cmd([[
  set iskeyword+=-                      	" treat dash separated words as a word text object
  set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
  set incsearch
  set nocompatible
  " autocmd BufWritePre * %s/\s\+$//e  " Quietly remove trailing whitespace
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
]])

vim.cmd([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higrooup="Visual", timeout=250})
  augroup END
]])

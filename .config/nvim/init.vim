
if has('filteype')
    filetype indent plugin on
endif
if has('syntax')
    syntax on
endif

colorscheme elflord

highlight TabLineFill ctermfg=Black ctermbg=NONE guifg=Black guibg=NONE

"highlight Cursor guifg=white guibg=black
"highlight iCursor guifg=white guibg=steelblue
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor
"set guicursor+=i:blinkwait5

set ignorecase
set smartcase
"Unsets search highlighting when hitting return
noremap <CR> :noh<CR><CR>

set number relativenumber

set shiftwidth=4
set softtabstop=4
set expandtab

set visualbell

set cmdheight=2
set showcmd


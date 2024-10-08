let &guicursor =
            \ 'v-sm:block,'.
            \ 'i-ci-ve:ver25,'.
            \ 'r-o-n-c-cr:hor25'

let &mousemodel = 'extend'

let &background = 'dark'

let &foldenable = v:false

let &wrap = v:true

let &linebreak = v:true

let &packpath = ''

let &runtimepath =
            \ '/usr/share/nvimpager/runtime,'.
            \ '/usr/share/nvim/runtime,'.
            \ '/usr/share/vim/vimfiles,'.
            \ $XDG_DATA_HOME..'/nvim/site/lazy/gruvbox.nvim'

let g:loaded_skim = 0
let g:loaded_tutor_mode_plugin = 0

if $TERM !=# 'linux'
    let &termguicolors = v:true
    let g:gruvbox_italic = v:true
    colorscheme gruvbox
else
    colorscheme desert
endif

vnoremap <C-c> "+y
vnoremap <C-Insert> "+y

hi String      cterm=NONE   gui=NONE
hi Special     cterm=NONE   gui=NONE
hi Comment     cterm=italic gui=italic
hi Visual      ctermbg=237  guibg=#3A3A3A
hi MatchParen  ctermbg=236  guibg=#303030
hi Todo        ctermfg=179  guifg=#D7AF5F
hi diffRemoved ctermfg=9    guifg=#FF0000
hi diffAdded   ctermfg=40   guifg=#00D700
hi diffChanged ctermfg=172  guifg=#D78700

exec 'set runtimepath+='. $XDG_DATA_HOME .'/nvim/plugged/vim-gruvbox8'
set guicursor=v-sm:block,i-ci-ve:ver25,r-o-n-c-cr:hor25
set nofoldenable

colorscheme gruvbox8

vnoremap <C-c>      "+y
vnoremap <C-Insert> "+y

hi String cterm=NONE gui=NONE
hi Special cterm=NONE gui=NONE
hi Comment cterm=italic gui=italic
hi NvimPagerFG_red_BG_ ctermfg=9 guifg=#ff0000
hi NvimPagerFG_green_BG_ ctermfg=40 guifg=#00d700
hi NvimPagerFG_yellow_BG_ ctermfg=172 guifg=#d78700

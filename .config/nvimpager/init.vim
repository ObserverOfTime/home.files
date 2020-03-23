exec 'set runtimepath+='. $XDG_DATA_HOME .'/nvim/plugged/vim-gruvbox8'
set guicursor=v-sm:block,i-ci-ve:ver25,r-o-n-c-cr:hor25
set nofoldenable

colorscheme gruvbox8

vnoremap <C-c>      "+y
vnoremap <C-Insert> "+y

hi String cterm=NONE gui=NONE
hi Special cterm=NONE gui=NONE
hi Comment cterm=italic gui=italic

" Necessary on some Linux distros for pathogen to properly load bundles
filetype off

" Load all Pathogen Bundles
call pathogen#runtime_append_all_bundles()

" Set vim-specific functions available, breaking compatibility with vi
set nocompatible

" Line Number
set number

" Syntax highlighting options
syntax on
set t_Co=256

" Search Options
set incsearch
set hlsearch

" Line Wrapping options
set nowrap

" Disable visual bells
set visualbell t_vb=

" Statusline setup
set statusline=%f\  " Filename
set statusline+=%c, " Cursor Column
set statusline+=%l/%L " Cursor Line/Total Lines
set statusline+=%{StatuslineTrailingSpaceWarning()}

set laststatus=2

" Indentation Settings
set sw=2
set sts=2
set expandtab
set autoindent

" Loading indent and plugins depending on the filetype
filetype plugin on
filetype indent on

" Folding Settings
set nofoldenable

" Command Line Completion
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*.swp,*~,#*#

" Display tabs and trailing spaces
set list
set listchars=tab:\ ¬,trail:.

" Enabling mouse
set mouse=a

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden
set switchbuf=useopen

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Abbreviations to keep me from going insane
iab lenght length
iab widht width
iab heigth height
cab W w
cab Q q
cab Wq wq
cab WQ wq
cab qw wq
cab X x

" Loading the other files from the repository
source ~/.vim/keymaps.vim

" Loading macvim config
if has("gui_mac") || has("gui_macvim")
  source ~/.vim/macvim.vim
endif

" Snipmate setup
source ~/.vim/snippets/support_functions.vim

" Ragtag setup
let g:ragtag_global_maps = 1

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

" Removing trailing spaces from ruby files (by @bbcoimbra)
function! RemoveTraillingSpaces()
        let cursor_pos = getpos(".")
        %s/[ \t]*$//g
        call setpos(".", cursor_pos)
endfunction

nnoremap <silent> <F5> :call RemoveTraillingSpaces()<CR>

colorscheme desert

" Fonts configuration
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monospace\ 14
  elseif has("gui_photon")
    set guifont=Monospace:s14
  elseif has("gui_kde")
    set guifont=Monospace/14/-1/5/50/0/0/0/1/0
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  else
    set guifont=Monospace:h14:cDEFAULT
  endif
endif

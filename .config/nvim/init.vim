
function! Cond(cond, ...)
	let opts = get(a:000, 0, {})
	return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/.plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/vim-github-dashboard'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'terryma/vim-multiple-cursors'
Plug 'liuchengxu/vista.vim'
Plug 'mhinz/vim-grepper'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'morhetz/gruvbox'
Plug 'huawenyu/new.vim', Cond(has('nvim')) | Plug 'huawenyu/new-gdb.vim', Cond(has('nvim'))
Plug 'mhinz/vim-startify'
Plug 'justinmk/vim-sneak'
Plug 'dense-analysis/ale'
Plug 'metakirby5/codi.vim'

call plug#end()

source $HOME/.config/nvim/configuration/settings.vim
source $HOME/.config/nvim/configuration/coc.vim
source $HOME/.config/nvim/configuration/airline.vim
source $HOME/.config/nvim/configuration/floaterm.vim
source $HOME/.config/nvim/configuration/fzf.vim
source $HOME/.config/nvim/configuration/gdb.vim
source $HOME/.config/nvim/configuration/markdown.vim
source $HOME/.config/nvim/configuration/nerdtree.vim
source $HOME/.config/nvim/configuration/start-config.vim
source $HOME/.config/nvim/configuration/style.vim
source $HOME/.config/nvim/configuration/vista.vim
source $HOME/.config/nvim/configuration/functions.vim
source $HOME/.config/nvim/configuration/rainbow.vim
source $HOME/.config/nvim/configuration/sneak.vim
source $HOME/.config/nvim/configuration/codi.vim
source $HOME/.config/nvim/configuration/mappings.vim


"map <ESC>[5D <C-Left>
"map <ESC>[5C <C-Right>
"map! <ESC>[5D <C-Left>
"map! <ESC>[5C <C-Right>

" <C-Right>

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

hi Normal guibg=NONE ctermbg=NONE

"function list
"Vista coc

let g:vista_fzf_preview = ['right:50%']

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

autocmd FileType json syntax match Comment +\/\/.\+$+
au BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


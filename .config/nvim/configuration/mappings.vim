

:command WQ wq
:command Wq wq
:command W w
:command Q q
:command F Format

command! -nargs=0 Format :call CocAction('format')

nnoremap <F5> :make! && echo "Builed Sucessfull"<cr>

map <leader>ss :setlocal spell!<cr>

"map <C-p> :Files<CR>
map <C-b> :NERDTreeToggle<CR>
map k gk
map j gj
map <silent> <leader><cr> :noh<cr>

tnoremap <Esc> <C-\><C-n>

nnoremap <silent> - :exe "vertical resize -10"<CR>
nnoremap <silent> + :exe "vertical resize +10"<CR>

" Remap VIM 0 to first non-blank character
map 0 ^

nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z

vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


" Remove the Windows ^M - when the encodings gets messed up
"noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" When you press <leader>r you can search and replace the selected text
"vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Visual mode pressing * or # searches for the current selection
"vnoremap <silent> * :call VisualSelection('f')<CR>
"vnoremap <silent> # :call VisualSelection('b')<CR>


" Leader key
let mapleader=","

" Better indenting
vnoremap < <gv
vnoremap > >gv

  " TAB in general mode will move to text buffer
  nnoremap <silent> <TAB> :bnext<CR>
  " SHIFT-TAB will go back
  nnoremap <silent> <S-TAB> :bprevious<CR>

  " <TAB>: completion.
  inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"


  " Use alt + hjkl to resize windows
  nnoremap <silent> <M-j>    :resize -2<CR>
  nnoremap <silent> <M-k>    :resize +2<CR>
  nnoremap <silent> <M-h>    :vertical resize -2<CR>
  nnoremap <silent> <M-l>    :vertical resize +2<CR>

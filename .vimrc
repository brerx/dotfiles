set nocompatible

scriptencoding utf-8
set encoding=utf-8

set number
set cursorline
set ruler
set laststatus=2
set showcmd
set clipboard=unnamed,unnamedplus

set nowrap
set tabstop=2
set shiftwidth=2
set smartindent
set expandtab
set list
set listchars=""
set list listchars=trail:·
set pastetoggle=<f5> " if pasting with mouse, press F5 to stop autoindent

" speed up scrolling
set lazyredraw
set ttyfast
set regexpengine=1
set nofoldenable

set hlsearch
set incsearch
set ignorecase
set smartcase

set viminfo='1000,f1,:100,/100,%,!

set t_Co=256

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>


color dracula

if exists('+colorcolumn')
        let &colorcolumn="80"
        highlight ColorColumn ctermbg=236
endif

execute pathogen#infect()
syntax on
filetype plugin indent on

" no arrows any more
nnoremap <Up> :echo "Use home row, for fuck's sake"<CR>
nnoremap <Down> :echo "Use home row, for fuck's sake"<CR>
nnoremap <Left> :echo "Use home row, for fuck's sake"<CR>
nnoremap <Right> :echo "Use home row, for fuck's sake"<CR>
inoremap <Up> :echo "Get the fuck out of INSERT mode!"<CR>
inoremap <Down> :echo "Get the fuck out of INSERT mode!"<CR>
inoremap <Left> :echo "Get the fuck out of INSERT mode!"<CR>
inoremap <Right> :echo "Get the fuck out of INSERT mode!"<CR>

let g:ackprg = 'ag --vimgrep'

function! Carousel()
  for theme in split(globpath(&runtimepath, 'colors/*.vim'), '\n')
    let t = fnamemodify(theme, ':t:r')
    try
      execute 'colorscheme '.t
      echo t
    catch
    finally
    endtry
    sleep 4
    redraw
  endfor
endfunction

map <silent> <Leader>tc :call Carousel()<cr>

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --path-to-ignore\ $HOME/.agignore

  " Use ag in CtrlP for listing files. Lightning fast and respects
  "     .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " bind , (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

  nnoremap , :Ag<SPACE>
endif

let mapleader = " "

nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>. :CtrlPTag<CR>

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

" autocmd FileWritePre * call TrimWhiteSpace()
" autocmd FileAppendPre * call TrimWhiteSpace()
" autocmd FilterWritePre * call TrimWhiteSpace()
" autocmd BufWritePre * call TrimWhiteSpace()

map <F2> :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>

" NERDTree
" open on vim startup
" autocmd vimenter * NERDTree

" ooen on vim startup if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open on vim startup when only directory is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" map <Ctrl-n> to NERDTree
map <C-n> :NERDTreeToggle<CR>

" quit vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('exs', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('ex', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('rb', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('vim', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('sh', 'Magenta', 'none', '#ff00ff', '#151515')

" Use nicer hl colors
" hi Search ctermbg=226 ctermfg=0
hi Search cterm=NONE ctermfg=black ctermbg=yellow

" tab symbol
set listchars=tab:⇢\ ,nbsp:⎵
highlight SpecialKey ctermbg=none ctermfg=238

" C-specific settings
au! BufRead,BufNewFile */*.cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
au! BufRead,BufNewFile */*.hpp setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
au! BufRead,BufNewFile */*.h setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Change Diffcolors
fun! SetDiffColors()
  highlight DiffAdd    cterm=bold ctermfg=white ctermbg=DarkGreen
  highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGrey
  highlight DiffChange cterm=bold ctermfg=black ctermbg=DarkBlue
  highlight DiffText   cterm=bold ctermfg=white ctermbg=DarkRed
endfun

autocmd FilterWritePre * call SetDiffColors()

" Type // to search for visually selected text
vnoremap // y/<C-R>"<CR>

" Run currently open RSpec test file
map <Leader>rf :w<CR>:!bundle exec rspec % --format documentation<CR>
          
" Run current RSpec test
" RSpec can determine the right test to run as long as the cursor is somewhere within the test
map <Leader>rl :w<CR>:exe "!bundle exec rspec %" . ":" . line(".")<CR>

" Run all RSpec tests
map <Leader>rt :w<CR>:!bundle exec rspec --format documentation<CR>

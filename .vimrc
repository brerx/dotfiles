set nocompatible
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab

" Enable syntax highlighting.
syntax on

" File-type highlighting and configuration.
" Run :filetype (without args) to see what you may have
" to turn on yourself, or just set them all to be sure.
filetype on
filetype plugin on
filetype indent on

set autoindent smartindent
set showmode

" Show line numbers.
set number

" Do not wrap lines.
set nowrap

" Show matching brackets.
set showmatch

" Always show status line.
set laststatus=2

" Mouse in all modes
set mouse=a

set history=1000
set matchtime=0
" The “Press ENTER or type command to continue” prompt is jarring and usually unnecessary. You can shorten command-line text and other info tokens with.
set shortmess=atI

" show trailing whitespace
set list listchars=trail:·

" Now in the bottom right corner of the status line there will be something like: 529, 35 68%, representing line 529, column 35, about 68% of the way to the end.
set ruler
set showcmd

" A running gvim will always have a window title, but when vim is run within an xterm, by default it inherits the terminal’s current title.
set title

execute pathogen#infect()

" Search options
" Highlight search terms
set hlsearch
set incsearch
set ignorecase
set smartcase


" Blink if there is an error
set visualbell
set noerrorbells
set printoptions=paper:letter

" Make backspace delete lots of things
" set backspace=indent,eol,start

set backupdir=/tmp//,.
set directory=/tmp//,.
set undodir=/tmp//,.

set backspace=2   " Backspace deletes like most programs in insert mode

let mapleader = "\<space>"

set t_Co=256
set cursorline

set scrolloff=15

" speed up scrolling
set lazyredraw
set ttyfast
set regexpengine=1
set nofoldenable

" Enable TOC window auto-fit
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_disabled = 1
set nofoldenable

" NERDTree File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('exs', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('ex', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('rb', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('vim', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('sh', 'Magenta', 'none', '#ff00ff', '#151515')

color dracula

if exists('+colorcolumn')
 let &colorcolumn="80"
 highlight ColorColumn ctermbg=236
endif

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" How can I open NERDTree automatically when vim starts up on opening a directory?
" This window is tab-specific, meaning it's used by all windows in the tab. This trick also prevents NERDTree from hiding when first selecting a file.
" Note: Executing vim ~/some-directory will open NERDTree and a new edit window. exe 'cd '.argv()[0] sets the pwd of the new edit window to ~/some-directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | wincmd p | endif

" Open NERD Tree when no file specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFind<CR>

" Close NERD Tree when everything else is closed.
" disabled for convenience, if closing all is desired, enter :qa
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Prevent Ctrlp from searching node modules and git
let g:ctrlp_custom_ignore = '\v[\/](node_modules|dist)|(\.(swp|git))$'
let g:ctrlp_show_hidden = 1

highlight GitGutterAdd    ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" nnoremap <Leader>w <C-w>
" nnoremap <Enter> O<Esc>j

map <Leader>t :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>. :CtrlPTag<CR>
map <Leader>i :TsuImport<CR>

let g:ackprg = 'ag --vimgrep'

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

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='dark'

let g:airline_powerline_fonts = 1
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
"

" no arrow keys in edit mode
inoremap <Left> <nop>
inoremap <Right> <nop>
" do not disable them here to allow them for autocompletion navigation
"inoremap <Up> <nop>
"inoremap <Down> <nop>

" autocmd FileType typescript,typescript.tsx nmap <buffer> <Leader>o : <C-u>echo tsuquyomi#hint()<CR>

set omnifunc=syntaxcomplete#Complete
set completeopt=noinsert,menuone,menu

" inoremap <expr> <CR>       pumvisible()    ? "\<C-y>"                  : "\<CR>"
inoremap <expr> <Down>     pumvisible()    ? "\<C-n>"                  : ""
inoremap <expr> <Up>       pumvisible()    ? "\<C-p>"                  : ""
inoremap <expr> <PageDown> pumvisible()    ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible()    ? "\<PageUp>\<C-p>\<C-n>"   : "\<PageUp>"

" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon

" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'typescript': ['tsserver', 'eslint']
      \}

let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \    'javascript': ['eslint'],
      \    'typescript': ['eslint', 'prettier'],
      \    'scss': ['prettier'],
      \    'html': ['prettier']
      \}

let g:ale_fix_on_save = 1
nmap <C-f> :ALEFix<CR>:TsuQuickFix<CR>
imap <C-f> <C-o>:ALEFix<CR>:TsuQuickFix<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1

if has('macunix')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

nnoremap <leader>r :ALEFindReferences<CR>
nnoremap <leader>d :TsuDefinition<CR>
"todo: ale or tsu
" rename
" search in files
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gl :GV<CR>
nnoremap <leader>glf :GV!<CR>
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.tsx, *.jsx'
" todo create ctrlsf mappings and config settings
" map to <leader>f*
nmap     <leader>f <Plug>CtrlSFPrompt
nmap     <leader>s :CtrlSFToggle<CR>
vmap     <leader>f <Plug>CtrlSFVwordExec
let g:ctrlsf_auto_close = {
      \ "normal" : 0,
      \ "compact": 0
      \}
let g:ctrlsf_default_view_mode = 'compact'


" from https://stackoverflow.com/a/54961319
function AleIgnore()
  let codes = []
  for d in getloclist(0)
    if (d.lnum==line('.'))
      let code = split(d.text,':')[0]
      call add(codes, code)
    endif
  endfor
  if len(codes)
    exe 'normal O/* eslint-disable-next-line ' . join(codes, ', ') . ' */'
  endif
endfunction

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
au! BufRead,BufNewFile */*.go setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab


" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_ruby_checkers          = ['rubocop', 'mri']
let g:syntastic_ruby_rubocop_exec      = '/Users/thomas/.rbenv/shims/rubocop'

" Type // to search for visually selected text
vnoremap // y/<C-R>"<CR>

" Run currently open RSpec test file
map <Leader>rf :w<CR>:!bundle exec rspec % --format documentation<CR>

" Run current RSpec test
" RSpec can determine the right test to run as long as the cursor is somewhere within the test
map <Leader>rl :w<CR>:exe "!bundle exec rspec %" . ":" . line(".")<CR>

" Run all RSpec tests
map <Leader>rt :w<CR>:!bundle exec rspec --format documentation<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd BufWritePost *.rb SyntasticCheck rubocop
autocmd BufRead,BufNewFile *.zpl set filetype=zimpl

" see https://unix.stackexchange.com/a/383044
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

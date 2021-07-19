let mapleader = "\<space>"

" Remap Ctrl+C to Escape to ensure triggering InsertLeave
noremap <C-c> <esc>
inoremap <C-c> <esc><esc>
inoremap jj <esc><esc>
nnoremap <leader>jj <esc>
inoremap jk <esc><esc>
nnoremap <leader>jk <esc>

" move vertically by visual line with j and k
nnoremap j gj
nnoremap k gk

nnoremap <Leader>w <C-w>
" Move to the next buffer
nnoremap <leader>l :bnext<CR>
" Move to the previous buffer
nnoremap <leader>h :bprevious<CR>
" nnoremap <leader>b :ls<cr>:b<space>
" nnoremap <leader>B :ls!<cr>:b<space>
nnoremap <Leader>q :bd<CR>
nnoremap <Leader>Q :%bd\|e#\|bd#<CR>
nnoremap <Leader>bd :Bdelete other<CR>

nnoremap <Leader>/ :History/<CR>
nnoremap <Leader>: :History:<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>of :Files<CR>
nnoremap <Leader>og :GFiles?<CR>
nnoremap <Leader>ob :Buffers<CR>
nnoremap <Leader>ol :Lines<CR>
nnoremap <Leader>p :GFiles<CR>
nnoremap <Leader>P :History<CR>
nnoremap <Leader>; :Commands<CR>

nnoremap <Leader>q :bd<CR>
nnoremap <leader><BS> :noh<cr>

nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

cnoremap W w

nnoremap <leader>s :w<CR>
nnoremap <leader>S :wa<CR>

nnoremap <leader>- <C-o><CR>
nnoremap <leader>+ <C-i><CR>

" Enter // to search for currently visually selected block
" Hint: enter :g/ (short for :g//p) to list all  occurences in the current file
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

nnoremap <leader>gs :G<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gl :GV<CR>
nnoremap <leader>glf :GV!<CR>
nnoremap <leader>k <Plug>(GitGutterPrevHunk)
nnoremap <leader>j <Plug>(GitGutterNextHunk)
nnoremap <leader>ghp <Plug>(GitGutterPreviewHunk)
nnoremap <leader>ghs <Plug>(GitGutterStageHunk)
vnoremap <leader>ghs <Plug>(GitGutterStageHunk)

" make search results appear in the middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * #zz
nnoremap # *zz
nnoremap g* g*zz
nnoremap g# g#zz

function! NERDTreeSmartToggle()
  if @% == ""
    NERDTreeToggleVCS
  elseif (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    NERDTreeClose
  else
    NERDTreeFind
  endif
endfun

nnoremap <silent> <leader>n :call NERDTreeSmartToggle()<CR>

" CtrlSF
nmap <leader>F :CtrlSF<CR>
nmap <leader>f <Plug>CtrlSFPrompt
vmap <leader>f <Plug>CtrlSFVwordExec

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" nnoremap <leader>h <Plug>AirlineSelectPrevTab
" nnoremap <leader>l <Plug>AirlineSelectNextTab

nnoremap <leader>, :VimuxPromptCommand<cr>
nnoremap <leader>vp :VimuxPromptCommand<cr>
nnoremap <leader>vl :VimuxRunLastCommand<cr>
nnoremap <leader>vi :VimuxInspectRunner<cr>
nnoremap <leader>vz :VimuxZoomRunner<cr>:VimuxInspectRunner<cr>

" vim-test
nnoremap <leader>tn :w \| TestNearest<CR>
nnoremap <leader>tf :w \| TestFile<CR>
nnoremap <leader>tl :w \| TestLast<CR>
nnoremap <leader>tv :TestVisit<CR>
" List contents of all registers (that typically contain pasteable text) (from https://superuser.com/a/656954)
nnoremap <silent> "" :registers 0123456789abcdefghijklmnopqrstuvwxyz<CR>

nnoremap <leader>u :UndotreeToggle \| UndotreeFocus<CR>

" CoC config
" Use <c-x> to trigger completion.
inoremap <silent><expr> <c-x> coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" Set syntax scheme to json and format it (by using python, make sure it is installed)
command Json set syntax=json | execute '%!python -m json.tool'

" Navigate diagnostics
" nnoremap <silent> <leader>K <Plug>(coc-diagnostic-prev)
" nnoremap <silent> <leader>J <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" show info (like tooltip)
nnoremap <silent> <leader>i :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <leader>wq :mksession!\|:qa<cr>

" Remap for rename current word
nmap <leader>rr <Plug>(coc-rename)

" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <silent> <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <silent> <leader>.  <Plug>(coc-fix-current)

nmap <silent> <leader>dr :%Source<cr>
vmap <silent> <leader>dr :Source<cr>

" move the current line one down or up
noremap <leader>- ddp
noremap <leader>_ ddP

" uppercase current word in insert mode !!!! <c-u> is scoll up!!!
" inoremap <c-u> <esc>viwUi
" nnoremap <c-u> viwU

" open vimrc in a new split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

iabbrev adn and
iabbrev waht what
iabbrev tehn then

iabbrev @@ th.mueller87@gmail.com
iabbrev ccopy Copyright 2021 Thomas Müller, all rights reserved.

" iabbrev tpp .tap do |tmp| pp tap: tmp end

onoremap in( :<c-u>normal! f(vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap al( :<c-u>normal! F)va(<cr>

onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap an{ :<c-u>normal! f{va{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap al{ :<c-u>normal! F}va{<cr>

" vim: foldmethod=marker

let mapleader=" "
set number " Turn on line numbers
syntax on  " Enable syntax highlighting

set nofoldenable " Disable autofolded sections

set lazyredraw
" when playing <n>macros wait until all <n> are complete before
" updating the screen
" https://github.com/tpope/vim-sensible/issues/78

" Enable folding based on syntax rules {{{
set foldmethod=syntax
set foldlevelstart=99
" }}}


set scrolloff=10 " Keep 10 lines of context above/below cursor
set nowrap " Disable soft wrapping on wide lines

set expandtab 							" Use spaces instead of tabs
set tabstop=2 shiftwidth=2  " A tab is two spaces wide

" Don't leave backup files littered over the current directory {{{
set backupdir=~/.vimswap
set directory=~/.vimswap
set noswapfile
set nobackup
" }}}



" Buffer Management {{{
set hidden "  allow buffer swapping when the current buffer is unsaved

" swap between active/last-active files without stretching
noremap <leader>, <C-^>

 " Move between buffers
noremap <leader>h :bn<CR>
noremap <leader>s :bp<CR>

" close all hidden buffers
" https://vimtricks.com/p/closing-hidden-buffers/
command Bd :up | %bd | e#
" }}}

" Quicklist Management {{{
" Move between quicklist entries faster
noremap <leader>g :cp<CR>
noremap <leader>G :cpfile<CR>
noremap <leader>l :cn<CR>
noremap <leader>L :cnfile<CR>
" }}}

" Remap save to a friendlier keystroke c-w {{{
" map <C-w> <esc>:w<CR>
" imap <C-w> <esc>:w<CR>a
" }}}



" Remap the Dvorak RHS home row to behave as directions{{{
noremap l s
noremap L S
noremap s l
noremap S L

noremap t j
noremap T J
noremap j t
noremap J T

noremap n k
noremap N K
noremap k n
noremap K N
" }}}

" Remember last location in file {{{
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif
endif
" }}}

" Install plugins {{{
" https://github.com/junegunn/vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pearofducks/ansible-vim'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dense-analysis/ale'
Plug 'hashivim/vim-terraform'
Plug 'jgdavey/tslime.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'rizzatti/dash.vim'
Plug 'takac/vim-hardtime'
Plug 'thoughtbot/vim-rspec'
Plug 'tomasr/molokai'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
" }}}

colorscheme solarized
set background=light

" vim-gitgutter.vim{{{
" Recommends reducing the refresh time
" from the default of 4000ms
set updatetime=100
" }}}

" emmet-vim{{{
let g:user_emmet_leader_key='<C-L>'
" }}}
" vim-surround.vim{{{
" ds and cs interfere with my home row
let g:surround_no_mappings = 1
nmap dl  <Plug>Dsurround
nmap cl  <Plug>Csurround
nmap cL  <Plug>CSurround
nmap yl  <Plug>Ysurround
nmap yL  <Plug>YSurround
nmap yll <Plug>Yssurround
nmap yLl <Plug>YSsurround
nmap yLL <Plug>YSsurround
xmap L   <Plug>VSurround
xmap gL  <Plug>VgSurround
if !exists("g:surround_no_insert_mappings") || ! g:surround_no_insert_mappings
  if !hasmapto("<Plug>Isurround","i") && "" == mapcheck("<C-S>","i")
    imap    <C-S> <Plug>Isurround
  endif
  imap      <C-G>l <Plug>Isurround
  imap      <C-G>L <Plug>ISurround
endif


" }}}
" Dash.vim{{{
nnoremap <leader>p :Dash<cr>
nnoremap <leader>P :Dash<space>
" }}}

" ale linter engine {{{
let g:ale_sign_column_always = 1 " Always keep the gutter open rather than having the page bouncing

let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \'ruby': ['rubocop'],
      \}

let g:ale_linters = {
      \'ruby': ['rubocop'],
      \}

let g:ale_ruby_rubocop_executable = './bin/rubocop'
" }}}

" vim-tmux-navigator {{{
" Better keyboard navigation between tmux and vim panes
" ctl + home row to move to the next tmux or vim panel without
" having to worry about which type it is.
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-t> :TmuxNavigateDown<cr>
nnoremap <silent> <C-n> :TmuxNavigateUp<cr>
nnoremap <silent> <C-s> :TmuxNavigateRight<cr>

inoremap <silent> <C-h> <Esc>:TmuxNavigateLeft<cr>
inoremap <silent> <C-t> <Esc>:TmuxNavigateDown<cr>
inoremap <silent> <C-n> <Esc>:TmuxNavigateUp<cr>
inoremap <silent> <C-s> <Esc>:TmuxNavigateRight<cr>
" }}}

" Fuzzy File Finder {{{
" https://github.com/junegunn/fzf
" https://github.com/junegunn/fzf.vim
" Search project by filename
noremap <C-p> :Files<CR>
noremap! <C-p> <esc>:Files<CR>

" search all buffers by filename
noremap <C-y> :Buffers<CR>
noremap! <C-y> <esc>:Buffers<CR>

" Use ag instead of find and respect gitignore
let $FZF_DEFAULT_COMMAND= 'ag  -g "" --ignore "*.png"  --ignore "*.jpg" --ignore "*.gif"'
" }}}
"

" Persistant undos {{{
" Taken from Instantly Better Vim by http://damian.conway.org/
" Warn when stepping from current session's undos into those from the previous session
" Remap the undo key to warn about stepping back into a buffer's pre-history...

set undofile                      " Save undo's after file closes
set undodir=$HOME/.vim_local/undo " where to save undo histories
set undolevels=1000               " How many undos
set undoreload=10000              " number of lines to save for undo
nnoremap <expr> u VerifyUndo()

" Track each buffer's starting position in undo history...
augroup UndoWarnings
  autocmd!
  autocmd BufReadPost,BufNewFile *
        \ :call Rememberundo_start()
augroup END

function! Rememberundo_start ()
  let b:undo_start = exists('b:undo_start')
        \ ? b:undo_start
        \ : undotree().seq_cur
endfunction
function! VerifyUndo ()
  " Are we back at the start of this session " (but still with undos possible)???
  let undo_now = undotree().seq_cur
  " And does the buffer have a name?
  let named_file = expand('%:p')
  if (!empty(named_file)) && undo_now > 0 && undo_now == b:undo_start
    " If so, ask whether to undo into pre-history...
    return confirm('', "Undo into previous session? (&Yes\n&No)",1) == 1  ? "\<C-L>u" : "\<C-L>"
  endif
  " Otherwise, just undo...
  return 'u'
endfunction
" }}}

" Project search with Ack.vim {{{
" :Ack jumps to first match, Ack! does not
cnoreabbrev Ack Ack!
nnoremap <Leader>f :Ack!<Space>

" Use Ag if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" }}}

" TSlime and RSpec.vim mappings to send tests to tmux {{{
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
map <Leader>o :w<CR>:call RunLastSpec()<CR>
map <Leader>a :w<CR>:call RunNearestSpec()<CR>
map <Leader>A :w<CR>:call RunCurrentSpecFile()<CR>
map <Leader>O :w<CR>:call RunAllSpecs()<CR>
" }}}

" Trim trailing whitespace on save. {{{
" Stolen from
" http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
" }}}

" Expand %% to the directory of the currently open buffer {{{
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" }}}

" A common typo is Q instead of :, which leaves you in ex mode
" In all my life I've never wanted to be in ex mode {{{
nnoremap Q <Nop>
" }}}

" I'm forever typing :Q instead of :q {{{
command Q :q
command Qall :qall
" }}}

" coc.nvim {{{
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"}}}

" Give myself a HardTime{{{
" https://github.com/takac/vim-hardtime
let g:hardtime_default_on = 0
let g:list_of_normal_keys = ["h", "t", "n", "s", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "t", "n", "s", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []
" }}}

" rename current file {{{
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>mv :call RenameFile()<cr>
" }}}
"

" Searching {{{
set incsearch    " incremental searching
set hlsearch     " highlight all matches
hi Search cterm=NONE ctermbg=38
set ignorecase   " searches are case insensitive...
set smartcase    " ... unless they contain at least one capital letter

" default match to magic mode so special characters don't need escaped
nnoremap / /\v

" Backspace turn off hlsearch
nmap <silent> <BS> :nohlsearch<CR>
" }}}
"

" vim-terraform {{
let g:terraform_fmt_on_save=1
let g:terraform_align=1
" }}
"


" netrw config {{{
let g:netrw_dirhistmax=0 " Don't leave .netrwhist files in cwd

function! NetrwMapping()
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  noremap <buffer> t j
  " netrw overloads 't' with open-in-new-tab
  " http://unix.stackexchange.com/questions/31575/remapping-keys-in-vims-directory-view
endfunction
" }}}

source ~/.vimrc_local


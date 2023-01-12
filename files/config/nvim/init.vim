" vim: foldmethod=marker

let mapleader=" "
set number " Turn on line numbers
syntax on  " Enable syntax highlighting

set cursorline
se nofoldenable " Disable autofolded sections

set lazyredraw
" when playing <n>macros wait until all <n> are complete before
" updating the screen
" https://github.com/tpope/vim-sensible/issues/78

" Enable folding based on syntax rules {{{
set foldmethod=syntax
set foldlevelstart=99
" }}}


set scrolloff=30 " Keep X lines of context above/below cursor
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

" Remap save to a friendlier keystroke {{{
nnoremap <leader>w :w<cr>
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
" Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'dense-analysis/ale'
Plug 'hashivim/vim-terraform'
Plug 'jgdavey/tslime.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'rizzatti/dash.vim'
Plug 'takac/vim-hardtime'
Plug 'thoughtbot/vim-rspec'
Plug 'tanvirtin/monokai.nvim'
Plug 'shaunsingh/solarized.nvim'

Plug 'psliwka/vim-smoothie'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'neoclide/Coc.nvim', {'branch': 'release'}
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
" let g:ale_sign_column_always = 1 " Always keep the gutter open rather than having the page bouncing

" let g:ale_fixers = {
"       \   '*': ['remove_trailing_lines', 'trim_whitespace'],
"       \'ruby': ['rubocop'],
"       \}

" let g:ale_linters = {
"       \'ruby': ['rubocop', 'reek'],
"       \}

" let g:ale_ruby_rubocop_executable = './bin/rubocop'
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

" Let's try freeing up some insert mode keys
" inoremap <silent> <C-h> <Esc>:TmuxNavigateLeft<cr>
" inoremap <silent> <C-t> <Esc>:TmuxNavigateDown<cr>
" inoremap <silent> <C-n> <Esc>:TmuxNavigateUp<cr>
" inoremap <silent> <C-s> <Esc>:TmuxNavigateRight<cr>
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
"
" by default Ack maps `t` to open current result in a new tab
" that doesn't work for me because dvorak makes `t` my down.
" Open results in new tabs with o(focus) O(stay in qf)
let g:ack_mappings = {
      \ "t": "<Down>",
      \ "o": "<C-W><CR><C-W>T",
      \ "O": "<C-W><CR><C-W>TgT<C-W>j" }
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

colorscheme monokai_pro
set background=light

" Uppercase word from insert mode
inoremap <c-u> <esc>gUawgi

" Edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" reselect visual selection after changing indentation
vnoremap < <gv
vnoremap > >gv

" ruby abbreviations
iabbrev deff def<CR><CR>end<up><up>

" https://github.com/antonk52/vim-tabber/blob/master/plugin/tabber.vim
for i in range(1, 9)
  exec 'nnoremap <leader>' . i . ' <cmd>call TabberGoToTab('. i .')<CR>'
endfor

function! TabberGoToTab(tab_number)
  let l:total_tabs = tabpagenr('$')

  if l:total_tabs > 1
    " go to first tab
    if (a:tab_number == 1)
      execute(':tabfirst')
    " if required tab is greater than the wanted one
    " always go to the last tab
    elseif (a:tab_number >= l:total_tabs || a:tab_number == 9)
      execute(':tablast')
    else
      execute('normal! ' . a:tab_number . 'gt')
    endif
  endif
endfunction
" end of tabs


let g:netrw_banner=0 " turn off the banner at the top of the file explorer
" I've turned off the expanding view because it doesn't
" behave as I expect. If I'm in a project and open a nested directory..
" ```
" :e ./app/models/whatever
" ```
" The explorer opens up at the top level. Once I open down to
" the directory I find `whatever` is already open, but that's no use.
" Also, I think changing my netrw might be associated with an odd behaviour
" when I try to switch to an alternate file expecting to see an netrw page but
" get nothing?
""
" let g:netrw_liststyle = 3
"
"
" Open new split panes to right and bottom, which feels more natural than Vim’s default:
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" Make the system board easier to write
" Turned this off because it clashes with fzf buffer search
" nnoremap <c-y> "*y
" nnoremap <c-Y> "*Y
" vnoremap <c-y> "*y

" Search project for current word
nnoremap <leader>F :Ack <cword> <CR>
"

" {{{ COC
" A mapping to hide the floating
map <Leader>5 <Plug>(coc-float-hide)

" This changes the color
hi CocErrorVirtualText guifg=Grey
hi CocInfoVirtualText guifg=Grey
hi CocHintVirtualText guifg=Grey
hi CocWarningVirtualText guifg=Grey
hi CocMenuSel guibg=#13354A
hi CocHighlight guibg=#13354A
hi CocHighlightText guibg=Purple

" I think this came from an issue to do with highlight not working?
autocmd ColorScheme * call Highlight()

function! Highlight() abort
  hi Conceal ctermfg=239 guifg=#504945
  hi CocSearch ctermfg=12 guifg=#18A3FF
endfunction

" ==== coc
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>d <Plug>(coc-definition)
" Not used for solargraph, so will ignore for now
" nmap <silent> <leader>td <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph

" GM - disabling this because it interferes with my spec runner
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" GM - disabling this because it interferes with my split nav
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" GM - these all screw me because leader is space
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"
" }}}



" {{{ The hodge-podge of crap that was my ~/.vimrc_local
colorscheme monokai_pro
set background=light

" Uppercase word from insert mode
inoremap <c-u> <esc>gUawgi

augroup markdownFileType
  autocmd!
  autocmd FileType markdown setlocal textwidth=80
  autocmd FileType markdown setlocal colorcolumn=80
  autocmd FileType markdown setlocal spell
augroup end

nnoremap H 0
nnoremap  0

" reselect visual selection after changing indentation
vnoremap < <gv
vnoremap > >gv

" ruby abbreviations
iabbrev deff def<CR><CR>end<up><up>

" https://github.com/antonk52/vim-tabber/blob/master/plugin/tabber.vim
for i in range(1, 9)
  exec 'nnoremap <leader>' . i . ' <cmd>call TabberGoToTab('. i .')<CR>'
endfor

function! TabberGoToTab(tab_number)
  let l:total_tabs = tabpagenr('$')

  if l:total_tabs > 1
    " go to first tab
    if (a:tab_number == 1)
      execute(':tabfirst')
    " if required tab is greater than the wanted one
    " always go to the last tab
    elseif (a:tab_number >= l:total_tabs || a:tab_number == 9)
      execute(':tablast')
    else
      execute('normal! ' . a:tab_number . 'gt')
    endif
  endif
endfunction
" end of tabs


let g:netrw_banner=0 " turn off the banner at the top of the file explorer
" I've turned off the expanding view because it doesn't
" behave as I expect. If I'm in a project and open a nested directory..
" ```
" :e ./app/models/whatever
" ```
" The explorer opens up at the top level. Once I open down to
" the directory I find `whatever` is already open, but that's no use.
" Also, I think changing my netrw might be associated with an odd behaviour
" when I try to switch to an alternate file expecting to see an netrw page but
" get nothing?
""
" let g:netrw_liststyle = 3
"
"
" Open new split panes to right and bottom, which feels more natural than Vim’s default:
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" Make the system board easier to write
nnoremap <c-y> "*y
nnoremap <c-Y> "*Y
vnoremap <c-y> "*y

" Search project for current word
nnoremap <leader>F :Ack <cword> <CR>
"

autocmd FileType markdown setlocal spell

" A mapping to hide the floating
map <Leader>5 <Plug>(coc-float-hide)

" This changes the color
hi CocErrorVirtualText guifg=Grey
hi CocInfoVirtualText guifg=Grey
hi CocHintVirtualText guifg=Grey
hi CocWarningVirtualText guifg=Grey
hi CocMenuSel guibg=#13354A
hi CocHighlight guibg=#13354A
hi CocHighlightText guibg=Purple

" I think this came from an issue to do with highlight not working?
autocmd ColorScheme * call Highlight()

function! Highlight() abort
  hi Conceal ctermfg=239 guifg=#504945
  hi CocSearch ctermfg=12 guifg=#18A3FF
endfunction

" ==== coc
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>d <Plug>(coc-definition)
" Not used for solargraph, so will ignore for now
" nmap <silent> <leader>td <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph

" GM - disabling this because it interferes with my spec runner
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" GM - disabling this because it interferes with my split nav
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" GM - these all screw me because leader is space
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"
" }}}

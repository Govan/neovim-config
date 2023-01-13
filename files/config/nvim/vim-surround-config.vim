" ds and cs interfere with my home row
let g:surround_no_mappings = 1
" delete surrounding chars
nmap dl  <Plug>Dsurround

" Change old for new
nmap cl  <Plug>Csurround
nmap cL  <Plug>CSurround

" Insert new delimiter
nmap yl  <Plug>Ysurround
nmap yL  <Plug>YSurround

" surround the whole line
nmap yll <Plug>Yssurround

"surround the whole line with delimitors on new lines
nmap yLl <Plug>YSsurround
nmap yLL <Plug>YSsurround

" visual mappings that I very rarely use
xmap L   <Plug>VSurround
xmap gL  <Plug>VgSurround

" There's some support for insert mode auto-pairing, but the binding
" clashes with my split navigation on <C-S>, so move it.
" https://github.com/tpope/vim-surround/blob/master/doc/surround.txt
let g:surround_no_insert_mappings = 1
if !exists("g:surround_no_insert_mappings") || ! g:surround_no_insert_mappings
  if !hasmapto("<Plug>Isurround","i") && "" == mapcheck("<C-S>","i")
    imap    <C-S> <Plug>Isurround
  endif
  imap      <C-G>l <Plug>Isurround
  imap      <C-G>L <Plug>ISurround
endif

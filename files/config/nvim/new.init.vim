" Install plugins {{{
" https://github.com/junegunn/vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pearofducks/ansible-vim'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
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
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
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
let mapleader=" "

set termguicolors
colorscheme catppuccin_mocha
set background=light

runtime vim-surround-config.vim
runtime coc-config.vim

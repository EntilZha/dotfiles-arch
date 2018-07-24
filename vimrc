" Setup Vundle
filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf/
set shell=bash
call vundle#begin()

" Framework Vim
Plugin 'gmarik/Vundle.vim'

" Search, File Directories...
Plugin 'junegunn/fzf.vim' " Fuzzy finder search
Plugin 'scrooloose/nerdtree' " File navigation tree
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-unimpaired'

" Buffer plugins
Plugin 'rbgrouleff/bclose.vim' " Close buffers without closing window
Plugin 'ap/vim-buftabline'
Plugin 'bufkill.vim'
Plugin 'jlanzarotta/bufexplorer' " Better buffer explorer

" Language Support
Plugin 'w0rp/ale'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'vim-scripts/SQLComplete.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'dag/vim-fish'
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-scripts/nginx.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'derekwyatt/vim-scala'

" Stylistic
Plugin 'jacoborus/tender.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" Auto completion and snippets
Plugin 'szw/vim-tags' " ctags support
Plugin 'Valloric/YouCompleteMe' " Tab autocompletion
Plugin 'davidhalter/jedi-vim' " Python jedi support

" Utility
Plugin 'scrooloose/nerdcommenter' " Comment code easily
Plugin 'jiangmiao/auto-pairs'
Plugin 'tmhedberg/SimpylFold' " Code folding
Plugin 'easymotion/vim-easymotion'

call vundle#end()

syntax on
filetype plugin indent on
set encoding=utf-8
set showcmd
set foldlevel=3
set t_Co=256
set term=xterm-256color

" Configure line number stuff
set number
set relativenumber
set cursorline
set scrolloff=3
let g:UseNumberToggleTrigger = 0

" Write out old file while switching contexts
set autowrite
set ruler


" Enable code folding
set foldenable

" Default tabstop and shiftwidth
set tabstop=2 shiftwidth=2
set backspace=indent,eol,start
set expandtab


" Configure search
set hlsearch
set incsearch
set ignorecase
set smartcase
set tags=/home/entilzha/tags,./tags,tags;

" Disable backup and swapfile
set noswapfile
set nobackup

" Set gui options
set guioptions-=r
set guioptions-=L

" Enable mouse
set mouse=a

" Set my color scheme and preferred font
set guifont="Anonymice Powerline"
set guioptions-=m
set guioptions-=T
set guioptions-=r

if (has("termguicolors"))
  set termguicolors
endif
colorscheme tender

let NERDTreeIgnore = ['\.pyc$']

let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'

" Set preview/scratch off
set completeopt=menu

" Let me have command autocomplete like in bash
set wildmenu
set wildmode=list:longest

" Set splits to be natural
set splitbelow
set splitright

" Enable list of buffers and show only filename
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2
set noshowmode

" Disable pandoc changing symbols in markdown
let g:pandoc#syntax#conceal#use = 0

" Configure Pandoc to not fold so much
let g:pandoc#folding#level = 4

" Configure LaTeX-Box
let g:LatexBox_latexmk_preview_continuously = 1
let g:LatexBox_quickfix = 4

" Configure LaTeX-Box
let g:LatexBox_latexmk_options = "-pvc -pdfps"


" Remap leader
let mapleader=","

" Easier vertical split
nnoremap <leader>v <C-w>v<C-w>l

" Buffer shortcuts
nnoremap <C-Tab> :bnext<cr>
nnoremap <C-S-Tab> :bprevious<cr>
nnoremap <C-~> :Bclose<cr>

" YCM Config
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Remap autocomplete to something more natural
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" Remap pane switching shortcuts
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Treat long lines as break lines
map j gj
map k gk

" Unhighlight
nnoremap <Leader>hh :nohl<cr>
nnoremap <Leader>hn :hl<cr>

" Buffers
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>t :Tags<CR>

" Make the preview of methods on autocomplete close once a selection is made
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Open files that are not vim in their correct program
augroup nonvim
   au!
   au BufRead *.png,*.jpg,*.pdf,*.gif,*.xls* sil exe "!open " . shellescape(expand("%:p")) | bd | let &ft=&ft
   au BufRead *.ppt*,*.doc*,*.rtf let g:output_pdf = shellescape(expand("%:r") . ".pdf")
   au BufRead *.ppt*,*.doc*,*.rtf sil exe "!/usr/local/bin/any2pdf " . shellescape(expand("%:p"))
   au BufRead *.ppt*,*.doc*,*.rtf sil exe "!open " . g:output_pdf | bd | let &ft=&ft
augroup end

" Force *.md files to be recognized as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown


" Don't let vim make a bell on entering
set noerrorbells
set novisualbell
autocmd! GUIEnter * set vb t_vb=

" Highlight whitespaces at end of line not on current editing line
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=blue guibg=#AAD7E6


" Convention for me is to map <Leader>c to whatever the related
" compile function is in the langauge. This occurs in the ftplugin

" Set spell check for markdown
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell

" Auto open nerdtree and close when its the only thing left
" autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nnoremap <C-N> :NERDTreeToggle<CR>

" Start vim with file focused instead of nerdtree
autocmd VimEnter * wincmd p
autocmd VimEnter * if (line('$') == 1 && getline(1) == '') | wincmd p | endif

" Disable YCM for C/C++ for Grappa project
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1,
      \ 'hpp': 1,
			\ 'cpp': 1}

" Save file when focus is lost
autocmd BufLeave,FocusLost * wall

" Eliminate delay from insert to normal mode
set timeoutlen=1000 ttimeoutlen=0

let g:vim_json_syntax_conceal = 0

" Change cursor modes
au InsertEnter * silent execute "!echo -en \<esc>[5 q"
au InsertLeave * silent execute "!echo -en \<esc>[2 q"


let g:lightline = {
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ }
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

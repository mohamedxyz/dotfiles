set nocompatible " detach vi from vim and neovim, required
filetype on " auto recognize file types, required
filetype plugin on
filetype indent on
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter' " toggle comments
Plug '907th/vim-auto-save' " auto save buffers
Plug 'vim-airline/vim-airline' " status bar
Plug 'vim-airline/vim-airline-themes' " themes for vim-airline
Plug 'norcalli/nvim-colorizer.lua' " html css colorizer for (neo)vim
Plug 'vim-scripts/c.vim' " I just use it for compiling
Plug 'shime/vim-livedown' " live preview for markdown and html
Plug 'agude/vim-eldar' " color scheme
Plug 'tpope/vim-surround' " surround vim
Plug 'dense-analysis/ale' " for syntax checking
Plug 'ajh17/vimcompletesme' " a completion plugin
Plug 'drmingdrmer/xptemplate' " a templates engine
Plug 'mhinz/vim-signify' " show changes in git repository.
Plug 'jiangmiao/auto-pairs' " auto pairs
Plug 'mhinz/vim-startify' " starting menu for (neo)vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy finder
Plug 'junegunn/fzf.vim' " fuzzy finder
Plug 'Dimercel/todo-vim' " to do manager
Plug 'frazrepo/vim-rainbow' " rainbow brackets
"Initialize plugin system
call plug#end()
"---------------------------------- sets ----------------------------------
set number " show numbers
set relativenumber " show numbers relative
set smarttab
set cindent
au BufNewFile,BufRead *.py
    \ set expandtab " replace tabs with spaces
    \ set autoindent " copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
set expandtab "always uses spaces instead of tab characters
set autoindent
set smartindent
set noswapfile "don't make a swap file
set nobackup " no backup
set scrolloff=8 "when I scroll I want always some lines to not disappear
syntax on " highlighted syntax
set showmatch
set nowrap
set ignorecase
set hlsearch
colorscheme eldar
set termguicolors
set autoread
set history=1000
set spelllang=en_us
set hidden
set nowritebackup
set exrc
set secure
set foldmethod=manual
set numberwidth=5
set splitbelow
set splitright
set autochdir
lua require'colorizer'.setup()
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification
" ---------------------------------- Return to last edit position when opening files (script) ----------------------------------
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"Some information
"You can use expand(), see :h expand()
"In a script you could do this to get file-name:
"let fileName = expand('%:t:r')
"To get extension you could do:
"let fileExtension = expand('%:e')
"---------------------------------- mappings ----------------------------------
let g:mapleader = " "
inoremap jk <ESC>
nnoremap ; :
nmap <silent> gt :tabnext <CR>
nmap <silent> gT :tabprevious<CR>
nmap go :tabnew<space>
nmap <silent> ./ :nohlsearch <CR>
nnoremap Y y$
nnoremap fzf :Files<CR>
nnoremap <F7> :TODOToggle<CR>
vmap gh <plug>NERDCommenterToggle
nmap gh <plug>NERDCommenterToggle
"---------------------------------- autostart ----------------------------------
au vimenter * source ~/.config/nvim/init.vim
au vimenter * AirlineTheme simple
au vimenter *.md,*.html :LivedownToggle
au vimenter * :nohlsearch
au filetype * :RainbowLoad
"starting menu
if expand('%:t:r') == ''
au vimenter * :Startify
endif
let g:startify_bookmarks = [
  \ {'i': '~/.config/nvim/init.vim'},
  \ {'m': '~/java/main.java' },
  \ {'sj': '~/.vim/plugged/xptemplate/ftplugin//java/java.xpt.vim' },
  \ ]
"---------------------------------- xptemplate ----------------------------------
let g:xptemplate_key = '<F12>'
let g:xptemplate_vars = "SParg="
if expand('%:e') != ''
au vimenter * XPTreload
endif
"---------------------------------- run files ----------------------------------
au FileType c,cpp nnoremap <F10> :term ./
au FileType python nnoremap <silent> <F9> :term python3.10 %<CR>
au FileType java nnoremap <silent> <F9> :term java %<CR>
au FileType html nnoremap <silent> <F9> :LivedownToggle<CR>
au FileType markdown nnoremap <F9> :LivedownToggle<CR>
au FileType sh,bash nnoremap <F9> :term bash %<CR>
au FileType sh,bash nnoremap <space><F9> :term bash %<space>
"----------------------------------  move between splits ----------------------------------
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
"---------------------------------- ale ----------------------------------
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'c': ['clangtidy'],
\   'cpp': ['clangtidy'],
\   'html': ['tidy'],
\   'python': ['pylama'],
\   'sh': ['shellcheck'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'html': ['tidy'],
\   'python': ['autopep8'],
\   'sh': ['shfmt'],
\   'java': ['astyle'],
\}
let g:ale_sign_error = 'e>'
let g:ale_sign_warning = 'w*'
highlight ALEWarning ctermbg=Yellow
highlight ALEError ctermbg=Red
let g:ale_echo_msg_error_str = 'ERROR'
let g:ale_echo_msg_warning_str = 'WARNING'
let g:ale_echo_msg_format = '|%linter%| %s [typeof:%severity%]'
noremap <silent><leader>f :ALEFix<CR>
"---------------------------------- commands & functions ----------------------------------
command SPELL set spell!
command PI :PlugInstall
command PC :PlugClean
command RemoveEmptyLines :g/^$/d
command ArabicStyle :set arabic
command EnglishStyle :set noarabic
"---------------------------------- vim-airline ----------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="simple"
"---------------------------------- remove extra white space (script) ----------------------------------
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()
" Remove all trailing white spaces
"---------------------------------- vim-rainbow ----------------------------------
let g:rainbow_guifgs = ['#FFEE00', '#00FFDE', '#FF0012', '#FF00DE', '#00F7FF', '#FF9800']
"---------------------------------- netrw ----------------------------------
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent><F2> :call ToggleVExplorer()<CR>
let g:netrw_banner=0
let g:netrw_keepdir=1
let g:netrw_liststyle=3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

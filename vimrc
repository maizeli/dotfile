set number
set tabstop=4
set showmatch
set shiftwidth=4
set autoindent
set incsearch
set ignorecase
set smartcase
set hidden
set wrap
set wildmenu " 命令自动补全
set wildmode=list:longest
set autowrite " 自动保存
set ttimeoutlen=0
if has("mouse")
	set mouse=a
endif
set backspace=indent,eol,start
set laststatus=2 "显示状态栏
" 清除现有的statusline设置，不然刷新配置文件时会导致重复
set statusline=
" 添加新的statusline内容
set statusline+=%F "显示当前buffer绝对路径
set cursorline
syntax on

" 改变不同模式下的光标样式  https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
" Iterm2 https://iterm2.com/documentation/2.1/documentation-escape-codes.html
if $TERM_PROGRAM =~# 'iTerm'
	let &t_SI = "\<Esc>]50;CursorShape=1\x7" " 插入模式竖线
	let &t_EI = "\<Esc>]50;CursorShape=0\x7" " 普通模式方块
	let &t_SR = "\<Esc>]50;CursorShape=2\x7" " 替换模式半高度方块
endif

" inside tmux 不生效
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

" 自动切换输入法 github仓库 https://github.com/daipeihust/im-select
autocmd InsertLeave * :silent !im-select com.apple.keylayout.ABC

imap <c-f> <right>
imap <c-b> <left>
imap <c-a> <esc>I
imap <c-e> <esc>A
" imap <c-n> <esc>ji
" imap <c-p> <esc>ki
let mapleader=" "

nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l

nmap <c-\> :vs<CR>
nmap <c-/> :split<CR>

nnoremap <leader>q :q<CR>
nnoremap H :tabprevious<CR>
nnoremap L :tabnext<CR>

noremap / :set hlsearch<CR>/
noremap <leader>/ :set nohlsearch<CR>
noremap <leader>r :source ~/.vimrc<CR>
noremap <leader>e :tabe ~/.vimrc<CR>

nnoremap zc zfi{

vmap * y/<C-R>"<CR>
vmap # y?<C-R>"<CR>

let g:python3_supported = has('python3')


"============== buffers ===============
noremap <silent> <leader>bl :ls<CR>
noremap <silent> <leader>bo :enew<CR>
noremap <silent> <leader>bn :bnext<CR>
noremap <silent> <leader>bp :bprevious<CR>
noremap <silent> <leader>bd :bdelete<CR>
"============== buffers ===============

"============== NERDTree ==============
nnoremap <c-e> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"============== NERDTree ==============

"============== fzf ===================
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fc :Rg<CR>
nnoremap <leader>fs :Snippets<CR>
nnoremap <leader>fd :Commands<CR>
nnoremap <leader>fM :Maps<CR>
nnoremap <leader>fh :History<CR>
imap <c-x><c-f> <ESC>:cd %:p:h<CR>i<plug>(fzf-complete-path)
"============== fzf ===================

"============== vim-go ================
nnoremap <leader>rn :GoRename<CR>
nnoremap <leader>gi :GoImport 
nnoremap gi :GoImplements<CR>
nnoremap gr :GoReferrers<CR>
" nnoremap ge :cnext<CR>"下一个错误，需要执行完GoBuild命令后才生效
" nnoremap gE :cprevious<CR>"上一个错误
" nnoremap <leader>ge :cclose<CR>"关闭错误窗口
nnoremap <leader>gb :GoBuild<CR>"编译
nnoremap <leader>gd :GoDecls<CR>
nnoremap <leader>gf :GoFillStruct<CR>
nnoremap <leader>gat :GoAddTags
let g:go_auto_type_info = 1 "自动显示函数参数类型"
"============== vim-go ================

"============== deoplete ==============
let g:deoplete#enable_at_startup = 1
"============== deoplete ==============

"============== git ==============
nnoremap gb :Git blame<CR>
"============== git ==============

"============== ale ==============
nmap <silent> gE <Plug>(ale_previous_wrap)
nmap <silent> ge <Plug>(ale_next_wrap)
"============== ale ==============

"============== ultisnips ==============
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"============== ultisnips ==============

call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'NLKNguyen/papercolor-theme'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'easymotion/vim-easymotion'
if g:python3_supported
	Plug 'SirVer/ultisnips'

	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
	Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
endif
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

"============== PaperColor =================
set t_Co=256   " This is may or may not needed.
" 这里需要放到主题插件后
set background=light
colorscheme PaperColor"
"============== PaperColor =================
"
"============== base16-vim ================
" base16-vim
" set termguicolors
" let base16colorspace=256
"============== base16-vim ================

"============== dracula ================
" colorscheme dracula
"============== dracula ================

" colorscheme 256_jungle
" colorscheme 3dglasses

" ==== ondark ===
" syntax on
" colorscheme onedark
" ==== onedark ===

"============== easymotion ================
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
"============== easymotion ================
"
"
" 0:up, 1:down, 2:pgup, 3:pgdown, 4:top, 5:bottom
function! Tools_PreviousCursor(mode)
	if winnr('$') <= 1
		return
	endif
	noautocmd silent! wincmd p
	if a:mode == 0
		" exec "normal! \<c-y>"
	elseif a:mode == 1
		" exec "normal! \<c-e>"
	elseif a:mode == 2
		" exec "normal! ".winheight('.')."\<c-y>"
	elseif a:mode == 3
		" exec "normal! ".winheight('.')."\<c-e>"
	elseif a:mode == 4
		" normal! gg
	elseif a:mode == 5
		" normal! G
	elseif a:mode == 6
		exec "normal! \<c-u>"
	elseif a:mode == 7
		exec "normal! \<c-d>"
	elseif a:mode == 8
		" exec "normal! k"
	elseif a:mode == 9
		" exec "normal! j"
	endif
	noautocmd silent! wincmd p
endfunc

noremap <silent><leader>su :call Tools_PreviousCursor(6)<cr>
noremap <silent><leader>sd :call Tools_PreviousCursor(7)<cr>

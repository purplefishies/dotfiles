" --- Basic UI ---
set nocompatible
syntax on
set number              " line numbers
set norelativenumber    " relative numbers (great for navigation)
set cursorline          " highlight current line
set showmatch           " highlight matching brackets
set termguicolors       " true color support (if terminal supports it)

" --- Colors ---
set background=dark
colorscheme desert      " built-in; change to taste

" --- Indentation ---
set tabstop=4
set shiftwidth=4
set expandtab           " use spaces instead of tabs
set autoindent
set smartindent

" --- Search ---
set ignorecase
set smartcase
set hlsearch
set incsearch

" --- Scrolling / UX ---
set scrolloff=8
set sidescrolloff=8
set nowrap
set wildmenu            " better command-line completion
set lazyredraw

" --- Status line ---
set laststatus=2
set ruler

" --- Clipboard (works in WSL if configured) ---
set clipboard=unnamedplus

" --- File handling ---
set hidden
set nobackup
set nowritebackup
set updatetime=300

" --- Key mappings ---
nnoremap <leader>h :nohlsearch<CR>   " clear search highlight
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" --- Nice extras ---
set mouse=a            " enable mouse
set splitbelow
set splitright

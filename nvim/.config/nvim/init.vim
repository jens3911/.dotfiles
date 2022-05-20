" hello front end masters
set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

call plug#begin('~/.vim/plugged')

" Yes, I am a sneaky snek now
Plug 'ambv/black'

" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'

" Diagram
Plug 'jbyuki/venn.nvim'

" Plug 'nvim-lua/completion-nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'
" Plug 'tjdevries/nlua.nvim'
" Plug 'tjdevries/lsp_extensions.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

" Debugger Plugins
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'szw/vim-maximizer'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'rust-lang/rust.vim'
Plug 'darrikonn/vim-gofmt'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-dispatch'
Plug 'theprimeagen/vim-be-good'
Plug 'gruvbox-community/gruvbox'
Plug 'luisiacc/gruvbox-baby'
Plug 'tpope/vim-projectionist'
Plug 'tomlion/vim-solidity'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'vim-conf-live/vimconflive2021-colorscheme'
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'

" HARPOON!!
Plug 'mhinz/vim-rfc'

" prettier
Plug 'sbdchd/neoformat'


call plug#end()

" Adding local modules
" let &runtimepath.=',' . expand("$HOME") . '/personal/harpoon/master'
" let &runtimepath.=',' . expand("$HOME") . '/personal/vim-with-me/ui'
" let &runtimepath.=',' . expand("$HOME") . '/personal/git-worktree.nvim/master'
" let &runtimepath.=',' . expand("$HOME") . '/personal/refactoring.nvim/master'
" let &runtimepath.=',' . expand("$HOME") . '/personal/jvim.nvim'
" let &runtimepath.=',' . expand("$HOME") . '/personal/nvim-treesitter-context'
" let &runtimepath.=',' . expand("$HOME") . '/personal/tree-navigation'

" let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]

let loaded_matchparen = 1
let mapleader = " "

" noremap <leader>vwh :h <C-R>=expand("<cword>")<CR><CR>
" nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
" nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Ex<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
" nnoremap <Leader>+ :vertical resize +5<CR>
" nnoremap <Leader>- :vertical resize -5<CR>
" nnoremap <Leader>rp :resize 100<CR>
" nnoremap <Leader>ee oif err != nil {<CR>return nil, err<CR>}<CR><esc>kkI<esc>
" nnoremap <Leader>cpu a%" PRIu64 "<esc>
" nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
" nnoremap <leader>gt <Plug>PlenaryTestFile
" nnoremap <leader>vwm :lua require("vim-with-me").init()<CR>
" nnoremap <leader>dwm :lua require("vim-with-me").disconnect()<CR>
" nnoremap <leader>gll :let g:_search_term = expand("%")<CR><bar>:Gclog -- %<CR>:call search(g:_search_term)<CR>
" nnoremap <leader>gln :cnext<CR>:call search(_search_term)<CR>
" nnoremap <leader>glp :cprev<CR>:call search(_search_term)<CR>
" nnoremap <leader>nf :!./scripts/format.py %

nnoremap <Leader>rr :register<CR>

nnoremap <leader>x :silent !chmod +x %<CR>

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <Leader>k :m .-2<CR>==
nnoremap <Leader>j :m .+1<CR>==

nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" greatest remap ever = dont loose your paste by the selected
xnoremap <leader>p "_dP

" next greatest remap ever : copy to your system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

" greatest remap ever = dont loose your paste when deleting
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" vim TODO
" nmap <Leader>tu <Plug>BujoChecknormal
" nmap <Leader>th <Plug>BujoAddnormal
" let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" nnoremap <Leader>ww ofunction wait(ms: number): Promise<void> {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR>

" inoremap <C-c> <esc>

" fun! EmptyRegisters()
  "   let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    " for r in regs
      "   call setreg(r, [])
    " endfor
" endfun

" ES
" com! W w

" nmap <leader>nn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" augroup highlight_yank
"     autocmd!
 "    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
" augroup END

" augroup THE_PRIMEAGEN
  "   autocmd!
    " autocmd BufWritePre *.lua Neoformat
   "  autocmd BufWritePre * %s/\s\+$//e
   "  autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
" augroup END

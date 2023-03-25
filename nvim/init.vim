set tabstop=4
set shiftwidth=4 smarttab
set scrolloff=5

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

setlocal spell spelllang=en_us

set number
augroup numbertoggle
  	autocmd!
  	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

syntax enable
lua require('monokai').setup { palette = require('monokai').pro }

lua require('plugins')
lua require('nvim_tree')
lua require('lsp')
lua require('treesitter')

nnoremap <C-s> <cmd>NvimTreeToggle<CR>
nnoremap <C-M-f> <cmd>Telescope find_files<CR>
nnoremap <C-f> <cmd>Telescope live_grep<CR>
nnoremap <C-M-L> <cmd>PyrightOrganizeImports<CR>


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

" CTRL-Tab is next tab
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>

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


-- setup autocomplete
local cmp = require'cmp'

cmp.setup({
	snippet = {
    -- REQUIRED - you must specify a snippet engine
    	expand = function(args)
    	vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
    	completion = cmp.config.window.bordered(),
    	documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
    	['<C-b>'] = cmp.mapping.scroll_docs(-4),
    	['<C-f>'] = cmp.mapping.scroll_docs(4),
    	['<C-Space>'] = cmp.mapping.complete(),
      	['<C-e>'] = cmp.mapping.abort(),
      	['<CR>'] = cmp.mapping.confirm({ select = true }),
     	['<TAB>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      	{ name = 'nvim_lsp' },
      	{ name = 'vsnip' },
    }, {
      	{ name = 'buffer' },
    })
})

-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {
	
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
  end,
})

null_ls = require("null-ls")
null_ls.setup({
	sources = {
    	null_ls.builtins.diagnostics.pylint.with({
      		diagnostics_postprocess = function(diagnostic)
        		diagnostic.code = diagnostic.message_id
			end,
			extra_args = {
							"--disable=missing-module-docstring",
  							"--disable=missing-class-docstring",
							"--disable=missing-function-docstring",
							"--disable=too-few-public-methods",
							"--max-line-length=120",
						}
    	}),
    	null_ls.builtins.formatting.isort,
    
		null_ls.builtins.formatting.black.with({
    		extra_args = { "--line-length=120" }
  		}),

		null_ls.builtins.diagnostics.shellcheck
  	},
})

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

  	use {
  		'nvim-tree/nvim-tree.lua',
  		requires = {
    		'nvim-tree/nvim-web-devicons',
  		},
	}

	use 'tanvirtin/monokai.nvim'

	use {
  		'nvim-telescope/telescope.nvim', tag = '0.1.1',
  		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	use {
    	'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

	use 'jose-elias-alvarez/null-ls.nvim'
end)

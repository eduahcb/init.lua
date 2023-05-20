-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'lunarvim/horizon.nvim'

  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate',
    requires = {
      {'JoosepAlviste/nvim-ts-context-commentstring'}
    }
  }

  use('thePrimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('vim-airline/vim-airline') 
  use('JoosepAlviste/nvim-ts-context-commentstring')

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v2.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {                                      -- Optional
		  'williamboman/mason.nvim',
		  run = function()
			  pcall(vim.cmd, 'MasonUpdate')
		  end,
	  },
	  {'williamboman/mason-lspconfig.nvim'}, -- Optional

	  -- Autocompletion
	  {'hrsh7th/nvim-cmp'},     -- Required
	  {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'}
  }

}

use {
	"folke/trouble.nvim",
	requires = "nvim-tree/nvim-web-devicons",
	config = function()
		require("trouble").setup {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	end
}
end)

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require 'packer.util'.float({ border = 'rounded' })
    end,
  },
})

return packer.startup(function(use)
  use 'lewis6991/impatient.nvim' -- Caches modules to decrease load time
  use 'wbthomason/packer.nvim'

  use {
    'notjedi/nvim-rooter.lua', -- puts vim working directory at project root
    config = function() require 'nvim-rooter'.setup() end
  }
  use {
    'kyazdani42/nvim-tree.lua', -- file tree
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
    'nvim-lualine/lualine.nvim', -- status line
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use 'lukas-reineke/indent-blankline.nvim' -- indentation guides
  use {
    'akinsho/toggleterm.nvim', -- popup terminal w/persistence
    tag = 'v2.*',
  }
  use 'tpope/vim-surround'
  use 'tpope/vim-sleuth'
  use 'windwp/nvim-autopairs' -- automatically open & delete bracket/paren/quote pairs

  use {
    'nvim-treesitter/nvim-treesitter', -- syntax highlighting support
    run = function()
      require 'nvim-treesitter.install'.update({ with_sync = true })
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter-refactor', -- smart renames/current scope highlighting
    requires = 'nvim-treesitter/nvim-treesitter'
  }
  use {
    'numToStr/Comment.nvim', -- Comment toggling
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring', opt = true },
  }
  use {
    'JoosepAlviste/nvim-ts-context-commentstring', -- toggles comments in jsx/vue files
    requires = 'nvim-treesitter',
  }

  use {
    'nvim-lua/popup.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  use {
    'nvim-telescope/telescope-fzy-native.nvim',
    requires = 'nvim-telescope/telescope.nvim'
  }

  use {
    'stevearc/dressing.nvim',
  }

  -- use('jose-elias-alvarez/null-ls.nvim') -- lsp actions for non-lsp utilities like eslint
  use {
    'williamboman/mason.nvim', -- lsp tooling manager
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig'
    }
  }
  use 'hrsh7th/nvim-cmp' -- completions engine
  use 'hrsh7th/cmp-nvim-lsp' -- integrates language server completions
  use 'hrsh7th/cmp-nvim-lua' -- nvim-cmp source for neovim's lua api
  use 'hrsh7th/cmp-buffer' -- completions for words in current file
  use 'hrsh7th/cmp-path' -- path completions
  use 'hrsh7th/cmp-cmdline' -- completions for the command line
  use {
    'L3MON4D3/LuaSnip', -- snippets engine
    requires = 'saadparwaiz1/cmp_luasnip' -- connects LuaSnip to nvim-cmp
  }

  use 'cameron-wags/splash.nvim'

  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    run = ':CatppuccinCompile'
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require 'packer'.sync()
  end
end)

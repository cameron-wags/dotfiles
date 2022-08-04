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
  -- Caches modules to decrease load time
  use 'lewis6991/impatient.nvim'
  use 'wbthomason/packer.nvim'
  -- use('nlknguyen/copy-cut-paste.vim')
  -- puts vim working directory at project root
  use {
    'notjedi/nvim-rooter.lua',
    config = function() require 'nvim-rooter'.setup() end
  }
  -- file tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  -- good looking buffer 'tabs'
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  -- indentation guides
  use 'lukas-reineke/indent-blankline.nvim'
  -- popup terminal w/persistence
  use {
    'akinsho/toggleterm.nvim',
    tag = 'v2.*',
  }
  use 'tpope/vim-surround'
  -- automatically open & delete bracket/paren/quote pairs
  use 'windwp/nvim-autopairs'

  -- syntax highlighting support
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require 'nvim-treesitter.install'.update({ with_sync = true })
    end
  }
  -- smart renames/current scope highlighting
  use {
    'nvim-treesitter/nvim-treesitter-refactor',
    requires = 'nvim-treesitter/nvim-treesitter'
  }
  -- Comment toggling
  use {
    'numToStr/Comment.nvim',
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring', opt = true },
  }
  -- toggles comments in jsx/vue files
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
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

  -- lsp actions for non-lsp utilities like eslint
  -- use('jose-elias-alvarez/null-ls.nvim')
  -- lsp tooling manager
  use {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig'
    }
  }
  -- completions engine
  use 'hrsh7th/nvim-cmp'
  -- integrates language server completions
  use 'hrsh7th/cmp-nvim-lsp'
  -- nvim-cmp source for neovim's lua api
  use 'hrsh7th/cmp-nvim-lua'
  -- completions for words in current file
  use 'hrsh7th/cmp-buffer'
  -- path completions
  use 'hrsh7th/cmp-path'
  -- completions for the command line
  use 'hrsh7th/cmp-cmdline'
  -- snippets engine
  use {
    'L3MON4D3/LuaSnip',
    -- connects LuaSnip to nvim-cmp
    requires = 'saadparwaiz1/cmp_luasnip'
  }

  -- colorscheme
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    run = 'CatppuccinCompile'
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require 'packer'.sync()
  end
end)

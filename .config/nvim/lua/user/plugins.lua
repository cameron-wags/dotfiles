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

local use = packer.use;
-- Install your plugins here
return packer.startup(function()
  -- Caches modules to decrease load time
  use 'lewis6991/impatient.nvim'
  use 'wbthomason/packer.nvim'
  -- use('nlknguyen/copy-cut-paste.vim')
  use 'tpope/vim-surround'
  -- puts vim working directory at project root
  use {
    'notjedi/nvim-rooter.lua',
    config = function() require 'nvim-rooter'.setup() end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require 'nvim-treesitter.install'.update({ with_sync = true })
    end
  }
  -- language server support
  -- use('jose-elias-alvarez/null-ls.nvim')
  -- smart renames/current scope highlighting
  use {
    'nvim-treesitter/nvim-treesitter-refactor',
    requires = 'nvim-treesitter/nvim-treesitter'
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
  -- tries to find language servers?
  -- more: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  use 'neovim/nvim-lspconfig'
  -- completions engine
  use 'hrsh7th/nvim-cmp'
  -- lua interface for completions
  use 'hrsh7th/cmp-nvim-lua'
  -- lisp interface for completions
  use 'hrsh7th/cmp-nvim-lsp'
  -- completions for words in current file
  use 'hrsh7th/cmp-buffer'
  -- path completions
  use 'hrsh7th/cmp-path'
  -- completions for the command line
  use 'hrsh7th/cmp-cmdline'
  -- snippets engine
  use 'L3MON4D3/LuaSnip' -- depends on cmp_luasnip
  -- connects LuaSnip to nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- depends on LuaSnip, nvim-cmp
  -- use language servers w/o restarting
  use 'williamboman/nvim-lsp-installer' -- depends on nvim-lspconfig
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
  -- indentation guides
  use 'lukas-reineke/indent-blankline.nvim'
  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  -- toggles comments
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    requires = 'nvim-treesitter',
  }
  use {
    'numToStr/Comment.nvim',
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring', opt = true },
  }
  -- automatically open & delete bracket/paren/quote pairs
  use 'windwp/nvim-autopairs'
  -- popup terminal w/persistence
  use {
    'akinsho/toggleterm.nvim',
    tag = 'v2.*',
  }

  -- coLorscheme
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

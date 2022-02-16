local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
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
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nlknguyen/copy-cut-paste.vim")
	-- use("godlygeek/tabular")
	use("plasticboy/vim-markdown") -- depends on tabular
	-- live html/css/js preview in browser
	--use({ "turbio/bracey.vim", cmd = "Bracey" })
	use("tpope/vim-surround")
	-- Git commit logs but for undo
	--use({ "mbbill/undotree", cmd = "UndotreeShow" })
	use("junegunn/fzf", {
		run = function()
			vim.fn["fzf#install"](0)
		end,
	})
	use("junegunn/fzf.vim")
	-- puts vim working directory at project root
	use("airblade/vim-rooter")
	use("norcalli/nvim-colorizer.lua")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	-- bracket pair colorizer
	-- use("p00f/nvim-ts-rainbow")
	-- language server support
	use("jose-elias-alvarez/null-ls.nvim")
	-- treesitter parser state viewer
	--use("nvim-treesitter/playground")
	-- smart renames/current scope highlighting
	use("nvim-treesitter/nvim-treesitter-refactor")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim") -- depends on plenary
	-- git gutter and diff preview
	-- use("lewis6991/gitsigns.nvim") -- depends on plenary
	use("nvim-telescope/telescope.nvim") -- depends on plenary
	use("nvim-telescope/telescope-fzy-native.nvim")
	-- tries to find language servers?
	-- more: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	use("neovim/nvim-lspconfig")
	-- completions engine
	use("hrsh7th/nvim-cmp")
	-- lua interface for completions
	use("hrsh7th/cmp-nvim-lua")
	-- lisp interface for completions
	use("hrsh7th/cmp-nvim-lsp")
	-- completions for words in current file
	use("hrsh7th/cmp-buffer")
	-- path completions
	use("hrsh7th/cmp-path")
	-- completions for the command line
	-- use("hrsh7th/cmp-cmdline")
	-- snippets engine
	use("L3MON4D3/LuaSnip") -- depends on cmp_luasnip
	-- connects LuaSnip to nvim-cmp
	use("saadparwaiz1/cmp_luasnip") -- depends on LuaSnip, nvim-cmp
	-- more snippets
	--use("rafamadriz/friendly-snippets")
	-- use language servers w/o restarting
	use("williamboman/nvim-lsp-installer") -- depends on nvim-lspconfig
	-- ah yes why not have icons
	use("kyazdani42/nvim-web-devicons")
	-- file tree
	use("kyazdani42/nvim-tree.lua")
	-- good looking buffer 'tabs'
	use("akinsho/bufferline.nvim") -- depends on nvim-web-devicons(optional)
	-- indentation guides
	use("lukas-reineke/indent-blankline.nvim")
	-- greeter for when you open vim not knowing what you're about to edit
	-- use("goolord/alpha-nvim") -- depends on nvim-web-devicons
	-- status line
	use("nvim-lualine/lualine.nvim") -- depends on nvim-web-devicons
	-- toggles comments
	use({
		"numToStr/Comment.nvim",
		requires = { "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
	})
	-- automatically delete bracket/paren/quote pairs
	--use("windwp/nvim-autopairs")
	-- adds icons to completions saying what they are
	use("onsails/lspkind-nvim")
	-- better integrated terminals
	-- use("akinsho/toggleterm.nvim")
    -- Language support, but more people like treesitter
    --use("sheerun/vim-polyglot")

	-- coLorscheme
	use("catppuccin/nvim")
	-- use("rebelot/kanagawa.nvim")
	--use("folke/tokyonight.nvim")
	--use("LunarVim/onedarker.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

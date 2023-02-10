local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

require 'lazy'.setup({
	{
		'notjedi/nvim-rooter.lua',
		lazy = false,
		config = true,
	},
	{
		'kyazdani42/nvim-tree.lua',
		lazy = true,
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
		config = function() require 'user.nvimtree' end,
	},
	{
		'nvim-lualine/lualine.nvim',
		lazy = false,
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		config = function() require 'user.lualine' end,
	},
	{
		'numToStr/FTerm.nvim',
		lazy = true,
		opts = {
			ft = 'FTerm',
			border = 'rounded',
			auto_close = true,
			dimensions = {
				height = 1.0,
				width = 1.0,
				x = 0.5,
				y = 0.5,
			},
		}
	},
	{
		'tpope/vim-surround',
		event = 'VeryLazy',
	},
	{
		'nmac427/guess-indent.nvim',
		lazy = false,
		config = function()
			require 'guess-indent'.setup()
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = function()
			require 'nvim-treesitter.install'.update({ with_sync = true })
		end,
		dependencies = { 'nvim-treesitter/nvim-treesitter-refactor' },
		config = function() require 'user.treesitter' end,
	},
	{
		'numToStr/Comment.nvim',
		dependencies = { { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true } },
		config = function() require 'user.comment' end,
		event = 'VeryLazy',
	},
	{
		'nvim-lua/popup.nvim',
		lazy = true,
		dependencies = { 'nvim-lua/plenary.nvim', lazy = true },
	},
	{
		'nvim-telescope/telescope.nvim',
		lazy = true,
		dependencies = {
			{ 'nvim-lua/plenary.nvim', lazy = true },
			{ 'nvim-telescope/telescope-fzy-native.nvim', lazy = true }
		},
		cmd = 'Telescope',
		config = function()
			local telescope = require 'telescope'
			telescope.setup {
				defaults = {
					layout_strategy = 'flex',
					layout_config = {
						flex = {
							prompt_position = 'bottom',
							flip_columns = 180,
							flip_lines = 60,
							horizontal = {
								preview_width = 0.6,
							},
							vertical = {
								preview_height = 0.45,
							},
						},
					},
				},
				extensions = {
					fzy_native = {
						override_generic_sorter = true,
						override_file_sorter = true,
					}
				}
			}
			telescope.load_extension('fzy_native')
		end,
	},
	{
		'stevearc/dressing.nvim',
		event = 'VeryLazy',
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		lazy = false,
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			{ 'L3MON4D3/LuaSnip' },
		},
		config = function() require 'user.lsp-zero' end,
		priority = 50,
	},
	{
		'jose-elias-alvarez/null-ls.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		lazy = false,
		config = function() require 'user.null-ls' end,
		priority = 49,
	},
	-- {
	-- 	url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim.git',
	-- 	config = function() require 'lsp_lines'.setup() end,
	-- 	after = 'nvim-lspconfig',
	-- 	priority = 49,
	-- },
	{
		'windwp/nvim-autopairs', -- automatically open & delete bracket/paren/quote pairs
		lazy = false,
		requires = 'hrsh7th/nvim-cmp',
		config = function() require 'user.autopair' end,
		priority = 49,
	},
	{
		'mhinz/vim-startify',
		lazy = false,
		config = function() require 'user.startify' end,
		priority = 99,
	},
	{
		'catppuccin/nvim',
		lazy = false,
		name = 'catppuccin',
		config = function()
			require 'user.colorscheme'
			vim.cmd.colorscheme 'catppuccin'
		end,
		priority = 1000,
	},
	-- {
	-- 	'mechatroner/rainbow_csv',
	-- },
	{
		'cameron-wags/rainbow_csv.nvim',
		-- dir = '/Users/cameron/g/rainbow_csv.nvim',
		config = true,
		ft = {
			'csv',
			'tsv',
			'csv_semicolon',
			'csv_whitespace',
			'csv_pipe',
			'rfc_csv',
			'rfc_semicolon',
		},
		cmd = {
			'RainbowDelim',
			'RainbowDelimSimple',
			'RainbowDelimQuoted',
			'RainbowMultiDelim',
		},
	},
}, opts)

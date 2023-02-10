-- Automatically install packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()
-- Reload the config when saving this file
local packer_user_config = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost',
	{
		group = packer_user_config,
		pattern = 'plugins.lua',
		callback = function()
			vim.cmd '%so'
			vim.cmd 'PackerSync'
		end,
	})

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

packer.startup(function(use)
	use 'lewis6991/impatient.nvim' -- Caches modules to decrease load time
	use 'wbthomason/packer.nvim'

	use {
		'notjedi/nvim-rooter.lua', -- puts vim working directory at project root
		config = function() require 'nvim-rooter'.setup() end
	}
	use {
		'kyazdani42/nvim-tree.lua', -- file tree
		requires = 'kyazdani42/nvim-web-devicons',
		config = function() require 'user.nvimtree' end,
		cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
	}
	use {
		'nvim-lualine/lualine.nvim', -- status line
		requires = 'kyazdani42/nvim-web-devicons',
		config = function() require 'user.lualine' end,
	}

	use { 'numToStr/FTerm.nvim',
		config = function()
			require 'FTerm'.setup {
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
		end,
		module = 'FTerm',
	}

	use {
		'tpope/vim-surround',
		event = "CursorMoved",
	}

	use {
		'nmac427/guess-indent.nvim',
		config = function()
			require 'guess-indent'.setup()
		end,
	}

	use {
		-- syntax highlighting support
		'nvim-treesitter/nvim-treesitter',
		run = function()
			require 'nvim-treesitter.install'.update({ with_sync = true })
		end,
		config = function() require 'user.treesitter' end,
	}
	use {
		'nvim-treesitter/nvim-treesitter-refactor', -- smart renames/current scope highlighting
		requires = 'nvim-treesitter/nvim-treesitter'
	}

	use {
		'numToStr/Comment.nvim', -- Comment toggling
		requires = { 'JoosepAlviste/nvim-ts-context-commentstring', opt = true },
		config = function() require 'user.comment' end,
		event = 'CursorMoved',
	}
	use {
		'JoosepAlviste/nvim-ts-context-commentstring', -- toggles comments in jsx/vue files
		requires = 'nvim-treesitter',
		module_pattern = 'ts_context_commentstring.*',
	}

	use {
		'nvim-lua/plenary.nvim',
		module = 'plenary',
		module_pattern = 'plenary.*'
	}

	use {
		'nvim-lua/popup.nvim',
		requires = 'nvim-lua/plenary.nvim',
		module = 'popup',
	}

	use {
		'nvim-telescope/telescope-fzy-native.nvim',
		module = 'telescope._extensions.fzy_native',
	}

	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim' },
		module = 'telescope.builtin',
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
	}

	use {
		'stevearc/dressing.nvim',
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
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
	}

	use {
		'jose-elias-alvarez/null-ls.nvim',
		config = function() require 'user.null-ls' end,
	}

	-- -- Display diagnostics in virtual lines instead of text off to the side
	-- -- https://sr.ht/~whynothugo/lsp_lines.nvim/
	-- use {
	-- 	'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
	-- 	config = function()
	-- 		require 'lsp_lines'.setup()
	-- 	end,
	-- 	after = 'nvim-lspconfig',
	-- }
	-- 	'hrsh7th/cmp-cmdline', -- completions for the command line
	-- 	after = 'nvim-lspconfig',
	-- }

	use {
		'windwp/nvim-autopairs', -- automatically open & delete bracket/paren/quote pairs
		requires = 'hrsh7th/nvim-cmp',
		config = function()
			require 'user.autopair'
		end,
		after = 'lsp-zero.nvim',
	}

	-- use 'cameron-wags/splash.nvim'
	use {
		'mhinz/vim-startify',
		config = function()
			require 'user.startify'
		end,
	}

	-- use {
	-- 	'folke/tokyonight.nvim',
	-- 	config = function()
	-- 		require('tokyonight').setup {
	-- 			transparent = false,
	-- 			terminal_colors = true,
	-- 			style = 'night',
	-- 		}
	-- 		vim.cmd.colorscheme 'tokyonight'
	-- 	end,
	-- }

	-- use {
	-- 	'sainnhe/sonokai',
	-- 	config = function()
	-- 		vim.g.sonokai_style = 'espresso'
	-- 		vim.g.sonokai_better_performance = 1
	-- 		vim.cmd.colorscheme 'sonokai'
	-- 	end
	-- }

	use {
		'catppuccin/nvim',
		as = 'catppuccin',
		run = ':CatppuccinCompile',
		config = function()
			require 'user.colorscheme'
			vim.cmd.colorscheme 'catppuccin'
		end,
	}

	-- use 'mechatroner/rainbow_csv'
	use {
		-- '/Users/cameron/g/rainbow_csv.nvim',
		'cameron-wags/rainbow_csv.nvim',
		config = function()
			require 'rainbow_csv'.setup()
		end,
		module = {
			'rainbow_csv',
			'rainbow_csv.fns'
		},
		ft = {
			'csv',
			'tsv',
			'csv_semicolon',
			'csv_whitespace',
			'csv_pipe',
			'rfc_csv',
			'rfc_semicolon',
		}
	}

	if packer_bootstrap then
		packer.sync()
	end
end)

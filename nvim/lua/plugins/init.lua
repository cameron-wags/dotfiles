return {
	{
		'notjedi/nvim-rooter.lua',
		config = true,
		event = {
			'BufEnter',
			'BufRead',
		},
	},
	{
		'tpope/vim-surround',
		event = {
			'BufRead',
			'BufNewFile',
		},
	},
	{
		'nmac427/guess-indent.nvim',
		config = true,
		event = {
			'BufRead',
			'BufNewFile',
		},
	},
	{
		'stevearc/dressing.nvim',
		event = 'VeryLazy',
	},
	{
		'nvim-lua/popup.nvim',
		lazy = true,
		dependencies = { 'nvim-lua/plenary.nvim', lazy = true },
	},
	{
		'stevearc/oil.nvim',
		lazy = false,
		opts = {
			float = {
				padding = 3,
			},
			keymaps = {
				['<leader>o'] = 'actions.close',
			}
		},
	},
	{
		'nvim-telescope/telescope.nvim',
		lazy = true,
		dependencies = {
			{ 'nvim-lua/plenary.nvim',                    lazy = true },
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
		'numToStr/FTerm.nvim',
		lazy = true,
		opts = {
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
	-- {
	-- 	'mechatroner/rainbow_csv',
	-- },
	{
		'cameron-wags/rainbow_csv.nvim',
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
}

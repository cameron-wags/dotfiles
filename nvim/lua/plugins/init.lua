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
			telescope.load_extension 'fzy_native'
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
	{
		'echasnovski/mini.statusline',
		version = false,
		dependencies = { 'nvim-tree/nvim-web-devicons', 'lewis6991/gitsigns.nvim' },
		config = function()
			require 'gitsigns'.setup()
			local sl = require 'mini.statusline'
			sl.setup {
				content = {
					active = function()
						local mode, mode_hl = sl.section_mode { trunc_width = 120 }
						local git           = sl.section_git { trunc_width = 75 }
						local diagnostics   = sl.section_diagnostics { trunc_width = 75 }
						local filename      = sl.section_filename { trunc_width = 140 }
						local fileinfo      = sl.section_fileinfo { trunc_width = 120 }
						local location      = sl.section_location { trunc_width = 9999 }

						return sl.combine_groups {
							{ hl = mode_hl,                 strings = { mode } },
							{ hl = 'MiniStatuslineDevinfo', strings = { git } },
							'%<', -- Mark general truncate point
							{ hl = 'Normal',                 strings = { filename } },
							'%=', -- End left alignment
							{ hl = 'MiniStatuslineDevinfo',  strings = { diagnostics } },
							{ hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
							{ hl = mode_hl,                  strings = { location } },
						}
					end,
					inactive = function()
						local filename = sl.section_filename { trunc_width = 140 }
						return sl.combine_groups {
							{ hl = 'MiniStatuslineDevinfo', strings = { filename } },
						}
					end
				}
			}
		end
	},
	{
		'echasnovski/mini.tabline',
		version = false,
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require 'mini.tabline'.setup()
		end
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

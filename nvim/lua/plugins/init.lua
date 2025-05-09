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
		'tpope/vim-fugitive',
		lazy = true,
		cmd = { 'G', 'Git' },
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
		'echasnovski/mini.pairs',
		event = {
			'BufRead',
			'BufNewFile',
		},
		config = true,
	},
	{
		'stevearc/oil.nvim',
		lazy = true,
		opts = {
			default_file_explorer = false,
			delete_to_trash = true,
			float = {
				padding = 3,
			},
			keymaps = {
				['<leader>o'] = 'actions.close',
				['<Esc>'] = { 'actions.close', mode = 'n' },
			},
			view_options = {
				show_hidden = true,
			},
		},
	},
	{
		'folke/todo-comments.nvim',
		lazy = false,
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			signs = false,
			keywords = {
				FIX = {
					color = "error",
					alt = { "FIXME", "fixme" },
				},
				TODO = {
					color = "info",
					alt = { 'todo' },
				},
			},
			merge_keywords = false,
			highlight = {
				pattern = [[.*<(KEYWORDS)\s*:?]],
				keyword = "bg",
				exclude = {}, -- list of file types to exclude highlighting
			},
			search = {
				-- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
	},
	{
		'nvim-telescope/telescope.nvim',
		lazy = false,
		dependencies = {
			{ 'nvim-lua/plenary.nvim', lazy = true },
		},
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
			}
		end,
	},
	{
		'echasnovski/mini.statusline',
		version = false,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			{ 'echasnovski/mini-git', lazy = true },
		},
		event = 'VeryLazy',
		config = function()
			require 'mini.git'.setup()
			local sl = require 'mini.statusline'

			local function get_filesize()
				local size = vim.fn.getfsize(vim.fn.getreg('%'))
				if size < 1024 then
					return string.format('%dB', size)
				elseif size < 1048576 then
					return string.format('%.2fKiB', size / 1024)
				else
					return string.format('%.2fMiB', size / 1048576)
				end
			end

			local function get_icon()
				return (require 'nvim-web-devicons'.get_icon(vim.fn.expand('%:t'), nil, { default = true }))
			end

			local function custom_fileinfo(args)
				local filetype = vim.bo.filetype

				-- Don't show anything if there is no filetype
				if filetype == '' then return '' end

				-- Add filetype icon
				filetype = get_icon() .. ' ' .. filetype

				-- Construct output string if truncated or buffer is not normal
				if MiniStatusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= '' then return filetype end

				-- Construct output string with extra file info
				local encoding = vim.bo.fileencoding or vim.bo.encoding
				local format = vim.bo.fileformat
				local size = get_filesize()

				if encoding == 'utf-8' and format == 'unix' then
					return string.format('%s %s', filetype, size)
				else
					return string.format('%s %s[%s] %s', filetype, encoding, format, size)
				end
			end

			sl.setup {
				content = {
					active = function()
						local mode, mode_hl = sl.section_mode { trunc_width = 120 }
						local git           = sl.section_git { trunc_width = 75 }
						local diagnostics   = sl.section_diagnostics { trunc_width = 75 }
						local filename      = sl.section_filename { trunc_width = 140 }
						local fileinfo      = custom_fileinfo { trunc_width = 120 }
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
	{
		'cameron-wags/term.nvim',
		config = true,
		lazy = true,
		cmd = {
			'Term',
		}
	},
}

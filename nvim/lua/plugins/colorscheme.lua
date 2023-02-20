return {
	'catppuccin/nvim',
	lazy = false,
	priority = 1000,
	name = 'catppuccin',
	config = function()
		require 'catppuccin'.setup {
			flavour = 'mocha',
			transparent_background = false,
			styles = {
				comments = { 'italic', 'bold' },
				functions = { 'italic' },
				keywords = { 'italic' },
				strings = {},
				variables = {},
			},
			custom_highlights = function(colors)
				return {
					VertSplit = {
						fg = colors.text,
					},
					Comment = {
						fg = colors.overlay0,
					},
					Cursor = {
						fg = colors.base,
						bg = colors.text,
					},
					lCursor = {
						fg = colors.base,
						bg = colors.text,
					},
					CursorIM = {
						fg = colors.base,
						bg = colors.text,
					},
				}
			end,
			integrations = {
				cmp = true,
				dap = {
					enabled = false,
					enable_ui = false,
				},
				gitsigns = true,
				markdown = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { 'italic' },
						hints = { 'italic' },
						warnings = { 'italic' },
						information = { 'italic' },
					},
					underlines = {
						errors = { 'underline' },
						hints = { 'underline' },
						warnings = { 'underline' },
						information = { 'underline' },
					},
				},
				notify = true,
				nvimtree = {
					enabled = true,
					show_root = true,
				},
				symbols_outline = true,
				telescope = true,
				treesitter = true,
				ts_rainbow = true,
			},
		}
		vim.cmd.colorscheme 'catppuccin'
	end,
}

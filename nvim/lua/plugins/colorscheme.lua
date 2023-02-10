return {
	'catppuccin/nvim',
	lazy = false,
	priority = 1000,
	name = 'catppuccin',
	config = function()
		vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha

		require 'catppuccin'.setup {
			transparent_background = false,
			compile = {
				enabled = true,
				path = vim.fn.stdpath 'cache' .. '/catppuccin',
				suffix = '_compiled',
			},
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
				treesitter = true,
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
				lsp_trouble = false,
				cmp = true,
				lsp_saga = false,
				gitsigns = true,
				leap = false,
				telescope = true,
				nvimtree = {
					enabled = true,
					show_root = true,
				},
				dap = {
					enabled = false,
					enable_ui = false,
				},
				indent_blankline = {
					enabled = false,
					colored_indent_levels = false,
				},
				dashboard = true,
				neogit = false,
				vim_sneak = false,
				fern = false,
				barbar = false,
				bufferline = false,
				markdown = true,
				lightspeed = false,
				ts_rainbow = true,
				hop = false,
				notify = true,
				symbols_outline = true
			},
		}
		vim.cmd.colorscheme 'catppuccin'
	end,
}

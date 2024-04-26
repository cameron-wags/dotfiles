return {
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		enabled = true,
		config = function()
			require 'tokyonight'.setup {
				style = 'night',
				on_colors = function(c)
					c.bg = '#000000'
				end,
				on_highlights = function(hl, c)
					hl.Comment = {
						fg = '#7380b7'
					}
					hl.WinSeparator = {
						bg = c.terminal_black,
						fg = c.border,
					}
					hl.DiagnosticUnnecessary = {
						fg = c.fg,
					}
				end
			}
			vim.cmd.colo 'tokyonight'
		end
	},
	{
		'mcchrish/zenbones.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.zenbones_compat = true
			vim.g.zenbones_lightness = 'bright'
			vim.g.zenbones_transparent_background = false
			vim.g.zenbones_darken_comments = 50 -- percentage, default 38

			vim.g.zenwritten_compat = true
			vim.g.zenwritten_lightness = 'bright'
			vim.g.zenwritten_transparent_background = false
			vim.g.zenwritten_darken_comments = 50 -- percentage, default 38

			vim.schedule(function()
				if vim.o.background == 'light' then
					vim.cmd.colorscheme 'zenwritten'
				end
			end)
		end
	},
}

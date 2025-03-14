return {
	'nvim-tree/nvim-tree.lua',
	lazy = true,
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
	opts = {
		on_attach = function(bufnr)
			local function opts(desc)
				return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			local api = require 'nvim-tree.api'
			vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
			vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
			vim.keymap.set('n', 'e', function()
				api.node.open.edit()
				api.tree.focus()
			end, opts('open_keep_focus'))
			vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
		end,
		sync_root_with_cwd = true,
		view = {
			side = 'right',
		},
		filters = {
			git_ignored = false,
		},
		actions = {
			open_file = {
				quit_on_open = true,
				resize_window = true,
			},
		},
		git = {
			enable = false,
		}
	}
}

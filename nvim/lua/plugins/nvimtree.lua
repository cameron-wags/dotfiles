local function on_attach(bufnr)
	local api = require 'nvim-tree.api'

	local function opts(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
	vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
	vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
	vim.keymap.set('n', 'e', function()
		api.node.open.edit()
		api.tree.focus()
	end, opts('open_keep_focus'))
	vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
	vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
end

return {
	'nvim-tree/nvim-tree.lua',
	lazy = true,
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
	opts = {
		on_attach = on_attach,
		sync_root_with_cwd = true,
		view = {
			adaptive_size = true,
			side = 'right',
		},
		renderer = {
			special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
		},
		filters = {
			git_ignored = false,
		},
		actions = {
			open_file = {
				quit_on_open = true,
				resize_window = true,
			},
			remove_file = {
				close_window = true,
			},
		},
		trash = {
			cmd = 'trash',
		},
	}
}

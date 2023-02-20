local open_keep_focus = function()
	local api = require 'nvim-tree.api'
	api.node.open.edit()
	api.tree.focus()
end

return {
	'kyazdani42/nvim-tree.lua',
	lazy = true,
	dependencies = { 'kyazdani42/nvim-web-devicons' },
	cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
	opts = {
		sync_root_with_cwd = true,
		view = {
			adaptive_size = true,
			side = 'right',
			mappings = {
				custom_only = false,
				list = {
					{ key = { 'l', '<CR>', 'o' }, action = 'edit' },
					{ key = { 'e' }, action = 'open_keep_focus', action_cb = open_keep_focus },
					{ key = 'h', action = 'close_node' },
					{ key = 'v', action = 'vsplit' },
				},
			},
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
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
			require_confirm = true,
		},
	}
}

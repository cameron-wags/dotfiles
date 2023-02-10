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
		auto_reload_on_write = true,
		create_in_closed_folder = false,
		disable_netrw = true,
		hijack_cursor = false,
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = false,
		ignore_buffer_on_setup = false,
		open_on_setup = false,
		open_on_setup_file = false,
		open_on_tab = false,
		sort_by = 'name',
		update_cwd = true,
		reload_on_bufenter = false,
		respect_buf_cwd = false,
		view = {
			adaptive_size = true,
			width = 30,
			hide_root_folder = false,
			side = 'right',
			preserve_window_proportions = false,
			number = false,
			relativenumber = false,
			signcolumn = 'yes',
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
		renderer = {
			add_trailing = false,
			group_empty = false,
			highlight_git = false,
			highlight_opened_files = 'none',
			root_folder_modifier = ':~',
			indent_markers = {
				enable = false,
				icons = {
					corner = '└ ',
					edge = '│ ',
					none = '  ',
				},
			},
			icons = {
				webdev_colors = true,
				git_placement = 'before',
				padding = ' ',
				symlink_arrow = ' ➛ ',
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},
				glyphs = {
					default = '',
					symlink = '',
					folder = {
						arrow_closed = '',
						arrow_open = '',
						default = '',
						open = '',
						empty = '',
						empty_open = '',
						symlink = '',
						symlink_open = '',
					},
					git = {
						unstaged = '',
						staged = '',
						unmerged = '',
						renamed = '➜',
						untracked = '★',
						deleted = '',
						ignored = '◌',
					},
				},
			},
			special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
		},
		hijack_directories = {
			enable = true,
			auto_open = true,
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
			ignore_list = {},
		},
		ignore_ft_on_setup = {},
		system_open = {
			cmd = '',
			args = {},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			icons = {
				hint = '',
				info = '',
				warning = '',
				error = '',
			},
		},
		filters = {
			dotfiles = false,
			custom = {},
			exclude = {},
		},
		git = {
			enable = true,
			ignore = false,
			show_on_dirs = true,
			timeout = 500,
		},
		actions = {
			use_system_clipboard = true,
			change_dir = {
				enable = true,
				global = false,
				restrict_above_cwd = false,
			},
			expand_all = {
				max_folder_discovery = 300,
			},
			open_file = {
				quit_on_open = true,
				resize_window = true,
				window_picker = {
					enable = true,
					chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
					exclude = {
						filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
						buftype = { 'nofile', 'terminal', 'help' },
					},
				},
			},
			remove_file = {
				close_window = true,
			},
		},
		trash = {
			cmd = 'trash',
			require_confirm = true,
		},
		live_filter = {
			prefix = '[FILTER]: ',
			always_show_folders = true,
		},
		log = {
			enable = false,
			truncate = false,
			types = {
				all = false,
				config = false,
				copy_paste = false,
				diagnostics = false,
				git = false,
				profile = false,
			},
		},
	}
}

local symbols = {
	unix = '',
	dos = ' ',
	mac = ' ',
}

-- Tell me if the file isn't utf-8 or unix line endings.
local fileinfo_ignore_norms = function()
	local ret, _ = (vim.bo.fenc or vim.go.enc):gsub('^utf%-8$', '')
	local fmt = vim.bo.fileformat
	ret = ret .. (symbols[fmt] or fmt)
	return ret
end

return {
	'nvim-lualine/lualine.nvim',
	lazy = false,
	dependencies = { 'kyazdani42/nvim-web-devicons' },
	opts = {
		options = {
			theme = 'auto',
			icons_enabled = true,
			component_separators = { left = '', right = '' },
			section_separators = { left = '', right = '' },
			disabled_filetypes = { 'NvimTree', 'FTerm', 'help' },
			globalstatus = false,
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = {
				{ 'branch' },
				{
					'diff',
					symbols = { added = '+', modified = '~', removed = '-' },
				},
			},
			lualine_c = {
				{ 'filename', path = 1 },
			},
			lualine_x = {
				{
					'diagnostics',
					sources = { 'nvim_lsp' },
					update_in_insert = false,
					always_visible = false,
					symbols = {
						error = '✗',
						warn = '!',
						info = '',
						hint = '',
					},
					-- padding = { left = 1, right = 2 },
				},
				fileinfo_ignore_norms,
				'filetype',
			},
			lualine_y = {
				{ 'filesize' },
				{ 'progress' },
			},
			lualine_z = { 'location' },
		},
		inactive_sections = {
			lualine_a = {
				{ 'filename', path = 1 }
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { 'nvim-tree' },
		winbar = {
			lualine_a = {
				{
					'buffers',
					show_filename_only = true, -- Shows shortened relative path when set to false.
					hide_filename_extension = false, -- Hide filename extension when set to true.
					show_modified_status = true, -- Shows indicator when the buffer is modified.

					mode = 0,

					max_length = function() return vim.api.nvim_win_get_width(0) end, -- Maximum width of buffers component,
					-- it can also be a function that returns
					-- the value of `max_length` dynamically.
					filetype_names = {
						TelescopePrompt = 'Telescope',
						packer = 'Packer',
					},

					padding = 1,

					symbols = {
						modified = ' ●', -- Text to show when the buffer is modified
						alternate_file = '', -- Text to show to identify the alternate file
						directory = '', -- Text to show when the buffer is a directory
					},
				},
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		inactive_tabline = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	}
}

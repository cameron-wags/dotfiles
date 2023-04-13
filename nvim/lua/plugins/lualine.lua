return {
	'nvim-lualine/lualine.nvim',
	enabled = false,
	lazy = false,
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		options = {
			component_separators = { left = '', right = '' },
			section_separators = { left = '', right = '' },
			disabled_filetypes = { 'NvimTree', 'FTerm', 'help', 'startify', 'oil' },
			globalstatus = false,
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = {
				{ 'branch' },
			},
			lualine_c = {
				{ 'filename', path = 1 },
			},
			lualine_x = {
				{
					'diagnostics',
					sources = { 'nvim_diagnostic' },
					symbols = {
						error = '✗',
						warn = '!',
						info = '',
						hint = '',
					},
				},
				{
					'encoding',
					fmt = function(enc)
						if enc ~= 'utf-8' then
							return enc
						end
						return ''
					end
				},
				{
					'fileformat',
					symbols = {
						unix = '',
						dos = ' ',
						mac = ' ',
					}
				},
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
			lualine_x = { 'location' },
		},
		tabline = {
			lualine_a = {
				{
					'buffers',

					max_length = vim.o.columns,

					filetype_names = {
						TelescopePrompt = 'Telescope',
						packer = 'Packer',
						NvimTree = 'NvimTree',
					},

					padding = 1,

					symbols = {
						modified = ' ●', -- Text to show when the buffer is modified
						alternate_file = '', -- Text to show to identify the alternate file
						directory = '', -- Text to show when the buffer is a directory
					},
				},
			},
		},
	}
}

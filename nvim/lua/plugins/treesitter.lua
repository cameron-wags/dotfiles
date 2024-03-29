return {
	{
		'nvim-treesitter/nvim-treesitter',
		event = 'VeryLazy',
		build = ':TSUpdate',
		-- dependencies = { 'nvim-treesitter/nvim-treesitter-refactor' },
		config = function()
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = {
					'bash',
					'c',
					'css',
					'diff',
					'dockerfile',
					'go',
					'html',
					'java',
					'javascript',
					'jsdoc',
					'json',
					'jsonc',
					'lua',
					'markdown',
					'python',
					'regex',
					'rust',
					'tsx',
					'typescript',
					'vim',
					'vue',
					'yaml',
				},
				ignore_install = {
					'csv',
					'tsv',
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true, -- false will disable the whole extension
					-- list of language that will be disabled
					disable = function(_, bufnr)
						local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
						local first_length = 0
						if #first_line > 0 then
							first_length = string.len(first_line[1])
						end

						if first_length > 1000 then
							vim.schedule(function()
								vim.notify('treesitter disabled:\n\treload or :TSBufEnable {module} after formatting the buffer',
									vim.log.levels.WARN)
							end)
							return true
						end
						return false
					end,
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				-- refactor = {
				-- 	highlight_definitions = { enable = false },
				-- },
			}
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		event = 'VeryLazy',
		config = true,
	}
}

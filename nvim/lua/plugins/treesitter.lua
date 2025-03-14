return {
	{
		'nvim-treesitter/nvim-treesitter',
		event = 'VeryLazy',
		build = ':TSUpdate',
		-- dependencies = { 'nvim-treesitter/nvim-treesitter-refactor' },
		config = function()
			vim.g.skip_ts_context_commentstring_module = true
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = {
					'bash',
					'c',
					'css',
					'diff',
					'dockerfile',
					'go',
					'html',
					'http',
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
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					disable = {
						'yaml',
					}
				},
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
	},
}

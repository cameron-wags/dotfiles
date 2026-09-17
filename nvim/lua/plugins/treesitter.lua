return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			require 'nvim-treesitter'.setup {
				install_dir = vim.fn.stdpath('data') .. '/site'
			}
			require 'nvim-treesitter'.install {
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
				'zsh'
			}
			vim.api.nvim_create_autocmd('FileType', {
				pattern = require 'nvim-treesitter'.get_installed(),
				callback = function() vim.treesitter.start() end,
			})
		end,
	},
}

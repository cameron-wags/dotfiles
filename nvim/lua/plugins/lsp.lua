-- ok so it's not just lsp, but it is shit i like to group since load order can
-- get fiddly
return {
	{
		'VonHeikemen/lsp-zero.nvim',
		event = {
			'BufRead',
			'BufNewFile',
		},
		priority = 50,
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			{ 'L3MON4D3/LuaSnip' },
		},
		config = function()
			local lsp = require 'lsp-zero'

			lsp.set_preferences {
				suggest_lsp_servers = false,
				setup_servers_on_start = true,
				set_lsp_keymaps = true,
				configure_diagnostics = true,
				cmp_capabilities = true,
				manage_nvim_cmp = true,
				call_servers = 'local',
				sign_icons = {
					error = 'E',
					warn = 'W',
					hint = 'H',
					info = 'I'
				}
			}

			lsp.nvim_workspace()

			lsp.setup_nvim_cmp {
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lua' },
					{ name = 'path' },
					{ name = 'luasnip' },
					{ name = 'buffer',  keyword_length = 4 },
				}
			}

			lsp.setup()

			lsp.ensure_installed {
				'beautysh',
				'eslint_d',
				'fixjson',
				'prettierd',
				'shfmt',
				'lua-language-server',
				'typescript-language-server',
			}

			vim.diagnostic.config {
				virtual_text = true,
				update_in_insert = true,
			}
		end,
	},
	{
		'jose-elias-alvarez/null-ls.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		event = {
			'BufRead',
			'BufNewFile',
		},
		priority = 49,
		config = function()
			local null_ls = require 'null-ls'
			null_ls.setup {
				sources = {
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.eslint_d,
					null_ls.builtins.formatting.fixjson,
					null_ls.builtins.formatting.beautysh,
					null_ls.builtins.formatting.sql_formatter,
				},
				default_timeout = 15000,
				should_attach = function(bufnr)
					local ft_overrides = {
						NvimTree = false,
						FTerm = false,
					}
					local this_ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
					if ft_overrides[this_ft] then
						return ft_overrides[this_ft]
					end
					return true
				end,
			}
		end,
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		priority = 49,
		dependencies = { 'hrsh7th/nvim-cmp' },
		config = function()
			require 'nvim-autopairs'.setup {
				check_ts = true,
				ts_config = {
					lua = { 'string', 'source' },
					javascript = { 'string', 'template_string' },
					java = false,
				},
				disable_filetype = { 'TelescopePrompt' },
				disable_in_macro = true,
				disable_in_visualblock = true,
				disable_in_replace_mode = true,
				enable_check_bracket_line = true,
			}
			local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
			local cmp = require 'cmp'
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},
	-- {
	-- 	url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim.git',
	-- 	event = 'VeryLazy',
	-- 	priority = 49,
	-- 	config = function() require 'lsp_lines'.setup() end,
	-- },
}

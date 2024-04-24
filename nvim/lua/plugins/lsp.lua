-- ok so it's not just lsp, but it is shit i like to group since load order can
-- get fiddly
return {
	{
		'VonHeikemen/lsp-zero.nvim',
		event = 'InsertEnter',
		priority = 50,
		branch = 'v2.x',
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{
				'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
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

			lsp.preset {
				call_servers = 'local',
				configure_diagnostics = true,
				manage_nvim_cmp = true,
				set_lsp_keymaps = true,
				setup_servers_on_start = true,
			}

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps { buffer = bufnr, omit = { 'gr', 'gd' } }
			end)

			lsp.set_sign_icons {
				error = 'E',
				warn = 'W',
				hint = 'H',
				info = 'I',
			}

			require 'lspconfig'.lua_ls.setup(lsp.nvim_lua_ls())

			-- condensed form of this:
			-- https://github.com/younger-1/nvim/blob/one/lua/young/lsp/providers/pyright.lua
			local root_dir_cache = {}
			local pipenv_venv_cached = function(root_dir)
				if root_dir_cache[root_dir] then
					return root_dir_cache[root_dir]
				end
				local value = vim.fn.trim(vim.system({ 'pipenv', '--venv', '--quiet' }, { text = true }):wait().stdout)
				root_dir_cache[root_dir] = value
				return value
			end
			require 'lspconfig'.pyright.setup {
				settings = {
					python = {
						analysis = {
							useLibraryCodeForTypes = true,
							autoImportCompletions = true,
							autoSearchPaths = true,
						},
					},
				},
				on_new_config = vim.schedule_wrap(function(new_config, new_root_dir)
					local _virtual_env
					(function(root_dir)
						local pipenv_dir

						local pipenv_match = vim.fn.glob(require 'lspconfig.util'.path.join(root_dir, 'Pipfile.lock'))
						if pipenv_match ~= '' then
							pipenv_dir = pipenv_venv_cached(root_dir)
						end

						if not vim.env.VIRTUAL_ENV or vim.env.VIRTUAL_ENV == '' then
							_virtual_env = pipenv_dir
						end

						if _virtual_env ~= '' then
							vim.env.VIRTUAL_ENV = _virtual_env
							vim.env.PATH = require 'lspconfig.util'.path.join(_virtual_env, 'bin:') .. vim.env.PATH
						end

						if _virtual_env ~= '' and vim.env.PYTHONHOME then
							vim.env.old_PYTHONHOME = vim.env.PYTHONHOME
							vim.env.PYTHONHOME = ''
						end

						return _virtual_env ~= '' and require 'lspconfig.util'.path.join(_virtual_env, 'bin:') .. vim.env.PATH or ''
					end)(new_root_dir)

					new_config.settings.python.pythonPath = vim.fn.exepath 'python'
				end),
			}


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

			require 'cmp'.setup {
				mapping = {
					['<CR>'] = require 'cmp'.mapping.confirm { select = true },
				},
			}

			lsp.ensure_installed {
				'prettierd',
				'jsonls',
				'pyright',
				'shfmt',
				'lua-language-server',
				'typescript-language-server',
				'pyright',
				'ruff',
			}

			vim.diagnostic.config {
				virtual_text = true,
				virtual_lines = false,
				update_in_insert = true,
			}
		end,
	},
	{
		'nvimtools/none-ls.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		event = 'VeryLazy',
		priority = 49,
		config = function()
			local null_ls = require 'null-ls'
			null_ls.setup {
				-- https://github.com/nvimtools/none-ls.nvim
				sources = {
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.sql_formatter,
				},
				debounce = 250,
				update_in_insert = false,
				default_timeout = 15000,
				diagnostics_format = '#{m}',
				fallback_severity = vim.diagnostic.severity.ERROR,
				notify_format = '[null-ls] %s',
				should_attach = function(bufnr)
					local ft_overrides = {
						NvimTree = false,
						FTerm = false,
					}
					local this_ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
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
	{
		url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim.git',
		lazy = true,
		priority = 49,
		config = function() require 'lsp_lines'.setup() end,
	},
}

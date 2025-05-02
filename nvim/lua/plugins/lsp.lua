local ensure_installed = {
	'prettierd',
	'jsonls',
	'basedpyright',
	'shfmt',
	'lua-language-server',
	'typescript-language-server',
	'pyright',
	'ruff',
	'vue-language-server',
}

-- used by pyright
local root_dir_cache = {}
local pipenv_venv_cached = function(root_dir)
	if root_dir_cache[root_dir] then
		return root_dir_cache[root_dir]
	end
	-- look for local .venv (way faster, requires setup in venv tooling)
	local value = vim.fn.expand(root_dir .. '/.venv')
	if vim.fn.isdirectory(value) == 0 then
		vim.notify('Unable to find project .venv', vim.log.levels.WARN)
		return ''
	end
	root_dir_cache[root_dir] = value
	return value
end

local custom_lspconfig = {
	lua_ls = function(mix_capabilities)
		require 'lspconfig'.lua_ls.setup(mix_capabilities {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
						return
					end
				end
				client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						version = 'LuaJIT'
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME
						}
					}
				})
			end,
			settings = {
				Lua = {}
			}
		})
	end,

	basedpyright = function(mix_capabilities)
		require 'lspconfig'.basedpyright.setup(mix_capabilities {
			settings = {
				python = {},
				basedpyright = {
					analysis = {
						useLibraryCodeForTypes = true,
						autoImportCompletions = true,
						autoSearchPaths = true,
					}
				}
			},
			on_new_config = function(new_config, new_root_dir)
				(function(root_dir)
					local venv_dir = pipenv_venv_cached(root_dir)
					if venv_dir == '' then
						-- don't bother if we didn't find a venv
						return ''
					end

					vim.env.VIRTUAL_ENV = venv_dir
					vim.env.PATH = vim.fs.joinpath(venv_dir, 'bin') .. ':' .. vim.env.PATH

					if vim.env.PYTHONHOME then
						vim.env.old_PYTHONHOME = vim.env.PYTHONHOME
						vim.env.PYTHONHOME = ''
					end
				end)(new_root_dir)

				new_config.settings.python.pythonPath = vim.fn.exepath 'python'
			end
		})
	end,

	ts_ls = function(mix_capabilities)
		local vue_language_server_path = require 'mason-registry'.get_package('vue-language-server'):get_install_path() ..
				'/node_modules/@vue/language-server'

		require 'lspconfig'.ts_ls.setup(mix_capabilities {
			init_options = {
				plugins = {
					{
						name = '@vue/typescript-plugin',
						location = vue_language_server_path,
						languages = { 'vue' }
					}
				}
			},
			filetypes = {
				'typescript',
				'javascript',
				'javascriptreact',
				'typescriptreact',
				'vue',
			},
		})
	end,
}

return {
	{
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		cmd = { 'MasonToolsInstall', 'MasonToolsUpdate' },
		dependencies = {
			'williamboman/mason.nvim',
		},
		opts = {
			ensure_installed = ensure_installed,
			auto_update = false,
			run_on_start = false,
		},
	},

	{
		'williamboman/mason.nvim',
		cmd = {
			'Mason',
			'MasonInstall',
			'MasonLog',
			'MasonUninstall',
			'MasonUninstallAll',
			'MasonUpdate',
		},
		event = { 'BufReadPre', 'BufNewFile' },
		priority = 50,
		build = function()
			pcall(vim.cmd, 'MasonUpdate')
		end,
		dependencies = {
			'williamboman/mason-lspconfig.nvim',
			'neovim/nvim-lspconfig',

			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			{ 'L3MON4D3/LuaSnip' },
		},
		config = function()
			require 'mason'.setup()
			local mason_lspconfig = require 'mason-lspconfig'
			mason_lspconfig.setup()

			local lspconfig = require 'lspconfig'

			local default_capabilities_opts = {
				capabilities = require 'cmp_nvim_lsp'.default_capabilities()
			}
			local mix_capabilities = function(opts)
				return vim.tbl_deep_extend('keep', opts, default_capabilities_opts)
			end
			local servers = mason_lspconfig.get_installed_servers()
			for _, server_name in ipairs(servers) do
				if custom_lspconfig[server_name] ~= nil then
					custom_lspconfig[server_name](mix_capabilities)
				else
					lspconfig[server_name].setup(mix_capabilities {})
				end
			end

			local cmp = require 'cmp'
			cmp.setup {
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lua' },
					{ name = 'path' },
					{ name = 'luasnip' },
					{ name = 'buffer',  keyword_length = 4 },
				},
				mapping = cmp.mapping.preset.insert {
					['<CR>'] = cmp.mapping.confirm { select = true },
					['<Tab>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
				},
				snippet = {
					expand = function(args)
						require 'luasnip'.lsp_expand(args.body)
					end
				}
			}

			vim.diagnostic.config {
				virtual_text = true,
				virtual_lines = false,
				update_in_insert = true,
				severity_sort = true,
				-- float = {
				-- 	source = true, --show diagnostic's source in float view
				-- }
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
						markdown = false,
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
}

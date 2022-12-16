local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
	return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
	return
end

mason.setup {
	ui = {
		border = 'rounded',
		icons = {
			package_installed = '✓',
			package_pending = '➜',
			package_uninstalled = '✗'
		}
	},
	providers = {
		'mason.providers.client',
	}
}

mason_lspconfig.setup {
	automatic_installation = false,
}

local ensure_installed = {
	'eslint_d',
	'fixjson',
	'prettierd',
	'shfmt',
	'lua-language-server',
	'typescript-language-server',
}

local ok, mason_registry = pcall(require, 'mason-registry')
if not ok then
	return
end

local not_installed = {}
for _, package in ipairs(ensure_installed) do
	if not mason_registry.is_installed(package) then
		table.insert(not_installed, package)
	end
end

if #not_installed > 0 then
	vim.api.nvim_cmd({ cmd = 'MasonInstall', args = not_installed }, {})
end

local settings_for_server = function(name)
	if name == 'sumneko_lua' then
		return {
			Lua = {
				diagnostics = {
					globals = { 'vim' },
				},
				workspace = {
					library = {
						[vim.fn.expand('$VIMRUNTIME/lua')] = true,
						[vim.fn.stdpath('config') .. '/lua'] = true,
					},
				},
			},
		}
	end
end

local keybinds_ok, keybinds = pcall(require, 'user.keybinds')
if not keybinds_ok then
	return
end

local attach = function(client, bufnr)
	local buf_opts = { noremap = true, silent = true, buffer = bufnr }
	for _, map in pairs(keybinds.lsp) do
		vim.keymap.set(map.mode, map.bind, map.action, buf_opts)
	end

	-- vim.api.nvim_create_autocmd('CursorHold', {
	--   buffer = bufnr,
	--   callback = function()
	--     local opts = {
	--       focusable = false,
	--       close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
	--       border = 'rounded',
	--       source = 'always',
	--       prefix = ' ',
	--       scope = 'cursor',
	--     }
	--     vim.diagnostic.open_float(nil, opts)
	--   end
	-- })
end

-- Add additional capabilities supported by nvim-cmp
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_ok then
	return
end
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
local capabilities = cmp_nvim_lsp.default_capabilities()

mason_lspconfig.setup_handlers {
	function(server_name)
		require 'lspconfig'[server_name].setup {
			on_attach = attach,
			settings = settings_for_server(server_name),
			capabilities = capabilities,
		}
	end
}

local nok, null_ls = pcall(require, 'user.null-ls')
if not nok then
	return
end
null_ls.setup(attach)

vim.diagnostic.config {
	-- virtual_text = {
	--   prefix = '',
	--   spacing = 2,
	-- },
	virtual_text = false,
	virtual_lines = true,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = 'minimal',
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
	},
}

vim.api.nvim_create_autocmd('InsertEnter', {
	callback = function()
		vim.diagnostic.config {
			virtual_lines = false,
			virtual_text = true,
		}
	end
})

vim.api.nvim_create_autocmd('InsertLeave', {
	callback = function()
		vim.diagnostic.config {
			virtual_lines = true,
			virtual_text = false,
		}
	end
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = 'rounded',
})

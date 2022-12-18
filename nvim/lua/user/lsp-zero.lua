require 'mason.settings'.set {
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

local lsp = require('lsp-zero')

lsp.set_preferences({
	suggest_lsp_servers = true,
	setup_servers_on_start = true,
	set_lsp_keymaps = true,
	configure_diagnostics = true,
	cmp_capabilities = true,
	manage_nvim_cmp = true,
	call_servers = 'local',
	sign_icons = {
		error = '✘',
		warn = '▲',
		hint = '⚑',
		info = ''
	}
})

lsp.nvim_workspace()

lsp.setup_nvim_cmp {
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'path' },
		{ name = 'luasnip' },
		{ name = 'buffer', keyword_length = 4 },
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

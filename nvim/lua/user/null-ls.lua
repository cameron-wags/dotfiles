local ok, null_ls = pcall(require, 'null-ls')
if not ok then
	return
end

-- null ls builtins:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
local M = {}
M.setup = function(attach)
	null_ls.setup {
		on_attach = attach,
		sources = {
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.eslint_d,
			null_ls.builtins.formatting.fixjson,
			null_ls.builtins.formatting.beautysh,
			null_ls.builtins.formatting.sql_formatter,
		},
		debounce = 250,
		debug = true,
		default_timeout = 15000,
		diagnostics_format = "#{m}",
		fallback_severity = vim.diagnostic.severity.ERROR,
		log_level = "info",
		notify_format = "[null-ls] %s",
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
		-- cmd = { "nvim" },
		-- on_init = nil,
		-- on_exit = nil,
		update_in_insert = false,
	}
end

return M

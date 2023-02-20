local ok, null_ls = pcall(require, 'null-ls')
if not ok then
	return
end

-- null ls builtins:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
null_ls.setup {
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.fixjson,
		null_ls.builtins.formatting.beautysh,
		null_ls.builtins.formatting.sql_formatter,
	},
	debug = false,
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

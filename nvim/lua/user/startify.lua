vim.g.startify_lists = {
	{
		type = 'sessions',
		header = { 'Sessions' }
	}
}
vim.g.startify_session_persistence = 1
vim.g.startify_enable_special = 0
vim.g.startify_padding_left = 10

vim.api.nvim_create_user_command('Sesh', function()
	local name = string.gsub(vim.fn.getcwd(-1, -1), vim.env.HOME .. '/g/', '')
	local name_clean = string.gsub(name, '/', '_')
	vim.api.nvim_exec(':SSave ' .. name_clean, false)
end, {})

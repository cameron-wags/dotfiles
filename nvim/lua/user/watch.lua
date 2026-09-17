local config = {
	default_shell_command = 'echo go > /tmp/autorun',

	excluded_filetypes = {
		fugitive = true,
		gitcommit = true,
		oil = true,
	}
}

local state = {
	autocmd = nil,

	command = nil,
}

local set_watch = function(opts)
	if opts.args == '' then
		state.command = config.default_shell_command
	else
		state.command = opts.args
	end

	if opts.name == 'Watch' then
		state.command = '! ' .. state.command
	end

	if opts.bang then
		state.command = 'silent ' .. state.command
	end

	local group = vim.api.nvim_create_autocmd('Watch', { clear = true })
	state.autocmd = vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		callback = function(args)
			local buf_ft = vim.api.nvim_get_option_value('filetype', { buffer = args.buf })
			if config.excluded_filetypes[buf_ft] then
				return
			end
			vim.api.nvim_command(state.command)
		end,
	})
end

local review_watch = function()
	if not state.autocmd then
		return
	end
	vim.notify(state.command, vim.log.levels.INFO, {})
end

local unset_watch = function()
	if not state.autocmd then
		vim.notify('No Watch to unset', vim.log.levels.INFO, {})
		return
	end
	vim.api.nvim_del_autocmd(state.autocmd)
end

-- :Watch[!] [{cmd}]
--
-- Runs a shell command on BufWritePost. Add [!] to run the command silently.
-- If {cmd} is not provided, the configured default_shell_command is used.
vim.api.nvim_create_user_command('Watch', set_watch, { nargs = '*', complete = 'shellcmd', bang = true })
vim.api.nvim_create_user_command('WatchPeek', review_watch, {})
vim.api.nvim_create_user_command('WatchStop', unset_watch, {})

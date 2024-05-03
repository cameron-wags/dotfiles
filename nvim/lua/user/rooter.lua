-- This file is a reduced version of: https://github.com/AkashKarnatak/rooter.nvim
local rooter_patterns = { '.git', 'Makefile', 'node_modules' }

-- https://stackoverflow.com/a/4991602
local function file_exists(name)
	-- todo move this to uv.fs_stat()
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- https://stackoverflow.com/a/20460403
local function findLast(haystack, needle)
	local i = haystack:match(".*" .. needle .. "()")
	if i == nil then return nil else return i - 1 end
end

local function parent_dir(dir)
	return dir:sub(1, findLast(dir, '/') - 1)
end

local term_pattern = parent_dir(os.getenv('HOME'))

local function get_root_dir(prefix, cwd)
	if not (prefix:find(term_pattern) == 1) then
		return cwd
	end
	local possible_root_dir = prefix
	local found = false
	while prefix ~= term_pattern do
		for _, dir in ipairs(rooter_patterns) do
			if file_exists(prefix .. '/' .. dir) then
				found = true
				possible_root_dir = prefix
				break
			end
		end
		prefix = parent_dir(prefix)
	end
	if found then
		return possible_root_dir
	else
		return cwd
	end
end

vim.api.nvim_create_autocmd('BufEnter', {
	group = vim.api.nvim_create_augroup('Rooter', { clear = true, }),
	pattern = '*',
	callback = function()
		local rootdir = get_root_dir(vim.fn.expand('%:p:h'), vim.fn.getcwd())
		vim.cmd.cd(rootdir)
	end
})

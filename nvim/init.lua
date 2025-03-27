require 'user.settings'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup {
	spec = { { import = 'plugins' } },
	performance = {
		rtp = {
			disabled_plugins = {
				'tohtml',
				'tutor',
			}
		}
	},
	change_detection = {
		notify = false,
	},
	dev = {
		path = '~/g'
	},
}

require 'user.keybinds'
require 'user.watch'

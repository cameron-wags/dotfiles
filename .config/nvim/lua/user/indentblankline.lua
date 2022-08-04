local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

vim.g.indent_blankline_filetype_exclude = {'packer', 'toggleterm', 'help'}
vim.opt.listchars:append("space:⋅")

indent_blankline.setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})

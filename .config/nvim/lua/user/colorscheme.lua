vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
	transparent_background = false,
	term_colors = true,
    compile = {
        enabled = true,
        path = vim.fn.stdpath "cache" .. "/catppuccin",
        suffix = "_compiled",
    },
	styles = {
		comments = { "italic" },
		functions = { "italic" },
		keywords = {"italic" },
		strings = {},
		variables = {},
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
        },
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = true,
            show_root = true,
        },
        dashboard = true,
        bufferline = true,
        cmp = true,
	},
})

local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

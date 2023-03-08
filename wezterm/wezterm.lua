local wezterm = require 'wezterm'

return {
	-- color_scheme = 'Catppuccin Mocha',
	color_scheme = (function(appearance)
				if appearance:find 'Dark' then
					return 'Catppuccin Mocha'
				else
					return 'Catppuccin Latte'
				end
			end)(wezterm.gui.get_appearance()),
	force_reverse_window_cursor = false,
	cursor_blink_rate = 325,
	cursor_blink_ease_in = 'Constant',
	cursor_blink_ease_out = 'Constant',
	harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
	font_size = 11.0,
	window_frame = {
		font_size = 11.5,
	},
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	tab_max_width = 45,
	window_decorations = 'RESIZE',
	enable_scroll_bar = false,
	window_padding = {
		top = 0,
		right = 0,
		bottom = 0,
		left = 0,
	},
	keys = {
		{
			key = 'k',
			mods = 'CMD',
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = 'j',
			mods = 'CMD',
			action = wezterm.action.ActivateTabRelative(1),
		},
	}
}

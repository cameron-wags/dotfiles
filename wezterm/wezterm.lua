local wezterm = require 'wezterm'

local get_color_scheme = function(appearance)
	if appearance:find 'Dark' then
		return 'Catppuccin Mocha'
	else
		return 'Catppuccin Latte'
	end
end

return {
	allow_square_glyphs_to_overflow_width = 'Never',
	animation_fps = 1,
	color_scheme = get_color_scheme(wezterm.gui.get_appearance()),
	cursor_blink_ease_in = 'Constant',
	cursor_blink_ease_out = 'Constant',
	cursor_blink_rate = 325,
	enable_scroll_bar = false,
	font = wezterm.font_with_fallback {
		'JetBrains Mono',
		{ family = 'Noto Color Emoji',       scale = 1.0 },
		{ family = 'Symbols Nerd Font Mono', scale = 0.65 },
	},
	font_size = 11.0,
	force_reverse_video_cursor = false,
	harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
	hide_tab_bar_if_only_one_tab = true,
	initial_cols = 130,
	initial_rows = 70,
	show_new_tab_button_in_tab_bar = false,
	tab_max_width = 45,
	use_fancy_tab_bar = false,
	use_ime = false,
	window_decorations = 'RESIZE',
	window_frame = { font_size = 11.5, },
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
		{
			key = 't',
			mods = 'CMD|SHIFT',
			action = wezterm.action.SpawnTab('CurrentPaneDomain'),
		},
		{
			key = 't',
			mods = 'CMD',
			action = wezterm.action.SpawnCommandInNewTab {
				cwd = wezterm.home_dir,
			},
		},
	}
}

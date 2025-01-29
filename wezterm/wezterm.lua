-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = {} -- wezterm.config_builder()

-- Set font size
config.font_size = 13

-- changing the color scheme, background opacity, nvim opacity
config.color_scheme = "tokyonight_night"
config.window_background_opacity = 0.75
config.macos_window_background_blur = 25
config.text_background_opacity = 0.5

-- Tab bar and window appearance
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.inactive_pane_hsb = { brightness = 0.65 }
config.native_macos_fullscreen_mode = true

-- testing
config.show_tabs_in_tab_bar = true

-- custom keybinds
config.leader = { key = "a", mods = "CTRL" }
config.keys = {
	-- This will create a new split and run your default program inside it
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

-- nerd font
config.font = wezterm.font("JetBrains Mono") -- { weight = 'Bold', italic = true }
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font("JetBrains Mono", { weight = "ExtraBold", stretch = "Normal", style = "Normal" }),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font("JetBrains Mono", { weight = "Bold", stretch = "Normal", style = "Italic" }),
	},
}

-- window padding
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

-- center and fill window on startup
wezterm.on("gui-startup", function(_)
	local screen = wezterm.gui.screens().active
	local ratio = 1
	local width, height = screen.width * ratio, screen.height * ratio
	local _, _, window = wezterm.mux.spawn_window({
		position = {
			x = (screen.width - width) / 2,
			y = (screen.height - height) / 2,
			origin = "ActiveScreen",
		},
	})
	window:gui_window():set_inner_size(width, (height - 50))
end)

-- and finally, return the configuration to wezterm
return config

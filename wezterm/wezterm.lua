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
config.text_background_opacity = 0.6

-- wallpaper
-- config.window_background_image = "/Users/chitraksen/Developer/nvim_wall_op.jpg"

-- wezterm horizontal split
config.keys = {
	-- This will create a new split and run your default program inside it
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

-- pane resizing
config.leader = { key = "a", mods = "CTRL" }
config.keys = {
	{
		key = "H",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{ key = "K", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{
		key = "L",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
}

config.native_macos_fullscreen_mode = true

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

-- tab bar
config.tab_bar_at_bottom = false

-- window padding
config.window_padding = {
	left = 30,
	right = 30,
	top = 30,
	bottom = 30,
}

-- center window on startup
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
	window:gui_window():set_inner_size(width, height)
end)

-- and finally, return the configuration to wezterm
return config

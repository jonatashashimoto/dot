-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime'

config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.window_decorations = "NONE"
config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
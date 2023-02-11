local wezterm = require 'wezterm'

local config = {}

config.default_prog = { "E:/cygwin64/bin/bash.exe", "--login" }

config.window_close_confirmation = 'NeverPrompt'

config.initial_cols = 215
config.initial_rows = 58

--config.front_end = "WebGpu" -- makes fonts too thick
config.front_end = "OpenGL"
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font 'Consolas', { weight = 'Normal', style = 'Normal' }
--config.font = wezterm.font 'JetBrains Mono', { weight = 'Normal', style = 'Normal' }
config.font_size = 11
config.freetype_render_target = "HorizontalLcd"
config.freetype_load_target = "Light"

config.foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.0,
}

config.hyperlink_rules = {
    -- Include closing ) in links
    {
      regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\)\\b*',
      format = '$0',
    },
	
    -- Linkify things that look like URLs and the host has a TLD name.
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
      format = '$0',
    },


    -- linkify email addresses
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      format = 'mailto:$0',
    },

    -- file:// URI
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = [[\bfile://\S*\b]],
      format = '$0',
    },

    -- Linkify things that look like URLs with numeric addresses as hosts.
    -- E.g. http://127.0.0.1:8000 for a local development server,
    -- or http://192.168.1.1 for the web interface of many routers.
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = '$0',
    },
}

return config
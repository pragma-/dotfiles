local wezterm = require 'wezterm'

local colors = wezterm.color.get_builtin_schemes()['CGA']

colors.foreground = "#b0b0b0"
colors.background = "#0f0f10"

return {
    default_prog = { "E:/cygwin64/bin/bash.exe", "--login" },

    window_close_confirmation = 'NeverPrompt',
    check_for_updates = false,
    hide_tab_bar_if_only_one_tab = true,
    audible_bell = 'Disabled',

    initial_cols = 215,
    initial_rows = 58,

    color_schemes = { ['custom'] = colors },
    color_scheme = 'custom',

    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    -- front_end = 'WebGpu' -- makes fonts too thick
    front_end = 'OpenGL',
    animation_fps = 1,
    cursor_blink_ease_in = 'Constant',
    cursor_blink_ease_out = 'Constant',

    font = wezterm.font_with_fallback({ 'Consolas', 'Noto Sans Math' }),
    -- font = wezterm.font 'JetBrains Mono', { weight = 'Normal', style = 'Normal' },
    font_size = 11,
    freetype_render_target = 'HorizontalLcd',
    freetype_load_target = 'Light',

    foreground_text_hsb = {
        hue = 1.0,
        saturation = 1.0,
        brightness = 1.0,
    },

    inactive_pane_hsb = {
        saturation = 1.0,
        brightness = 0.85,
    },

    mouse_bindings = {
        -- Right click paste
        {
            event = { Down = { streak = 1, button = 'Right' } },
            mods = 'NONE',
            action = wezterm.action.PasteFrom("PrimarySelection"),
        },
    },

    keys = {
        -- Turn off the default ALT-Enter action
        {
            key = 'Enter',
            mods = 'ALT',
            action = wezterm.action.DisableDefaultAssignment,
        },
    },

    hyperlink_rules = {
        -- First handle URLs wrapped with punctuation (i.e. brackets)
        -- e.g. [http://foo] (http://foo) <http://foo> etc
        -- the punctuation will be underlined but excluded when clicked
        {
            regex = '[(\\[<](\\w+://\\S+)[)\\]>]',
            format = '$1',
            highlight = 1,
        },

        -- Then handle URLs not wrapped in brackets
        -- and include terminating ), / or - characters, if any
        -- these seem to be the most common trailing characters that are part of URLs
        -- there may be additional common ones . . .
        {
            regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
            format = '$0',
        },
    },
}

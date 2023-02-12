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

    font = wezterm.font_with_fallback({ 'Consolas' }),
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
        -- Include closing ) in links. E.g. https://foo/bar_(baz)
        --
        -- This properly handles URLs within ()'s too, e.g.:
        -- blah blah (https://en.wikipedia.org/wiki/Set_(mathematics)) blah blah
        -- properly linkifies only `https://en.wikipedia.org/wiki/Set_(mathematics)`
        -- but (http://foo/bar) will linkify to `http://foo/bar)`. Fortunately, URLs
        -- are very rarely wrapped with ()!
        {
            regex = '\\b\\w+://[^) ]+\\)\\b*',
            format = '$0',
        },

        -- Linkify things that look like URLs.
        {
            regex = '\\b\\w+://\\S+\\b',
            format = '$0',
        },
    },
}

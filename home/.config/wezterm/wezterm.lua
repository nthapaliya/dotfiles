-- vim: tabstop=2 shiftwidth=2 expandtab

-- looking good so far,
-- i might be missing some keymaps
-- -- leader + !, tmux to move pane to own tab
-- -- rearrange panes
-- -- resize panes (DONE)
-- -- reset panes back to normal (or equidistant or whatever)
-- --

-- also, check about persistent mode (tmux style, where the daemon hangs around in the
-- background even when the window is closed)

local wez = require("wezterm")
local helpers = require("helpers")

local config = wez.config_builder()

local font = { family = "JetBrains Mono" }

config.color_scheme = "Catppuccin Mocha"
config.font = wez.font(font)
config.font_size = 14.0
config.tab_max_width = 32
config.scrollback_lines = 10000

config.native_macos_fullscreen_mode = true
config.window_close_confirmation = "AlwaysPrompt"
config.window_decorations = "RESIZE"

config.set_environment_variables = {
	PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

require("keys").apply_to_config(config)

-- tab_bar configuration
config.show_new_tab_button_in_tab_bar = false -- keep
config.tab_bar_at_bottom = true
-- config.show_close_tab_button_in_tabs = false -- not valid yet
config.use_fancy_tab_bar = false

local darker_grey = "#2e2e2e" -- tab bar background
local lighter_grey = "#575757" -- inactive tab bar color
local offwhite = "#dddddd" -- inactive tab bar text color
local blue = "#0087af" -- active tab bar color
local white = "#ffffff" -- active tab bar text color
local black = "#000000" -- left and right sidebar text (on offwhite background)

config.window_frame = {
	font = wez.font(font),
	font_size = 13.0,
	active_titlebar_bg = darker_grey,
	inactive_titlebar_bg = darker_grey,
}

config.colors = {
	tab_bar = {
		inactive_tab_edge = lighter_grey,
		background = darker_grey,
	},
}

wez.on("update-status", function(window, pane)
	window:set_left_status(helpers.segment({
		text = pane:get_domain_name(),
		bg_color = offwhite,
		fg_color = black,
		intensity = "Bold",
		bar_bg = darker_grey,
	}))

	local segments = {}
	local time = wez.time.now():format("%Y-%m-%d | %H:%M")
	local cwd = pane:get_current_working_dir()

	if cwd then
		local path = helpers.short_cwd(cwd.file_path)
		table.insert(segments, { text = path, bg_color = lighter_grey, fg_color = white, bar_bg = darker_grey })
	end

	table.insert(segments, { text = time, bg_color = lighter_grey, fg_color = offwhite, bar_bg = darker_grey })

	if cwd and cwd.host and #cwd.host > 0 then
		table.insert(segments, { text = cwd.host, bg_color = offwhite, fg_color = black, bar_bg = darker_grey })
	end

	window:set_right_status(helpers.segments(segments))
end)

wez.on("format-tab-title", function(tab, _, _, localconfig, hover)
	local segment = {
		text = helpers.tab_title(tab),
		bg_color = lighter_grey,
		fg_color = offwhite,
		intensity = "Half",
		bar_bg = darker_grey,
	}

	if localconfig.use_fancy_tab_bar then
		segment.lsep = ""
		segment.rsep = ""
	end

	if tab.is_active then
		segment.bg_color = blue
		segment.fg_color = white
		segment.intensity = "Bold"
	elseif hover then
		segment.intensity = "Bold"
	end

	return helpers.segment(segment)
end)

return config

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
local act = wez.action

local config = wez.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.font = wez.font({ family = "JetBrains Mono", weight = "Light" })
config.font_size = 14.0
config.tab_max_width = 32
config.scrollback_lines = 10000000

-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 20

config.native_macos_fullscreen_mode = true
config.window_close_confirmation = "AlwaysPrompt"
config.window_decorations = "RESIZE"

-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.window_padding = {
-- 	left = "0.5cell",
-- 	right = "0.5cell",
-- 	top = "1.5cell",
-- 	bottom = "0.5cell",
-- }

config.set_environment_variables = {
	PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

-- keys configuration
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = ",",
		mods = "SUPER",
		action = act.SpawnCommandInNewTab({
			cwd = wez.home_dir,
			args = { "nvim", wez.config_file },
		}),
	},
	{
		mods = "LEADER",
		key = '"',
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "%",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	{ key = "Enter", mods = "LEADER", action = act.ActivateCopyMode },
	-- { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	-- { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER|CTRL", action = act.ActivateTabRelative(1) },
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	{
		key = "f",
		mods = "CMD|SHIFT",
		action = act.ToggleFullScreen,
	},

	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

-- smart splits config
local smart_splits = wez.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config)

-- tab_bar configuration
config.show_new_tab_button_in_tab_bar = false -- keep
config.tab_bar_at_bottom = true
-- config.show_close_tab_button_in_tabs = false
config.use_fancy_tab_bar = false

local darker_grey = "#2e2e2e"
local lighter_grey = "#575757"

local offwhite = "#dddddd"
local blue = "#0087af"
local white = "#ffffff"
local black = "#000000"

config.window_frame = {
	font = wez.font({ family = "JetBrains Mono", weight = "Bold" }),
	font_size = 14.0,
	active_titlebar_bg = darker_grey,
	inactive_titlebar_bg = darker_grey,
}
config.colors = {
	tab_bar = {
		inactive_tab_edge = lighter_grey,
	},
}
config.colors = {
	tab_bar = {
		inactive_tab_edge = lighter_grey,
		background = darker_grey,
		active_tab = {
			bg_color = blue,
			fg_color = white,
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = lighter_grey,
			fg_color = offwhite,
			intensity = "Half",
		},
	},
}

-- local function basename(s)
-- 	return string.gsub(s, "(.*[/\\])(.*)", "%2")
-- end

wez.on("update-status", function(window, pane)
	local domain_name = pane:get_domain_name()
	local time = wez.time.now():format(" %Y-%m-%d | %H:%M ")

	local cwd = pane:get_current_working_dir()

	local cwd_path = cwd and (" " .. string.gsub(cwd.file_path, wez.home_dir, "~") .. " |") or ""
	local hostname = cwd and cwd.host or wez.hostname()

	window:set_left_status(wez.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Background = { Color = offwhite } },
		{ Foreground = { Color = black } },
		{ Text = " " .. domain_name .. " " },
	}))

	window:set_right_status(wez.format({
		-- { Attribute = { Intensity = "Normal" } },
		{ Background = { Color = lighter_grey } },
		{ Foreground = { Color = offwhite } },
		{ Text = cwd_path },
		{ Text = time },
		{ Background = { Color = offwhite } },
		{ Foreground = { Color = black } },
		{ Text = " " .. hostname .. " " },
	}))
end)

wez.on("format-tab-title", function(tab)
	local name = tab.active_pane.foreground_process_name
	local basename
	if #name == 0 then
		basename = string.gsub(tab.active_pane.title, "(%w)( .+)", "%1")
	else
		basename = string.gsub(name, "(.*[/\\])(.*)", "%2")
	end

	return " " .. (tab.tab_index + 1) .. " | " .. basename .. " "
end)

return config

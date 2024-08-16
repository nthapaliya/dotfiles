local wez = require("wezterm")
local act = wez.action

local module = {}

function module.apply_to_config(config)
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

	local smart_splits = wez.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
	smart_splits.apply_to_config(config)
end

return module

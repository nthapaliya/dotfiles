local wez = require("wezterm")

local module = {}

-- RSEP = wez.nerdfonts.ple_right_half_circle_thick
-- LSEP = wez.nerdfonts.ple_left_half_circle_thick

RSEP = wez.nerdfonts.ple_upper_left_triangle
LSEP = wez.nerdfonts.ple_lower_right_triangle

-- RSEP = wez.nerdfonts.ple_lower_left_triangle
-- LSEP = wez.nerdfonts.ple_upper_right_triangle
DOT = wez.nerdfonts.oct_dot_fill

UNICODE = true

local function insert_text(tbl, data)
	table.insert(tbl, { Attribute = { Intensity = data.intensity } })
	table.insert(tbl, { Background = { Color = data.bg_color } })
	table.insert(tbl, { Foreground = { Color = data.fg_color } })
	table.insert(tbl, { Text = " " .. data.text .. " " })
end

local function insert_lsep(tbl, data)
	if not UNICODE then
		return
	end

	table.insert(tbl, { Background = { Color = data.bar_bg } })
	table.insert(tbl, { Foreground = { Color = data.bg_color } })
	table.insert(tbl, { Text = LSEP })
end

local function insert_rsep(tbl, data)
	if not UNICODE then
		return
	end

	table.insert(tbl, { Background = { Color = data.bar_bg } })
	table.insert(tbl, { Foreground = { Color = data.bg_color } })
	table.insert(tbl, { Text = RSEP })
end

function module.basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

function module.short_cwd(str)
	str = string.gsub(str, wez.home_dir, "~")
	str = string.gsub(str, "([^/])[^/]+/", "%1/")

	return str
end

function module.tab_title(tab)
	local name = tab.active_pane.foreground_process_name
	local name_clean
	if #name == 0 then
		name_clean = string.gsub(tab.active_pane.title, "([^%s]+) .+", "%1")
	else
		name_clean = module.basename(name)
	end

	return tostring(tab.tab_index + 1) .. " | " .. name_clean
end

function module.segment(segment)
	local s = {}

	insert_lsep(s, segment)
	insert_text(s, segment)
	insert_rsep(s, segment)

	return wez.format(s)
end

function module.segments(segments)
	local s = {}

	for i, segment in ipairs(segments) do
		if i == 1 then
			insert_lsep(s, segment)
		end

		insert_text(s, segment)

		if i == #segments then
			insert_rsep(s, segment)
		end
	end

	return wez.format(s)
end

return module

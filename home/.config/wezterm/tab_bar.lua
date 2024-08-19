local wez = require("wezterm")

local module = {}

-- RSEP = wez.nerdfonts.ple_right_half_circle_thick
-- LSEP = wez.nerdfonts.ple_left_half_circle_thick

RSEP = wez.nerdfonts.ple_upper_left_triangle
LSEP = wez.nerdfonts.ple_lower_right_triangle

-- RSEP = wez.nerdfonts.ple_lower_left_triangle
-- LSEP = wez.nerdfonts.ple_upper_right_triangle
DOT = wez.nerdfonts.oct_dot_fill

local function insert_text(tbl, data)
	table.insert(tbl, { Attribute = { Intensity = data.intensity } })
	table.insert(tbl, { Background = { Color = data.bg_color } })
	table.insert(tbl, { Foreground = { Color = data.fg_color } })
	table.insert(tbl, { Text = " " .. data.text .. " " })
end

local function insert_lsep(tbl, data)
	table.insert(tbl, { Background = { Color = module.opts.background } })
	table.insert(tbl, { Foreground = { Color = data.bg_color } })
	table.insert(tbl, { Text = LSEP })
end

local function insert_rsep(tbl, data)
	table.insert(tbl, { Background = { Color = module.opts.background } })
	table.insert(tbl, { Foreground = { Color = data.bg_color } })
	table.insert(tbl, { Text = RSEP })
end

local function segment_pl(segment)
	local s = {}

	insert_lsep(s, segment)
	insert_text(s, segment)
	insert_rsep(s, segment)

	return wez.format(s)
end

local function segment_nopl(segment)
	local s = {}
	insert_text(s, segment)
	return wez.format(s)
end

local function segments_pl(segments)
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

local function segments_nopl(segments)
	local s = {}

	for _, segment in ipairs(segments) do
		insert_text(s, segment)
	end

	return wez.format(s)
end

module.opts = {}
function module.setup(opts)
	module.opts = opts
	local pl = opts.use_powerline
	if pl then
		module.segment = segment_pl
		module.segments = segments_pl
	else
		module.segment = segment_nopl
		module.segments = segments_nopl
	end
end

return module

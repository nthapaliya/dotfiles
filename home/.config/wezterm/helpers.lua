local wez = require("wezterm")

local module = {}

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

return module

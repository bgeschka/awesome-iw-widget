----
----
----  iw-info for Awesome Window Manager
----  shows connection details for mac80211 network cards
----
----  2018@Björn Geschka


local awful = require("awful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local PATH_TO_ICONS = "/usr/share/icons/oxygen/base/128x128/devices/";
local INTERFACE = "wlan0";

local iw_widget = wibox.widget {
	{
		id = "icon",
		widget = wibox.widget.imagebox,
		resize = true
	},
	layout = wibox.layout.fixed.horizontal
}

local function parseIw(iwoutput)
	local t = {
		signal = string.match(iwoutput, "signal avg:%s*(-%d+).*"),
		associated = string.match(iwoutput, "associated:%s*(%w+).*"),
		bar = 2
	};
	return t;
end

local function getActiveDev()
end

local notification
local function show_iw_status()
	awful.spawn.easy_async("bash -c 'iw "..INTERFACE.." link'",
	function(stdout, _, _, _)
		notification = naughty.notify{
			text =  stdout,
			timeout = 10, hover_timeout = 0.5,
			width = 400,
		}
	end
	)
end


watch("iw "..INTERFACE.." station dump", 10,
function(widget, stdout, stderr, exitreason, exitcode)
	local o = parseIw(stdout);

	local img = "network-wireless-";
	if o['associated'] == "yes" then
		img = img .. "connected-";

		local rs = o['signal']*-1;
		local s = "00";
		if rs < 25 then
			s="00";
		elseif rs < 50 then
			s="25";
		elseif rs < 75 then
			s="50";
		elseif rs < 100 then
			s="75";
		end
		img = img .. s;
	else
		img = img .. "disconnected-";
	end
	img = img .. ".png";

	widget.icon:set_image(PATH_TO_ICONS .. img);
end,
iw_widget)

iw_widget:connect_signal("mouse::enter", function() show_iw_status() end)
iw_widget:connect_signal("mouse::leave", function() naughty.destroy(notification) end)

return iw_widget

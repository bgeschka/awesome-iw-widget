# awesome-iw-widget (iw supported radios only,oxygen icons required)
![alt text](http://files.bgeschka.de/stuff/iw-widget.png)
i wrote this because i could not find any widget that just indicates wireless info,
others come with networkmanager or other software (wicd/nm & nm-applet...)

i use wpa_supplicant and dhcpcd

so:

Installation:

clone this to where your awesome config is located
either into /etc/xdg/awesome (systemwide)
or ~/.config/awesome

add to your awesome rc file:

```
local iw_info_widget = require("awesome-iw-widget.iw-widget")
```


plant it somewhere in:
```
awful.screen.connect_for_each_screen(function(s)
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
	    iw_info_widget,
	},
    }
end)
```

# TODO
i planned to detect the active interface,
and showing multiple interfaces if you have

for now you can set the INTERFACE variable in the lua script to your interfaces name


-- ROG G15 Strix (2021) specific bindings
-- Key codes are raw Linux keycodes for ASUS-specific hardware keys

hl.bind("156", hl.dsp.exec_cmd("rog-control-center"))                          -- Armory Crate key
hl.bind("211", hl.dsp.exec_cmd("asusctl profile -n; pkill -SIGRTMIN+8 waybar")) -- Fan profile cycle (FN+F5)
hl.bind("210", hl.dsp.exec_cmd("asusctl led-mode -n"))                          -- Keyboard RGB profile (FN+F4)

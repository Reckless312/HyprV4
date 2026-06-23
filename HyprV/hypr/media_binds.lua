-- Media and brightness key bindings

local SCRIPT = os.getenv("HOME") .. "/.config/HyprV/waybar/scripts"

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(SCRIPT .. "/volume --inc"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(SCRIPT .. "/volume --dec"))
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd(SCRIPT .. "/volume --toggle-mic"))
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(SCRIPT .. "/volume --toggle"))
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd(SCRIPT .. "/kb-brightness --dec"))
hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd(SCRIPT .. "/kb-brightness --inc"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(SCRIPT .. "/brightness --dec"))
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(SCRIPT .. "/brightness --inc"))

-- Hyprland Lua configuration
-- Converted from hyprland.conf (original left untouched)
-- See https://wiki.hypr.land/Configuring/Start/

require("env_var")
require("env_var_nvidia")
require("media_binds")


--------------------
---- MONITORS -----
--------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Dual monitor example (G15 Strix):
-- DP-1 is the external monitor on the left, eDP-1 is the built-in on the right.
-- Both are 2560x1440@165. Uncomment and comment the wildcard entry to use.
-- hl.monitor({ output = "DP-1",  mode = "2560x1440@165", position = "0x0",    scale = "1" })
-- hl.monitor({ output = "eDP-1", mode = "2560x1440@165", position = "2560x0", scale = "1" })

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- Additional vars set inline in the original hyprland.conf (on top of env_var_nvidia.lua)
hl.env("__GLX_VENDOR_LIBRARY_NAME",      "nvidia")
hl.env("NVD_BACKEND",                    "direct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT",   "auto")


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- All of the original exec-once commands run here at startup.
hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/xdg-portal-hyprland")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("mako")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("wl-paste --watch cliphist store")
    -- Bluetooth: power on, wait 2s, trust, wait 1s, connect
    hl.exec_cmd("bash -c 'bluetoothctl power on && sleep 2 && bluetoothctl trust 84:D3:52:34:C3:7E && sleep 1 && bluetoothctl connect 84:D3:52:34:C3:7E'")
end)

-- 'exec' (not exec-once): also re-runs on config reload
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("~/.config/HyprV/hyprv_util setbg")
end)
hl.on("config.reloaded", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("~/.config/HyprV/hyprv_util setbg")
end)


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 10,
        border_size = 2,

        col = {
            active_border   = "rgb(cdd6f4)",
            inactive_border = "rgba(595959aa)",
        },

        layout = "dwindle",
    },
})

hl.config({
    decoration = {
        rounding = 5,

        blur = {
            enabled = true,
            size    = 7,
            passes  = 4,
        },

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
    },
})

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("myBezier", { type = "bezier", points = { {0.10, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 7,  bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7,  bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6,  bezier = "default" })

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    misc = {
        disable_hyprland_logo = false,
    },
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q",         hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + C",         hl.dsp.window.close())
hl.bind(mainMod .. " + L",         hl.dsp.exec_cmd("swaylock"))
hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd("wlogout --protocol layer-shell"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + F",         hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE",     hl.dsp.exec_cmd("wofi"))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",         hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + Print",     hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(mainMod .. " + PRINT",     hl.dsp.exec_cmd("grimblast copy area"))
hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd("~/.config/HyprV/hyprv_util vswitch"))
hl.bind(mainMod .. " + TAB",       hl.dsp.exec_cmd("~/.config/HyprV/waybar/scripts/baraction light"))
hl.bind("ALT + V",                 hl.dsp.exec_cmd("cliphist list | wofi -dmenu | cliphist decode | wl-copy"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0",         hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Discord: pass key events through to the discord window
hl.bind(mainMod .. " + KP_Subtract", hl.dsp.pass({ window = "class:^discord$" }))
hl.bind(mainMod .. " + KP_Multiply", hl.dsp.pass({ window = "class:^discord$" }))

-- Scroll through existing workspaces with mainMod + scroll wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Float rules
hl.window_rule({ name = "float-pavucontrol",     match = { class = "^(pavucontrol)$" },           float = true })
hl.window_rule({ name = "float-blueman",         match = { class = "^(blueman-manager)$" },        float = true })
hl.window_rule({ name = "float-nm-connection",   match = { class = "^(nm-connection-editor)$" },   float = true })
hl.window_rule({ name = "float-chromium",        match = { class = "^(chromium)$" },               float = true })
hl.window_rule({ name = "float-thunar",          match = { class = "^(thunar)$" },                 float = true })
hl.window_rule({ name = "float-btop",            match = { title = "^(btop)$" },                   float = true })
hl.window_rule({ name = "float-update-sys",      match = { title = "^(update-sys)$" },             float = true })

-- Opacity rules
hl.window_rule({
    name    = "opacity-kitty",
    match   = { class = "^(kitty)$" },
    opacity = "0.8 override 0.8 override",
})
hl.window_rule({
    name    = "opacity-thunar",
    match   = { class = "^(thunar)$" },
    opacity = "0.8 override 0.8 override",
})
hl.window_rule({
    name    = "opacity-vscodium",
    match   = { class = "^(VSCodium)$" },
    opacity = "0.8 override 0.8 override",
})
hl.window_rule({
    name    = "opacity-wofi",
    match   = { class = "^(wofi)$" },
    opacity = "0.8 override 0.6 override",
    move    = "cursor -3% -105%",
    no_anim = true,
})

-- Animation rules
hl.window_rule({
    name      = "anim-kitty-update-sys",
    match     = { class = "^(kitty)$", title = "^(update-sys)$" },
    animation = "popin",
})
hl.window_rule({ name = "anim-thunar",   match = { class = "^(thunar)$" },   animation = "popin" })
hl.window_rule({ name = "anim-chromium", match = { class = "^(chromium)$" }, animation = "popin" })

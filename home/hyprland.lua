-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1.5",
    bitdepth = 10,
    cm       = "hdr"
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "pcmanfm"
local menu        = "rofit -show drun"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
  hl.exec_cmd("openrgb -p None.orp")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        force_split = 2,
        preserve_split = true, -- You probably want this
        smart_resizing = false,
        smart_split = false,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
        disable_splash_rendering = true,
        middle_click_paste = false,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
    quirks = {
        prefer_hdr = 1
    },
    xwayland = {
        use_nearest_neighbor = false,
        force_zero_scaling = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "altgr-intl",
        kb_model   = "",
        kb_options = "caps:super",
        kb_rules   = "",

        follow_mouse = 0,
        repeat_rate = 50,
        repeat_delay = 400,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

local function bind_with_mainMod(key, cmd)
    hl.bind(key, cmd)
    hl.bind(mainMod .. " + " .. key, cmd)
end

layouts_per_workspace = {}
function get_active_workspace_layout()
    local workspace = hl.get_active_workspace()
    return layouts_per_workspace[workspace.id] or "dwindle"
end

function set_active_workspace_layout(layout)
    local workspace = hl.get_active_workspace()
    layouts_per_workspace[workspace.id] = layout
    hl.workspace_rule({ workspace = workspace.id, layout = layouts_per_workspace[workspace.id] })
end

hl.bind(mainMod .. " + Space", hl.dsp.submap("space chord"))

-- Start a submap called "resize".
hl.define_submap("space chord", "reset", function()
    hl.bind("Space", hl.dsp.exec_cmd(menu))

    bind_with_mainMod("f", hl.dsp.exec_cmd("firefox"))
    bind_with_mainMod("m", hl.dsp.exec_cmd(fileManager))
    bind_with_mainMod("q", hl.dsp.exec_cmd("rofit -show p -modi \"p:rofi-power --choices=shutdown/reboot/logout\" -theme power"))
    bind_with_mainMod("u", hl.dsp.exec_cmd("rofit -show emoji -emoji-format \"{emoji}\" -modi emoji -theme emoji"))
    bind_with_mainMod("n", hl.dsp.exec_cmd("rofit -show calc -modi calc -no-show-match -no-sort -automatic-save-to-history -theme calc"))

end)

hl.bind("ALT + Tab", function ()
    local current_layout = get_active_workspace_layout()
    if current_layout == "dwindle"
        then hl.dispatch(hl.dsp.window.cycle_next({ next = true, tiled = true }))
        else hl.dispatch(hl.dsp.layout("cyclenext"))
    end
end)
hl.bind("ALT + SHIFT + Tab", function ()
    local current_layout = get_active_workspace_layout()
    if current_layout == "dwindle"
        then hl.dispatch(hl.dsp.window.cycle_next({ next = false, tiled = true }))
        else hl.dispatch(hl.dsp.layout("cycleprev"))
    end
end)

hl.bind("Print", hl.dsp.exec_cmd("grim -t ppm - | satty --initial-tool=crop --filename - --fullscreen --copy-command=wl-copy --early-exit --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim -t ppm - | satty --initial-tool=crop --filename - --fullscreen --copy-command=wl-copy --early-exit --output-filename - | tesseract -l spa+eng stdin stdout | wl-copy; notify-send Tesseract 'Copied to clipboard'"))

-- Laptop multimedia keys for volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + q", hl.dsp.layout("rotatesplit -90")) -- dwindle only
hl.bind(mainMod .. " + e", hl.dsp.layout("rotatesplit 90")) -- dwindle only
hl.bind(mainMod .. " + x", hl.dsp.window.close())
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + t", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + p", hl.dsp.window.pin())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + v", hl.dsp.exec_cmd("handy --toggle-transcription"))

-- Move focus with mainMod + wasd
hl.bind(mainMod .. " + w", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + a", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + s", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + d", hl.dsp.focus({ direction = "right" }))

-- Move window with mainMod + wasd
hl.bind(mainMod .. " + ALT + w", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + ALT + a", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + ALT + s", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + ALT + d", hl.dsp.window.move({ direction = "right" }))

-- Move window with mainMod + wasd
hl.bind(mainMod .. " + ALT + w", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + ALT + a", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + ALT + s", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + ALT + d", hl.dsp.window.move({ direction = "right" }))

-- Resize window with mainMod + wasd
hl.bind(mainMod .. " + SHIFT + w", hl.dsp.window.resize({ relative = true, x =    0, y = - 50 }))
hl.bind(mainMod .. " + SHIFT + a", hl.dsp.window.resize({ relative = true, x = - 50, y =    0 }))
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.window.resize({ relative = true, x =    0, y =   50 }))
hl.bind(mainMod .. " + SHIFT + d", hl.dsp.window.resize({ relative = true, x =   50, y =    0 }))

hl.bind(mainMod .. " + Equal", hl.dsp.layout("splitratio 1.0 exact"))

hl.bind(mainMod .. " + f", function()
    local current_layout = get_active_workspace_layout()
    if current_layout == nil then
        current_layout = "dwindle"
    end
    if current_layout == "monocle" then
        set_active_workspace_layout("dwindle")
    else
        set_active_workspace_layout("monocle")
    end
end)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + ALT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + ALT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})


hl.window_rule({
    name = "flameshot-fix",
    match = { initial_title = "flameshot" },
    no_anim = true,
    float = true,
    pin = true,
    border_size = 0,
    suppress_event = "fullscreen",
    move = "0 0",
    size = {"3840", "2160"},
})

hl.window_rule({
    name = "satty-fix",
    match = { initial_title = "satty" },
    no_anim = true,
    float = true,
    pin = false,
})

hl.window_rule({
    name = "PiP-fix",
    match = { initial_title = "Picture-in-Picture", float = true },
    persistent_size = true,
    decorate = false,
    keep_aspect_ratio = true,
    rounding = 0,
})

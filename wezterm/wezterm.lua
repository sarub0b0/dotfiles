local wezterm = require("wezterm")

local keys = {
  leader = {
    key = "s",
    mods = "CTRL",
    timeout_milliseconds = 1000,
  },

  keys = {
    {
      key = "Enter",
      mods = "CTRL|SHIFT",
      action = "ToggleFullScreen",
    },
    {
      key = "F11",
      mods = "",
      action = "ToggleFullScreen",
    },
     {
      key = "v",
      mods = "LEADER",
      action = wezterm.action {
        SplitHorizontal = {
          domain = "CurrentPaneDomain",
        },
      },
    },
    {
      key = "s",
      mods = "LEADER",
      action = wezterm.action {
        SplitVertical = {
          domain = "CurrentPaneDomain",
        },
      },
    },
    {
      key = "h",
      mods = "LEADER",
      action = wezterm.action {
        ActivatePaneDirection = "Left",
      },
    },
    {
      key = "l",
      mods = "LEADER",
      action = wezterm.action {
        ActivatePaneDirection = "Right",
      },
    },
    {
      key = "k",
      mods = "LEADER",
      action = wezterm.action {
        ActivatePaneDirection = "Up",
      },
    },
    {
      key = "j",
      mods = "LEADER",
      action = wezterm.action {
        ActivatePaneDirection = "Down",
      },
    },
    {
      key = "l",
      mods = "ALT",
      action = "ShowLauncher",
    },
    {
      key = "H",
      mods = "LEADER",
      action = wezterm.action {
        AdjustPaneSize = {
          "Left",
          5,
        },
      },
    },
    {
      key = "J",
      mods = "LEADER",
      action = wezterm.action {
        AdjustPaneSize = {
          "Down",
          5,
        },
      },
    },
    {
      key = "K",
      mods = "LEADER",
      action = wezterm.action {
        AdjustPaneSize = {
          "Up",
          5,
        },
      },
    },
    {
      key = "L",
      mods = "LEADER",
      action = wezterm.action {
        AdjustPaneSize = {
          "Right",
          5,
        },
      },
    },
  },
}

local colors = {
  foreground = "#ffffff",
  background = "#1b2b34",
  cursor_bg = "#c0c5ce",
  cursor_border = "#c0c5ce",
  cursor_fg = "#ffffff",
  selection_bg = "#4f5b66",
  selection_fg = "#c0c5ce",

  ansi = {
    "#1b2b34",
    "#ec5f67",
    "#99c794",
    "#fac863",
    "#6699cc",
    "#c594c5",
    "#62b3b2",
    "#ffffff",
  },
  brights = {
    "#65737e",
    "#ff676f",
    "#ade0a7",
    "#ffcc65",
    "#73ace6",
    "#dea7de",
    "#70cccb",
    "#ffffff",
  },

  tab_bar = {

    background = "#1b2b34",

    active_tab = {
      bg_color = "#c0c0c0",
      fg_color = "#1b2b34",
    },

    inactive_tab = {
      bg_color = "#1b2b34",
      fg_color = "#ffffff",
    },

    inactive_tab_hover = {
      bg_color = "#6699cc",
      fg_color = "#ffffff",
    },

    new_tab = {
      bg_color = "#4f5b66",
      fg_color = "#1b2b34",
    },

    new_tab_hover = {
      bg_color = "#6699cc",
      fg_color = "#ffffff",
    },
  },
}

local launch_menu = {
  {
    label = "PowerShell",
    args = {
      "powershell.exe",
      "-NoLogo",
    },
  },
  {
    label = "Modify AutoHotkey",
    args = {
      "code",
      "~/dotfiles/autohotkey.ahk",
    },
  },
}

local default_prog = {}
local font = {}

if wezterm.target_triple == "x86_64-apple-darwin" then
    default_prog = {
        "/bin/zsh",
        "-l"
    }

    font = wezterm.font("RictyDiminished Nerd Font")

elseif wezterm.target_triple == "x86_64-pc-windows-msvc" then
    default_prog = {
        "wsl",
        "-d",
        "Ubuntu",
        "--cd",
        "~",
    }

    font = wezterm.font("HackGenNerd Console")
end


return {
  font = font,

  use_ime = true,

  default_prog = default_prog,

  -- color_scheme = "OceanicNext",

  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  -- window_frame = {
  --     font = wezterm.font("roboto"),
  --     active_titlebar_bg = "#1b2b34",
  --     inactive_titlebar_bg = "#1b2b34",
  -- },

  exit_behavior = "Close",

  launch_menu = launch_menu,

  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },

  debug_key_events = true,

  leader = keys.leader,
  keys = keys.keys,
  colors = colors,

  audible_bell = 'Disabled',
}


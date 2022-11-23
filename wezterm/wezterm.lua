local wezterm = require("wezterm")

local keys = {
  -- leader = {
  --   key = "s",
  --   mods = "CTRL",
  --   timeout_milliseconds = 1000,
  -- },

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
    -- {
    --   key = "v",
    --   mods = "LEADER",
    --   action = wezterm.action {
    --     SplitHorizontal = {
    --       domain = "CurrentPaneDomain",
    --     },
    --   },
    -- },
    -- {
    --   key = "s",
    --   mods = "LEADER",
    --   action = wezterm.action {
    --     SplitVertical = {
    --       domain = "CurrentPaneDomain",
    --     },
    --   },
    -- },
    -- {
    --   key = "h",
    --   mods = "LEADER",
    --   action = wezterm.action {
    --     ActivatePaneDirection = "Left",
    --   },
    -- },
    -- {
    --   key = "l",
    --   mods = "LEADER",
    --   action = wezterm.action {
    --     ActivatePaneDirection = "Right",
    --   },
    -- },
    -- {
    --   key = "k",
    --   mods = "LEADER",
    --   action = wezterm.action {
    --     ActivatePaneDirection = "Up",
    --   },
    -- },
    -- {
    --   key = "j",
    --   mods = "LEADER",
    --   action = wezterm.action {
    --     ActivatePaneDirection = "Down",
    --   },
    -- },
    {
      key = "l",
      mods = "ALT",
      action = "ShowLauncher",
    },
    -- {
    --   key = "H",
    --   mods = "LEADER",
    --   action = wezterm.action {
    --     AdjustPaneSize = {
    --       "Left",
    --       5,
    --     },
    --   },
    -- },
    -- {
    --   key = "J",
    --   mods = "LEADER",
    --   action = wezterm.action {
    --     AdjustPaneSize = {
    --       "Down",
    --       5,
    --     },
    --   },
    -- },
    -- {
    --   key = "K",
    --   mods = "LEADER",
    --   action = wezterm.action {
    --     AdjustPaneSize = {
    --       "Up",
    --       5,
    --     },
    --   },
    -- },
    -- {
    --   key = "L",
    --   mods = "LEADER",
    --   action = wezterm.action {
    --     AdjustPaneSize = {
    --       "Right",
    --       5,
    --     },
    --   },
    -- },
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

  font = wezterm.font("MesloLGS NF")

elseif wezterm.target_triple == "x86_64-pc-windows-msvc" then
  default_prog = {
    "wsl",
    "-d",
    "openSUSE-Tumbleweed",
    "--cd",
    "~",
  }

  font = wezterm.font("MesloLGS NF", { weight = 'Regular' })
end


return {

  font = font,
  freetype_load_target = "Light",
  freetype_interpreter_version = 40,
  -- freetype_load_flags = 'NO_HINTING',
  -- freetype_render_target = 'HorizontalLcd',
  cell_width = 0.9,


  use_ime = true,

  default_prog = default_prog,

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

  -- debug_key_events = true,

  leader = keys.leader,
  keys = keys.keys,
  -- colors = colors,
  color_scheme = 'OceanicNext',

  audible_bell = 'Disabled',
}

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ----------------------------
-- Default shell: WSL Ubuntu 24.04
-- ----------------------------
config.default_prog = {
  'wsl.exe',
  '--distribution', 'Ubuntu-24.04',
}

-- config.disable_default_key_bindings = true

-- --------------------
-- Mouse clicks
-- -------------------------
-- Ctrl-click will open the link under the mouse cursor
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL|SHIFT',
    action = wezterm.action.OpenLinkAtMouseCursor,
  }
}


-- ----------------------------
-- Launcher menu
-- ----------------------------
config.launch_menu = {
  {
    label = 'WSL Ubuntu 24.04',
    args = { 'wsl.exe', '--distribution', 'Ubuntu-24.04' },
    set_environment_variables = {
       HOME="/home/jdamon"
    }
  },
  {
    label = 'WSL (default distro)',
    args = { 'wsl.exe' },
  },
  {
    label = 'Cygwin',
    args = { 'C:/cygwin64/bin/zsh.exe', '-l' },
    set_environment_variables = {
      CHERE_INVOKING = '1',
    },
  },
  {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  },
  {
    label = 'Command Prompt',
    args = { 'cmd.exe' },
  },
}

-- ----------------------------
-- Appearance
-- ----------------------------
config.font = wezterm.font('DejaVuSansM Nerd Font')
config.font_size = 18 
config.text_background_opacity = 1.0
-- config.color_scheme = 'Builtin Solarized Dark'
config.color_scheme = "Bamboo"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = 'Disabled'

-- ----------------------------
-- Env tweaks
-- ----------------------------
config.set_environment_variables = {
  CHERE_INVOKING = '1',
}

-- ----------------------------
-- Keybindings
-- ----------------------------
config.keys = {
    { key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment, },
    { key = 'Enter', mods = 'CTRL|SHIFT', action = wezterm.action.ToggleFullScreen, },
    { key = 'L', mods = 'CTRL|SHIFT', action = wezterm.action.ShowLauncher },
    { key = 'P', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCommandPalette },
    { key = 'R', mods = 'CTRL|SHIFT', action = wezterm.action.ReloadConfiguration },
    { key = 'LeftArrow', mods = 'CTRL|SHIFT' , action = wezterm.action.ActivateTabRelative(-1) },
    { key = 'RightArrow', mods = 'CTRL|SHIFT' , action = wezterm.action.ActivateTabRelative(1) },

}

-- ----------------------------
-- Hyperlink rules
-- ----------------------------
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- WSL paths → VSCode (Remote WSL)
table.insert(config.hyperlink_rules, {
  regex = [[((?:/home|/mnt|/usr|/opt|/etc|/tmp)/[^\s:]+):(\d+)]],
  format = 'vscode://vscode-remote/wsl+Ubuntu-24.04$1:$2',
})

-- Windows paths
table.insert(config.hyperlink_rules, {
  regex = [[(([A-Za-z]:\\(?:[^\\\s:]+\\)*[^\\\s:]+)):(\d+)]],
  format = 'file:///$1',
})

-- Cygwin paths → Windows
table.insert(config.hyperlink_rules, {
  regex = [[(/cygdrive/([a-zA-Z])/[^\s:]+):(\d+)]],
  format = 'file:///$2:/$1',
})

table.insert(config.hyperlink_rules, {
  regex = [[((?:/home|/mnt|/usr|/opt|/etc|/tmp|/workspace)/[^\s:]+):(\d+):(\d+)]],
  format = 'vscode://vscode-remote/wsl+Ubuntu-24.04$1:$2:$3',
})

table.insert(config.hyperlink_rules, {
  regex = [[((?:/home|/mnt|/usr|/opt|/etc|/tmp|/workspace)/[^\s:]+):(\d+)]],
  format = 'vscode://vscode-remote/wsl+Ubuntu-24.04$1:$2',
})

return config























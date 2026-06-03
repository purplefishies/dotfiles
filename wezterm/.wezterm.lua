local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil

-- ----------------------------
-- Default shell: WSL Ubuntu 24.04
-- ----------------------------
config.default_prog = {
  'wsl.exe',
  '--distribution', 'Ubuntu-22.04',
}


-- Determine if the foreground process is a shell
local function is_shell(foreground_process_name)
   local shell_names = { 'bash', 'zsh', 'fish', 'sh', 'ksh', 'dash' }
   local process = string.match(foreground_process_name, '[^/\\]+$') or foreground_process_name
   for _, shell in ipairs(shell_names) do
      if process == shell then return true end
   end
   return false
end

local function file_uri_to_path(uri)
   local parsed = wezterm.url.parse(uri)
   if parsed and parsed.file_path then
      return parsed.file_path
   end
   if parsed and parsed.path then
      return parsed.path
   end
   return uri:gsub('^file://', '')
end

-- config.disable_default_key_bindings = true

-- --------------------
-- Mouse clicks
-- -------------------------
-- Only Ctrl+Left-click will open the link under the mouse cursor.
-- Plain single/double left-clicks are explicitly ignored here so they
-- don't open hyperlinks; normal selection still works from the mouse-down
-- defaults below/inside wezterm.
config.mouse_bindings = {
  -- Ctrl+Shift+Left opens hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },

  -- Disable plain left-click hyperlink opening.
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.Nop,
  },

  -- Double left click:
  -- Select the word under the mouse cursor and copy it to the clipboard.
  -- This does not open hyperlinks because plain double-click is handled here.
  {
    event = { Down = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = act.Multiple {
      act.SelectTextAtMouseCursor 'Word',
      act.CopyTo 'Clipboard',
    },
  },

  -- Ignore the matching double-left release so it cannot open hyperlinks.
  {
    event = { Up = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = act.Nop,
  },

  -- Disable plain triple-left-click hyperlink opening too, while we're here.
  {
    event = { Up = { streak = 3, button = 'Left' } },
    mods = 'NONE',
    action = act.Nop,
  },

  -- Middle click pastes from the clipboard.
  {
    event = { Down = { streak = 1, button = 'Middle' } },
    mods = 'NONE',
    action = act.PasteFrom 'Clipboard',
  },

  -- Single right click:
  -- If text selected -> copy to clipboard
  -- Else -> paste
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action_callback(function(window, pane)
      local selection = window:get_selection_text_for_pane(pane)

      if selection and selection ~= '' then
         window:perform_action(act.CopyTo('ClipboardAndPrimarySelection'), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act.PasteFrom('Clipboard'), pane)
      end
    end),
  },

  -- Double right click:
  -- Copy selected text to PRIMARY selection buffer
  {
    event = { Down = { streak = 2, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action_callback(function(window, pane)
      local selection = window:get_selection_text_for_pane(pane)

      if selection and selection ~= '' then
         window:perform_action(act.CopyTo('ClipboardAndPrimarySelection'), pane)
        window:perform_action(act.ClearSelection, pane)
      end
    end),
  },
}

-- ----------------------------
-- Launcher menu
-- ----------------------------
if is_windows then  
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
else 

  config.default_prog = { '/usr/bin/zsh', '-l' }

  config.launch_menu = {
    { label = 'zsh', args = { '/usr/bin/zsh', '-l' } },
    { label = 'bash', args = { '/bin/bash', '-l' } },
  }
end

-- ----------------------------
-- Appearance
-- ----------------------------
config.font = wezterm.font('DejaVuSansM Nerd Font')
config.font_size = 18 
config.text_background_opacity = 1.0
config.window_background_opacity = 0.95
-- config.color_scheme = 'Builtin Solarized Dark'
config.color_scheme = "Bamboo"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = 'Disabled'
config.selection_word_boundary = ' |↑\t\n{}[]()"\'`'


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
    { key = '_'    , mods = 'CTRL|SHIFT', action = wezterm.action.DisableDefaultAssignment },
    { key = 'Enter', mods = 'ALT|SHIFT', action = wezterm.action.ToggleFullScreen, },
    { key = 'L', mods = 'CTRL|SHIFT', action = wezterm.action.ShowLauncher },
    { key = 'P', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCommandPalette },
    { key = 'R', mods = 'CTRL|SHIFT', action = wezterm.action.ReloadConfiguration },
    { key = 'LeftArrow', mods = 'CTRL|SHIFT' , action = wezterm.action.ActivateTabRelative(-1) },
    { key = 'RightArrow', mods = 'CTRL|SHIFT' , action = wezterm.action.ActivateTabRelative(1) },
 {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}

-- ----------------------------
-- Hyperlink rules
-- ----------------------------

config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- WSL paths → VSCode (Remote WSL)
-- table.insert(config.hyperlink_rules, {
--   regex = [[((?:/home|/mnt|/usr|/opt|/etc|/tmp)/[^\s:]+):(\d+)]],
--   format = 'emacs://$1:$2',
-- })

-- -- Windows paths
-- table.insert(config.hyperlink_rules, {
--   regex = [[(([A-Za-z]:\\(?:[^\\\s:]+\\)*[^\\\s:]+)):(\d+)]],
--   format = 'file:///$1',
-- })

-- -- Cygwin paths → Windows
-- table.insert(config.hyperlink_rules, {
--   regex = [[(/cygdrive/([a-zA-Z])/[^\s:]+):(\d+)]],
--   format = 'file:///$2:/$1',
-- })

-- table.insert(config.hyperlink_rules, {
--   regex = [[((?:/home|/mnt|/usr|/opt|/etc|/tmp|/workspace)/[^\s:]+):(\d+):(\d+)]],
--   format = 'emacs://$1:$2:$3',
-- })

-- table.insert(config.hyperlink_rules, {
--   regex = [[((?:/home|/mnt|/usr|/opt|/etc|/tmp|/workspace)/[^\s:]+):(\d+)]],
--   format = 'emacs://$1:$2',
-- })


-- ----------------------------
-- Hyperlink rules
-- ----------------------------
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- tar-style ./relative/path/file:line:column
-- Emit emacs://./... directly. Your open-emacs-uri handler resolves ./ using its PWD.
table.insert(config.hyperlink_rules, {
  regex = [[(\./[^:\s]+):(\d+):(\d+):?]],
  format = 'emacs://$1:$2:$3',
})

-- tar-style ./relative/path/file:line
table.insert(config.hyperlink_rules, {
  regex = [[(\./[^:\s]+):(\d+):?]],
  format = 'emacs://$1:$2',
})

-- bare tar-style ./relative/path/file
table.insert(config.hyperlink_rules, {
  regex = [[(\./[^:\s]+)]],
  format = 'emacs://$1',
})

-- Absolute paths with line/column
table.insert(config.hyperlink_rules, {
  regex = [[(/[^:\s]+):(\d+):(\d+):?]],
  format = 'emacs://$1:$2:$3',
})

-- Absolute paths with line
table.insert(config.hyperlink_rules, {
  regex = [[(/[^:\s]+):(\d+):?]],
  format = 'emacs://$1:$2',
}) 



return config

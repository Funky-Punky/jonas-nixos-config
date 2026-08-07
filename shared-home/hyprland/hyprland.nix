{
  pkgs,
  lib,
  ...
}:
let
  lua = lib.generators.mkLuaInline;

  dsp = {
    exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close = lua "hl.dsp.window.close()";
    exit = lua "hl.dsp.exit()";
    float = lua ''hl.dsp.window.float({ action = "toggle" })'';
    fullscreen = lua "hl.dsp.window.fullscreen()";
    pseudo = lua "hl.dsp.window.pseudo()";
    layout = msg: lua ''hl.dsp.layout("${msg}")'';
    focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
    swap = dir: lua ''hl.dsp.window.swap({ direction = "${dir}" })'';
    toggleSpecial = name: lua ''hl.dsp.workspace.toggle_special("${name}")'';
    moveToSpecial = name: lua ''hl.dsp.window.move({ workspace = "special:${name}" })'';
    focusWorkspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    drag = lua "hl.dsp.window.drag()";
    resize = lua "hl.dsp.window.resize()";
    sendshortcut = mod: key: lua ''hl.dsp.send_shortcut({ mods = "${mod}", key = "${key}" })'';
  };

  bind = keys: dispatcher: { _args = [keys dispatcher]; };
  bindOpts = keys: dispatcher: opts: { _args = [keys dispatcher opts]; };

  workspaceBinds = lib.concatMap (i:
    let key = toString (lib.mod i 10);
    in [
      (bind "SUPER + ${key}" (dsp.focusWorkspace i))
      (bind "SUPER + SHIFT + ${key}" (dsp.moveToWorkspace i))
    ]
  ) (lib.range 1 10);

  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    hyprlock &
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {
      # monitor = [{
      #   output = "DP-1";
        # mode = "3840x2160";
      #   position = "0x0";
      #   scale = "1.0";
      # }];

      config = {
        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 1;
          col = {
            active_border = "rgb(e1e1e1)";
            inactive_border = "rgb(151515)";
          };
        };

        decoration = {
          rounding = 5;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
        };

        dwindle = {
          force_split = 2;
          preserve_split = true;
        };

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = true;
        };
        input = {
          kb_layout = "eu";
          follow_mouse = 1;
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
          touchpad = {
            natural_scroll = true;
          };
        };
      };

      curve = [
        {
          _args = [
            "easeOutQuint"
            {
              type = "bezier";
              points = lua "{ {0.23, 1}, {0.32, 1} }";
            }
          ];
        }
        {
          _args = [
            "easeInOutCubic"
            {
              type = "bezier";
              points = lua "{ {0.65, 0.05}, {0.36, 1} }";
            }
          ];
        }
        {
          _args = [
            "linear"
            {
              type = "bezier";
              points = lua "{ {0, 0}, {1, 1} }";
            }
          ];
        }
        {
          _args = [
            "almostLinear"
            {
              type = "bezier";
              points = lua "{ {0.5, 0.5}, {0.75, 1.0} }";
            }
          ];
        }
        {
          _args = [
            "quick"
            {
              type = "bezier";
              points = lua "{ {0.15, 0}, {0.1, 1} }";
            }
          ];
        }
      ];

      # animation = [
      #   { leaf = "windows"; enabled = true; speed = 7; bezier = "myBezier"; }
      #   { leaf = "windowsOut"; enabled = true; speed = 7; bezier = "default"; style = "popin 80%"; }
      #   { leaf = "border"; enabled = true; speed = 10; bezier = "default"; }
      #   { leaf = "borderangle"; enabled = true; speed = 8; bezier = "default"; }
      #   { leaf = "fade"; enabled = true; speed = 7; bezier = "default"; }
      #   { leaf = "workspaces"; enabled = true; speed = 6; bezier = "default"; }
      # ];

      animation = [
        { leaf = "global"; enabled = true; speed = 10; bezier = "default"; }
        { leaf = "border"; enabled = true; speed = 5.39; bezier = "easeOutQuint"; }
        { leaf = "windows"; enabled = true; speed = 4.79; bezier = "easeOutQuint"; }
        { leaf = "windowsIn"; enabled = true; speed = 4.1; bezier = "easeOutQuint"; style = "popin 87%"; }
        { leaf = "windowsOut"; enabled = true; speed = 1.49; bezier = "linear"; style = "popin 87%"; }
        { leaf = "fadeIn"; enabled = true; speed = 1.73; bezier = "almostLinear"; }
        { leaf = "fadeOut"; enabled = true; speed = 1.46; bezier = "almostLinear"; }
        { leaf = "fade"; enabled = true; speed = 3.03; bezier = "quick"; }
        { leaf = "layers"; enabled = true; speed = 3.81; bezier = "easeOutQuint"; }
        { leaf = "layersIn"; enabled = true; speed = 4; bezier = "easeOutQuint"; style = "fade"; }
        { leaf = "layersOut"; enabled = true; speed = 1.5; bezier = "linear"; style = "fade"; }
        { leaf = "fadeLayersIn"; enabled = true; speed = 1.79; bezier = "almostLinear"; }
        { leaf = "fadeLayersOut"; enabled = true; speed = 1.39; bezier = "almostLinear"; }
        { leaf = "workspaces"; enabled = true; speed = 1.94; bezier = "almostLinear"; style = "fade"; }
        { leaf = "workspacesIn"; enabled = true; speed = 1.21; bezier = "almostLinear"; style = "fade"; }
        { leaf = "workspacesOut"; enabled = true; speed = 1.94; bezier = "almostLinear"; style = "fade"; }
        # { leaf = "zoomFactor"; enabled = true; speed = 7; bezier = "quick"; }
      ];

      window_rule = [{
        match = {
          class = "^(kitty)$";
          title = "^(bw-unlock)$";
        };
        float = true;
      }];

      # on = {
      #   _args = [
      #     "hyprland.start"
      #     (lua ''
      #       function()
      #         hl.exec_cmd("${startupScript}/bin/start")
      #       end'')
      #   ];
      # };

      bind = [
        # App launchers
        (bind "SUPER + RETURN" (dsp.exec "alacritty"))
        (bind "SUPER + B" (dsp.exec "firefox"))
        (bind "SUPER + SPACE" (dsp.exec "walker"))
        # (bind "SUPER + CTRL + V" (dsp.exec "walker -m clipboard"))
        # (bind "SUPER + M" (dsp.exec "kitty nvim ~/Cortex/00_NOTES/temp.md"))

        # Screenshots
        # (bind "SUPER + CTRL + 4" (dsp.exec "grimblast copysave area"))
        # (bind "SUPER + CTRL + 5" (dsp.exec "grimblast copysave screen"))

        # Universal copy/paste
        # (bind "SUPER + C" (dsp.sendshortcut "CTRL" "Insert"))
        # (bind "SUPER + V" (dsp.sendshortcut "SHIFT" "Insert"))
        # (bind "SUPER + X" (dsp.sendshortcut "CTRL" "X"))

        # Window management
        (bind "SUPER + Q" dsp.close)
        (bind "SUPER + SHIFT + Q" dsp.exit)
        (bind "SUPER + CTRL + Q" (dsp.exec "hyprlock"))
        (bind "SUPER + T" dsp.float)
        (bind "SUPER + F" dsp.fullscreen)
        (bind "SUPER + P" dsp.pseudo)
        (bind "SUPER + J" (dsp.layout "togglesplit"))

        # Focus
        (bind "SUPER + h" (dsp.focus "left"))
        (bind "SUPER + l" (dsp.focus "right"))
        (bind "SUPER + k" (dsp.focus "up"))
        (bind "SUPER + j" (dsp.focus "down"))

        # Swap windows
        (bind "SUPER + SHIFT + h" (dsp.swap "left"))
        (bind "SUPER + SHIFT + l" (dsp.swap "right"))
        (bind "SUPER + SHIFT + k" (dsp.swap "up"))
        (bind "SUPER + SHIFT + j" (dsp.swap "down"))

        # Special workspace
        # (bind "SUPER + S" (dsp.toggleSpecial "magic"))
        # (bind "SUPER + SHIFT + S" (dsp.moveToSpecial "magic"))

        # Scroll through workspaces
        # (bind "SUPER + mouse_down" (dsp.focusWorkspace "e+1"))
        # (bind "SUPER + mouse_up" (dsp.focusWorkspace "e-1"))

        # Volume keys
        (bindOpts "XF86AudioRaiseVolume" (dsp.exec "wpctl set-volume @ 5%+") { locked = true; repeating = true; })
        (bindOpts "XF86AudioLowerVolume" (dsp.exec "wpctl set-volume @ 5%-") { locked = true; repeating = true; })
        (bindOpts "XF86AudioMute" (dsp.exec "wpctl set-mute @ toggle") { locked = true; })
        (bindOpts "XF86AudioMicMute" (dsp.exec "wpctl set-mute u/DEFAULT_AUDIO_SOURCE@ toggle") { locked = true; })

        # Mouse move/resize
        # (bindOpts "SUPER + mouse:272" dsp.drag { mouse = true; })
        # (bindOpts "SUPER + mouse:273" dsp.resize { mouse = true; })
      ] ++ workspaceBinds;
    };
  };
}
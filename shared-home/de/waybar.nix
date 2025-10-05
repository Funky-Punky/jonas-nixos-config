{ config, lib, pkgs, ... }:

{
  programs.waybar = {

    enable = true;
    systemd = {
      enable = false; # disable it,autostart it in hyprland conf
      target = "graphical-session.target";
    };
    style = builtins.readFile ./style.css;

    settings = [{
      "layer" = "top";
      "position" = "top";
      modules-left = [
        "custom/launcher"
        "hyprland/workspaces"
        # "custom/wall"
        "cava"
        "mpris"
      ];
      modules-center = [
        "clock"
        "hyprland/window"
      ];
      modules-right = [
        "wireplumber"
        "backlight"
        "memory"
        "cpu"
        "network"
        "battery"
        "tray"
      ];
      "custom/launcher" = {
        "format" = "";
        "on-click" = "pkill rofi || rofi -show drun";
        "tooltip" = false;
      };
      "hyprland/window" = {
        format = "";
      };
     /* "custom/wall" = {
        "on-click" = ${sharedScripts.wallpaper_random}/bin/wallpaper_random";
        "on-click-middle" = "${sharedScripts.default_wall}/bin/default_wall";
        "on-click-right" = killall dynamic_wallpaper || ${sharedScripts.dynamic_wallpaper}/bin/dynamic_wallpaper &";
        "format" = " 󰠖 ";
        "tooltip" = false;
      }; */
      "custom/cava-internal" = {
        "exec" = ""; /*"sleep 1s && ${sharedScripts.cava-internal}/bin/cava-internal"; */
        "tooltip" = false;
      };
      "hyprland/workspaces" = {
        "format" = "{name}";
        "on-click" = "activate";
        # "on-scroll-up" = "hyprctl dispatch workspace e+1";
        # "on-scroll-down" = "hyprctl dispatch workspace e-1";
      };
      "backlight" = {
        "device" = "intel_backlight";
        "on-scroll-up" = "brightnessctl s 5%+";
        "on-scroll-down" = "brightnessctl s 5%-";
        "format" = "{icon} {percent}%";
        "format-icons" = [ "󰃝" "󰃞" "󰃟" "󰃠" ];
      };
      "wireplumber" = {
        "scroll-step" = 5;
        "format" = "{icon} {volume}%";
        "format-muted" = "󰖁 Muted";
        "format-icons" = {
          "default" = [ "" "" "" ];
        };
        "on-click" = "pavucontrol";
        "tooltip" = true;
      };
      "battery" = {
        "interval" = 10;
        "states" = {
          "warning" = 20;
          "critical" = 10;
        };
        "format" = "{icon} {capacity}%";
        "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        "format-full" = "{icon} {capacity}%";
        "format-charging" = "󰂄 {capacity}%";
        "tooltip" = false;
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%H:%M}";
        "tooltip" = true;
        #"tooltip-format"= "{=%A; %d %B %Y}\n<tt>{calendar}</tt>";
        # "tooltip-format" = "{%A; %b %Y}";
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
      };
      "memory" = {
        "interval" = 1;
        "format" = "󰍛 {percentage}%";
        "states" = {
          "warning" = 85;
        };
      };
      "cpu" = {
        "interval" = 1;
        "format" = " {usage}%";
      };
      /* "mpd" = {
        "max-length" = 25;
        "format" = "<span foreground='#bb9af7'></span> {title}";
        "format-paused" = " {title}";
        "format-stopped" = "<span foreground='#bb9af7'></span>";
        "format-disconnected" = "";
        "on-click" = "mpc --quiet toggle";
        "on-click-right" = "mpc update; mpc ls | mpc add";
        "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp";
        "on-scroll-up" = "mpc --quiet prev";
        "on-scroll-down" = "mpc --quiet next";
        "smooth-scrolling-threshold" = 5;
        "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
      }; */
      "network" = {
        "format-disconnected" = "󰯡  Disconnected";
        "format-ethernet" = "󰀂";
        "format-linked" = "󰖪 (No IP)";
        "format-wifi" = "󰖩 ";
        "interval" = 1;
        "tooltip" = true;
        "tooltip-format" = "󰖩  {essid} ({ipaddr})";
      };
      "tray" = {
        "icon-size" = 15;
        "spacing" = 5;
      };
      "mpris"= {
	      "format"= "{status_icon} {artist}  {title}";
	      "format-paused"= "{status_icon} {artist}  {title}";
	      "player-icons"= {
	      	"default"= "▶";
	      	"mpv"= "🎵";
	      };
	      "status-icons"= {
          "playing" = "";
	      	"paused" = "";
          "stopped" = "";
	      };
      };
      "cava"= {
        "framerate"= 60;
        "autosens"= 1;
        "bars"= 5;
        "bar_width" = 20;
        "bar_spacing" = 50;
        "lower_cutoff_freq"= 50;
        "higher_cutoff_freq"= 10000;
        "method"= "pipewire";
        "source"= "auto";
        "stereo"= false;
        "reverse"= false;
        "bar_delimiter"= 0;
        "monstercat"= false;
        "waves"= false;
        "noise_reduction"= 0.5;
        "input_delay"= 2;
        "format-icons" = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        "actions"= {
                   "on-click-right"= "mode";
                   };
    };
    }];
  };
}

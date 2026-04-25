{
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    hyprpaper
    hyprlock
  ];

  services.swaync = {
    enable = true;
  };

 home.sessionVariables = {
    # Forces Qt apps to use Wayland, falling back to X11 (xcb) if necessary
    QT_QPA_PLATFORM = "wayland;xcb";
    # Ensures apps recognize the Wayland session
    XDG_SESSION_TYPE = "wayland";
    # Common hint for Electron and other toolkit-based apps
    NIXOS_OZONE_WL = "1";
  };


  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "/home/jonas/jonas-nixos-config/shared-home/de/walls/wallhaven-jxgd25.jpg" ];

      wallpaper = [
        ",/home/jonas/jonas-nixos-config/shared-home/de/walls/wallhaven-jxgd25.jpg"
      ];
    };
  };
}

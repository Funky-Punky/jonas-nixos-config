{
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    hyprpaper
    hyprlock
  ];

  services.swaync = {
    enable = true;
  };

  
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
  };


  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "/home/jonas/jonas-nixos-config/shared-home/hyprland/walls/wallhaven-jxgd25.jpg" ];

      wallpaper = [
        ",/home/jonas/jonas-nixos-config/shared-home/hyprland/walls/wallhaven-jxgd25.jpg"
      ];
    };
  };
}

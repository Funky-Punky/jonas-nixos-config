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
  
  wayland.windowManager.hyprland.configType = "hyprlang";


  services.swaync = {
    enable = true;
  };

  
   programs.vscode = {
     enable = true;
     argvSettings = {
      disable-hardware-acceleration = true;
     };
     profiles.default.extensions = with pkgs.vscode-extensions; [
       jnoortheen.nix-ide
       hashicorp.terraform
    ];
   };


  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      # splash_offset = 2.0;

      preload =
        [ "/home/jonas/jonas-nixos-config/shared-home/hyprland/walls/wallhaven-jxgd25.jpg" ];

      wallpaper = [
        ",/home/jonas/jonas-nixos-config/shared-home/hyprland/walls/wallhaven-jxgd25.jpg"
      ];
    };
  };
}

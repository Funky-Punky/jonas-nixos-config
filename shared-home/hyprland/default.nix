{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    inputs.walker.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    hyprpaper
    hyprlock
  ];
  
  services.swaync = {
    enable = true;
  };

  programs.walker.enable=true;
  programs.walker.runAsService = true;

  
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
      # splash = false;
      wallpaper = [
        {
          # fit_mode = "tile";
          monitor = "";
          path = "/home/jonas/jonas-nixos-config/shared-home/hyprland/walls/moon-palm-purple.jpg";
        }
      ];
    };
  };
}

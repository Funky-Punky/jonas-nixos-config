{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../shared-home/home.nix
    ../shared-home/de/hyprland.nix
    ../shared-home/de/waybar.nix
    ../shared-home/stylix.nix
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.username = "jonas";
  home.homeDirectory = "/home/jonas";
  home.stateVersion = "25.05";

  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /home/jonas/jonas-nixos-config#laptop-nixos";
  };

  wayland.windowManager.hyprland.settings.monitor = "eDP-1,1920x1080,auto,1.0";

  wayland.windowManager.hyprland.settings.device = lib.mkForce {
        name = "g-tech-wireless-dongle-mouse";
        sensitivity = -0.5;
      };


  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
    ];
  };
}

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
    nrs = "sudo nixos-rebuild switch --flake /home/jonas/jonas-nixos-config#desktop-nixos";
  };

  wayland.windowManager.hyprland.settings.input.sensitivity = lib.mkForce (-0.8);
  wayland.windowManager.hyprland.settings.workspace = [
        "1, monitor:DP-1"
        "3, monitor:DP-1"
        "5, monitor:DP-1"
        "7, monitor:DP-1"
        "9, monitor:DP-1"

        "2, monitor:DP-3"
        "4, monitor:DP-3"
        "6, monitor:DP-3"
        "8, monitor:DP-3"
        "0, monitor:DP-3"
      ];

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
{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../shared-home/home.nix
    ../shared-home/hyprland/default.nix
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.username = "jonas";
  home.homeDirectory = "/home/jonas";
  home.stateVersion = "25.05";

  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /home/jonas/jonas-nixos-config#desktop-nixos";
  };

  wayland.windowManager.hyprland.settings.config.input.sensitivity = lib.mkForce (-0.8);
  wayland.windowManager.hyprland.settings.workspace_rule = [
    { workspace = "1"; monitor = "DP-1"; }
    { workspace = "3"; monitor = "DP-1"; }
    { workspace = "5"; monitor = "DP-1"; }
    { workspace = "7"; monitor = "DP-1"; }
    { workspace = "9"; monitor = "DP-1"; }

    { workspace = "2"; monitor = "DP-3"; }
    { workspace = "4"; monitor = "DP-3"; }
    { workspace = "6"; monitor = "DP-3"; }
    { workspace = "8"; monitor = "DP-3"; }
    { workspace = "0"; monitor = "DP-3"; }
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
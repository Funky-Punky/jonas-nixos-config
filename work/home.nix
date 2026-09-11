{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    # ../shared-home/home.nix
    # ../shared-home/hyprland/default.nix
    # inputs.spicetify-nix.homeManagerModules.default
  ];

  home.username = "z00546xm";
  home.homeDirectory = "/home/z00546xm";
  home.stateVersion = "25.05";

  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /home/jonas/jonas-nixos-config#work-nix";
  };

#   programs.spicetify =
#   let
#     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
#   in
#   {
#     enable = true;
#     enabledExtensions = with spicePkgs.extensions; [
#       adblock
#     ];
#   };
}
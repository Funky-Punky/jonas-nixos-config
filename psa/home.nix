{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../shared-home/home.nix
  ];

  home.username = lib.mkForce "ge65gom";
  home.homeDirectory = "/home/ge65gom";
  home.stateVersion = "25.05";

  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /home/ge65gom/jonas-nixos-config#psa-nixos";
  };
}

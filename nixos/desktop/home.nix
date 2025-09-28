{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../shared-home/home.nix
    ../shared-home/de/hyprland.nix
  ];

  home.username = "jonas";
  home.homeDirectory = "/home/jonas";
  home.stateVersion = "25.05";

  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /home/jonas/jonas-nixos-config/nixos#desktop-nixos";
  };
}

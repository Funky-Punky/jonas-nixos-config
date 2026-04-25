{
  inputs,
  pkgs,
  ...
}:
{

  #programs.hyprland = {
  #  enable = true;
  #  package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  #  xwayland.enable = true;
  #};

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
    withUWSM = true;
  };

  systemd.services.display-manager.path = [ pkgs.uwsm ];
  security.pam.services.hyprlock = {};

}
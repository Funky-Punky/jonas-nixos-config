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
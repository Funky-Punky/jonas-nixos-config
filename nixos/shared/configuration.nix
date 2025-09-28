{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    bat
  ];

  #programs.hyprland = {
  #  enable = true;
  #  package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  #  xwayland.enable = true;
  #};  
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };


}
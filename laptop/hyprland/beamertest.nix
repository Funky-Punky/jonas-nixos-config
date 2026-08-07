{
  pkgs,
  inputs,
  ...
}:
{
  wayland.windowManager.hyprland.settings.monitor = [
    {
      output = "desc:Samsung Electric Company SAMSUNG 0x01000E00";
    #   mode = "1920x1080";
      mirror = "eDP-1";
    #   position = "0x0";
    #   scale = 1;
    }
  ];
}
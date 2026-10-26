{
  pkgs,
  inputs,
  ...
}:
{
  wayland.windowManager.hyprland.settings.monitor = [
    { 
      # Beamer
      output = "desc:Samsung Electric Company SAMSUNG 0x01000E00";
      mirror = "eDP-1";
    }
    { 
      # Random Screen in Bib
      output = "desc:Lenovo Group Limited T27QD-40 VNAC5HTH";
      mode = "2560x1440";
      position = "-320x-1440";
      scale = 1;
    }
    { 
      # Third window screen at ZEI
      output = "desc:Acer Technologies B246WL T8NEE0038521";
      mode = "1920x1200";
      position = "0x-1200";
      scale = 1;
    }
    { 
      # right window screen at ZEI
      output = "desc:Dell Inc. DELL U2412M 0FFXD3CH20ES";
      mode = "1920x1200";
      position = "0x-1200";
      scale = 1;
    }
  ];
}

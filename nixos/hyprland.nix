{
  pkgs,
  ...
}:
{


  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "jonas";
      };
      default_session = initial_session;
    };
  };


  environment.systemPackages = with pkgs; [
    wofi
    rofi
    kitty
  ];
}

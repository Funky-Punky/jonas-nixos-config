{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./nvf.nix
  ];

  home.packages = with pkgs; [
    devenv
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use NixOs btw";
    };
    sessionVariables = {
      EDITOR = "vim";
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      #background_opacity = 0.8;
    };
  };

  programs.alacritty = {
    enable = true;
    # settings = {
    #   font = {
    #      normal = lib.mkForce { family = "nerd-fond-hack"; style = "Regular"; };
    #   };
    # };
  };

  programs.ranger = {
    enable = true;
    settings = {
      show_hidden = true;
    };
  };


  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  programs.git.enable = true;
  programs.git.userName = "Honas";
  programs.git.userEmail = "jonas.reinstaedtler@web.de";

}
{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  home.username = "jonas";
  home.homeDirectory = "/home/jonas";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use NixOs btw";
      nrs = "sudo nixos-rebuild switch -I nixos-config=/home/jonas/jonas-nixos-config/nixos/configuration.nix";
    };
  };

  programs.ranger = {
    enable = true;
    settings = {
      show_hidden = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Honas";
    userEmail = "jonas.reinstaedtler@web.de";
  };

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        options.shiftwidth = 2;
        #options.cursorlineopt = "both";

        visuals.nvim-cursorline.enable = true;

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        statusline.lualine.enable = true;
        autocomplete.nvim-cmp.enable = true;

        lsp = {
          enable = true;
        };

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
          rust.enable = true;
          rust.crates.enable = true;
        };
      };
    };
  };

  #programs.neovim = {
  #  enable = false;
  #  defaultEditor = true;
  #  viAlias = false;
  #  vimAlias = true;
  #  extraLuaConfig = ''
  #    vim.opt.number = true
  #    vim.opt.cursorline = true
  #    vim.opt.relativenumber = true
  #    vim.opt.shiftwidth = 2
  #    vim.cmd.colorscheme "tokyonight-storm"
  #  '';
  #  coc.enable = true;
  #  plugins = with pkgs.vimPlugins; [
  #    nvim-treesitter.withAllGrammars
  #    vim-nix
  #    tokyonight-nvim
  #  ];
  #};

}

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
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.theme.enable = true;
      vim.theme.name = "gruvbox";
      vim.theme.style = "dark";
      vim.statusline.lualine.enable = true;
      vim.lsp = {
        enable = true;
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

#  programs.nixvim = {
#    enable = true;
#
#    colorschemes.catppuccin.enable = true;
#    plugins.lualine.enable = true;
#  };
}

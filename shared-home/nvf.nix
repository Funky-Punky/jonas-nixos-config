{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        # useSystemClipboard = true;
        clipboard.providers.xclip.enable = true;
        undoFile.enable = true;

        lsp.formatOnSave = true;
        treesitter.enable = true;

        languages = {
          enableTreesitter = true;
          enableFormat = true;

          nix.enable = true;
          nix.lsp.enable = true;

          markdown.enable = true;
          markdown.lsp.enable = true;

          bash.enable = true;
          bash.lsp.enable = true;
        };

        autocomplete.nvim-cmp.enable = true;
        autopairs.nvim-autopairs.enable = true;

        telescope.enable = true;
        statusline.lualine.enable = true;
        git.enable = true;

        # theme = {
        #   enable = true;
        #   name = "catppuccin";
        #   style = "mocha";
        # };
      };
    };
  };
}
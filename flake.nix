{
  description = "Jonas' very own System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    nvf.url = "github:notashelf/nvf";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let 
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.desktop-nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.jonas = ./desktop/home.nix;
          }
        ];
      };

      nixosConfigurations.laptop-nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.jonas = ./laptop/home.nix;
          }
        ];
      };

      #homeConfigurations = {
      #  "jonas@nixos-desktop" = home-manager.lib.homeManagerConfiguration {
      #    pkgs = nixpkgs.legacyPackages."x86_64-linux";
      #    specialArgs = {inherit inputs;};
      #    modules = [
      #      ./home.nix
      #    ];
      #  };
      #};
    };
}

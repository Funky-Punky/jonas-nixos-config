{
  description = "Jonas' very own System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };
  };
}

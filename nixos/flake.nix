{
  description = "My flake-based NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
};

  outputs = { self, nixpkgs, unstable, flake-utils, stylix,home-manager, ... }: {

    homeConfigurations."mees" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          stylix.homeModules.stylix
          ./hosts/home.nix
        ];
      };
    
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/default.nix
        stylix.nixosModules.stylix
        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            })
          ];
        })
      ];
    };
};
}


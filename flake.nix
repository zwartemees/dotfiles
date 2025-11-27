{
  description = "My flake-based NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    ignis = {
      url = "github:ignis-sh/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elephant.url = "github:abenz1267/elephant";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ignis,... }:{
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = let
            system = "x86_64-linux";
        in {
            pkgs-unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
            };
            inherit ignis;
        };

        modules = [
          ./nixos/default.nix
          inputs.walker.nixosModules.default
        ];
      };
    };
}


{
  description = "My flake-based NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    ignis = {
      url = "github:ignis-sh/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
};

  outputs = { 
      self,
      nixpkgs,
      unstable, 
      flake-utils,
      ignis,
      ... }:{

    
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         
      modules = [
        ./hosts/default.nix
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
                    };
                })
            ignis.overlays.default
            ];
        }
      ];
    };
};
}


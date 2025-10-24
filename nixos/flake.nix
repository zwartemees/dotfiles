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

    elephant.url = "github:abenz1267/elephant";
    walker = {
        url = "github:abenz1267/walker";
        inputs.elephant.follows = "elephant";
    };
};

  outputs = inputs @ { 
      self,
      nixpkgs,
      unstable, 
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
       inputs.walker.nixosModules.default
 
      ];
    };
};
}


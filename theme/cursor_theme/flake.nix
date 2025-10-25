{
  description = "flake to build cursor theme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # or "nixpkgs#stable"
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux"; # or "aarch64-darwin", etc.
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.cursor = pkgs.stdenv.mkDerivation{
        pname = "bibata cursor builder";
        version = "1.0.0";

        src = ../cursor_theme;

        buildInputs = [
          pkgs.nodejs
          pkgs.python312
          pkgs.python312Packages.clickgen
          pkgs.cbmp
        ];

#        deps = import ./node-packages.nix { inherit pkgs; };

        buildPhase = ''
            ls
            npx cbmp -d 'svg/original' -o 'bitmaps/Bibata-Custom' -bc '#00FE00' -oc '#000000'
            ctgen build.toml -d 'bitmaps/Bibata-Custom' -n 'Bibata-Custom' -c 'Custom Bibata cursors'
        '';

        installPhase = ''
          echo "Installing icon theme..."
          mkdir -p $out/share/icons/pname
          cp -r * $out/share/icons/pname
        '';
      };
    };
}   


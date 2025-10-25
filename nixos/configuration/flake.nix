{
  description = "Nix flake for building and installing an icon theme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.cursor = pkgs.stdenv.mkDerivation rec {
        pname = "my themed bibata cursor";
        version = "1.0";

        src = pkgs.fetchgit {
          url = "https://github.com/ful1e5/Bibata_Cursor.git";
          rev = "abcdef1234567890abcdef1234567890abcdef12";
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };

        # Add any tools your build scripts need (optional)
        nativeBuildInputs = [
            pkgs.python312
            pkgs.python312Packages.clickgen
            pkgs.yarn
            pkgs.cbmp
        ];

        # Example if your repo has a build script
        buildPhase = ''
          pwd
          ls
          yarn install
          yarn generate
          npx cbmp -d 'svg/modern' -o 'bitmaps/Bibata-Hacker' -bc '#00FE00' -oc '#000000'
          ctgen build.toml -d 'bitmaps/Bibata-Hacker' -n 'Bibata-Hacker' -c 'Green and Black Bibata cursors.'
        '';

        installPhase = ''
          echo "Installing icon theme..."
          mkdir -p $out/share/icons/${pname}
          cp -r * $out/share/icons/${pname}/
        '';

        meta = with pkgs.lib; {
          description = "An example icon theme packaged with Nix";
          license = licenses.gpl3Plus;
          platforms = platforms.all;
        };
      };

      # So you can preview it easily with `nix build` or `nix run`
      apps.${system}.cursor = {
        type = "app";
        program = "${pkgs.bash}/bin/bash";
        args = [
          "-c"
          "echo 'Icons built at: ${self.packages.${system}.cursor}/share/icons/my-icon-theme'"
        ];
      };
    };
}

  

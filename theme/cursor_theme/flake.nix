{
  description = "Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
  };

  outputs = { self, nixpkgs, nixpkgs-python }:

    let
      system = "x86_64-linux";
      pythonVersion = "3.14";

      pkgs = import nixpkgs { inherit system; };

      myPython = nixpkgs-python.packages.${system}.${pythonVersion};

      colors = builtins.fromTOML (builtins.readFile ../colors.toml);

      # The vars we will pass to replaceVars
      metadataVars = {
        foreground  = colors.default.variables.foreground;
        outline     = colors.default.variables.outline;
        background  = colors.default.variables.background;
      };

      # Pre-generate metadata.toml in the store
      generatedMetadata =
        pkgs.replaceVars ./Bibata/metadata.toml.in metadataVars;

    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          myPython
          pkgs.librsvg
          pkgs.xcursorgen
        ];

        # In the shell we only COPY the already-generated file
        shellHook = ''
          echo "Using Python environment"
          python --version

          # Setup venv
          if [ ! -f ".venv/bin/activate" ]; then
            python -m venv .venv
          fi
          source .venv/bin/activate

          pip install accurse

          # Copy generated metadata.toml into workspace
          cp ${generatedMetadata} ./Bibata/metadata.toml
        '';
      };
    };
}


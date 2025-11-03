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
      colors = builtins.fromTOML (builtins.readFile ./../colors.toml);
      pkgs = import nixpkgs { inherit system; };
      myPython = nixpkgs-python.packages.${system}.${pythonVersion};
    in
    {
     devShells.${system}.default = pkgs.mkShell {
        packages = [
          myPython
          pkgs.librsvg
          pkgs.xcursorgen
        ];
             shellHook = ''
             ls
          python --version
          if [ ! -f ".venv/bin/activate" ]; then
            python -m venv .venv
          fi
          source .venv/bin/activate
          pip install accurse
          substituteAll ${./Bibata/metadata.toml.in} \
            ./Bibata/metadata.toml
'';
    foreground = colors.default.variables.foreground;
    outline = colors.default.variables.outline;
    background = colors.default.variables.background;
      };
    };
}

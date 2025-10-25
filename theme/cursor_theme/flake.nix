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
    
      accurse = pkgs.python3Packages.buildPythonPackage rec {
    pname = "accurse";
    version = "0.1.0";  # Replace with the desired version

    src = pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-ozkNbTrfdCfSk4EY1b4gJSKHlhcSlv2Kb1zTkDq6M0s=";
    };

    nativeBuildInputs = [ pkgs.python3Packages.hatchling ];
    pyproject = true; 
    propagatedBuildInputs = [ pkgs.python3Packages.lxml ];

      };
    in
    {
     devShells.${system}.default = pkgs.mkShell {
        packages = [
          myPython
          pkgs.librsvg
          pkgs.xcursorgen
        ];
             shellHook = ''
          python --version
if [ ! -f ".venv/bin/activate" ]; then
    python -m venv .venv
fi
source .venv/bin/activate
pip install accurse
'';
      };
    };
}

{
  description = "Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs}: 
    let
      system = "x86_64-linux";
      colors = builtins.fromTOML (builtins.readFile ./themes/onedark.toml);
      pkgs = import nixpkgs { inherit system; };
    in
    {
     devShells.${system}.default = pkgs.mkShell {

        shellHook = ''
        rm colors.toml
          substituteAll ${./template.toml} \
            ./colors.toml
        '';
        primary       = colors.primary;
        secondary     = colors.secondary;
        tertiary      = colors.tertiary;
        muted_primary       = colors.muted_primary;
        muted_secondary     = colors.muted_secondary;
        muted_tertiary      = colors.muted_tertiary;
        warning       = colors.warning;
        error         = colors.error;
        info          = colors.info;
        text          = colors.text;
        subtext       = colors.subtext;
        highlight     = colors.highlight;
        succes        = colors.succes;
        hover         = colors.hover;
        muted_background    = colors.muted_background;
        background    = colors.background;
        foreground = colors.foreground;
        muted_foreground = colors.foreground;

# Cursor
cursor_foreground   = colors.cursor_foreground;
cursor_background   = colors.cursor_background;
cursor_outline      = colors.cursor_outline;
    };
    };
}

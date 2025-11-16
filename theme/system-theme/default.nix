{ schemeName ? "onedark" }:

let
  system = "x86_64-linux";
  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
  }) { inherit system; };

  colors = builtins.fromTOML (builtins.readFile (./themes + "/${schemeName}.toml"));
in
pkgs.mkShell {
  shellHook = ''
    echo "Using theme: ${schemeName}"
    rm -f colors.toml
    substituteAll ${./template.toml} ./colors.toml
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
}

{ schemeName ? "onedark" }:

let
  system = "x86_64-linux";

  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
  }) { inherit system; };

  colors = builtins.fromTOML (builtins.readFile (./themes + "/${schemeName}.toml"));

  # replaceVars wants an attribute set of strings
  colorVars = {
    primary            = colors.primary;
    secondary          = colors.secondary;
    tertiary           = colors.tertiary;

    muted_primary      = colors.muted_primary;
    muted_secondary    = colors.muted_secondary;
    muted_tertiary     = colors.muted_tertiary;

    warning            = colors.warning;
    error              = colors.error;
    info               = colors.info;

    text               = colors.text;
    inverse_text       = colors.inverse_text;
    subtext            = colors.subtext;
    highlight          = colors.highlight;
    success             = colors.success;

    muted_background   = colors.muted_background;
    background         = colors.background;
    foreground         = colors.foreground;
    muted_foreground   = colors.muted_foreground;

    cursor_foreground  = colors.cursor_foreground;
    cursor_background  = colors.cursor_background;
    cursor_outline     = colors.cursor_outline;
  };

  # Use replaceVars to generate a file in /nix/store
  generatedTemplate =
    pkgs.replaceVars ./template.toml colorVars;

in
pkgs.mkShell {
  shellHook = ''
    echo "Using theme: ${schemeName}"
    # Write the generated file to the working directory
    cp ${generatedTemplate} ./colors.toml
  '';
}


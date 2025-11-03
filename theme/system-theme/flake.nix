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
        color_primary       = colors.color_primary;
        color_secondary     = colors.color_secondary;
        color_tertiary      = colors.color_tertiary;
        color_warning       = colors.color_warning;
        color_error         = colors.color_error;
        color_info          = colors.color_info;
        color_muted         = colors.color_muted;
        color_text          = colors.color_text;
        color_subtext       = colors.color_subtext;
        color_background    = colors.color_background;
        color_popup         = colors.color_popup;
        color_surface       = colors.color_surface;
        color_highlight     = colors.color_highlight;
        color_shadow        = colors.color_shadow;

# Cursor
cursor_foreground   = colors.cursor_foreground;
cursor_background   = colors.cursor_background;
cursor_outline      = colors.cursor_outline;

# Accents
accent_warning      = colors.accent_warning;
accent_info         = colors.accent_info;
accent_link         = colors.accent_link;
accent_success      = colors.accent_success;
accent_hover        = colors.accent_hover;
accent_error        = colors.accent_error;
accent_light        = colors.accent_light;

# Foreground layers
fg_primary          = colors.fg_primary;
fg_secondary        = colors.fg_secondary;
fg_muted            = colors.fg_muted;
fg_overlay_strong   = colors.fg_overlay_strong;
fg_overlay_medium   = colors.fg_overlay_medium;
fg_overlay_weak     = colors.fg_overlay_weak;

# Background layers
bg_high             = colors.bg_high;
bg_medium           = colors.bg_medium;
bg_low              = colors.bg_low;
bg_subtle           = colors.bg_subtle;
bg_deep             = colors.bg_deep;
     };
    };
}

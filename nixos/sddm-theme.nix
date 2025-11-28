{ pkgs, ... }:

let
  colors = builtins.fromTOML (builtins.readFile ./../theme/colors.toml);
  colorVars = {
    accent_light = colors.default.variables.accent_light;
    accent_warning = colors.default.variables.accent_warning;
    accent_secondary = colors.default.variables.accent_secondary;
    accent_primary = colors.default.variables.accent_primary;
    error = colors.default.variables.error;
    error_alt = colors.default.variables.error_alt;
    warning = colors.default.variables.warning;
    attention = colors.default.variables.attention;
    success = colors.default.variables.success;
    info = colors.default.variables.info;
    accent_info = colors.default.variables.accent_info;
    accent_hover = colors.default.variables.accent_hover;
    link = colors.default.variables.link;
    accent_alt = colors.default.variables.accent_alt;
    fg_primary = colors.default.variables.fg_primary;
    fg_secondary = colors.default.variables.fg_secondary;
    fg_muted = colors.default.variables.fg_muted;
    fg_overlay_strong = colors.default.variables.fg_overlay_strong;
    fg_overlay_medium = colors.default.variables.fg_overlay_medium;
    fg_overlay_weak = colors.default.variables.fg_overlay_weak;
    bg_surface_high = colors.default.variables.bg_surface_high;
    bg_surface_medium = colors.default.variables.bg_surface_medium;
    bg_surface_low = colors.default.variables.bg_surface_low;
    bg_base = colors.default.variables.bg_base;
    bg_subtle = colors.default.variables.bg_subtle;
    bg_deep = colors.default.variables.bg_deep;
  };
  # Pure: no warnings, no substitution builder spam
  themeConf = pkgs.replaceVars
    ./../theme/sddm/theme/theme.conf.in
    colorVars;
in
pkgs.stdenv.mkDerivation {
  pname = "custom-sddm-theme";
  version = "1.0";

  src = ./../theme/sddm/theme;

  installPhase = ''
    rm -rf $out/share/sddm/themes/custom-sddm-theme
    mkdir -p $out/share/sddm/themes/custom-sddm-theme
    cp -r * $out/share/sddm/themes/custom-sddm-theme
    cp ${themeConf} $out/share/sddm/themes/custom-sddm-theme/theme.conf
  '';

  meta = {
    description = "importing custom SDDM theme";
    platforms = pkgs.lib.platforms.linux;
  };
}


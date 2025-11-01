{ pkgs, ... }:

let
    colors = builtins.fromTOML (builtins.readFile ./../theme/colors.toml);
    themeConf = pkgs.substituteAll {
        src = ./../theme/sddm/theme/theme.conf.in;
        inherit (colors.sddm)
        accent_primary accent_secondary accent_light accent_hover accent_alt
        accent_warning accent_info
        error error_alt warning attention success info link
        fg_primary fg_secondary fg_muted fg_overlay_strong fg_overlay_medium fg_overlay_weak
        bg_surface_high bg_surface_medium bg_surface_low bg_base bg_subtle bg_deep;
  };
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


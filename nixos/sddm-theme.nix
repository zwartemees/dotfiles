{ pkgs, ... }:

let
    colors = builtins.fromTOML (builtins.readFile ./../theme/colors.toml);
in

    pkgs.stdenv.mkDerivation {
        pname = "custom-sddm-theme";
        version = "1.0";

        src = ./../theme/sddm/theme;

        installPhase = ''
            rm -rf $out/share/sddm/themes/custom-sddm-theme
            mkdir -p $out/share/sddm/themes/custom-sddm-theme
            cp -r * $out/share/sddm/themes/custom-sddm-theme
              substitute theme.conf.in $out/share/sddm/themes/custom-sddm-theme/theme.conf \
                --subst-var-by rosewater "${colors.rosewater}" \
        '';

        meta = {
            description = "importing custom SDDM theme";
            platforms = pkgs.lib.platforms.linux;
        };
    }


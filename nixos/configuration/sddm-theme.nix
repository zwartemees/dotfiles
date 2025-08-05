{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "custom-sddm-theme";
  version = "1.0";

  src = ./../../sddm/theme;

  installPhase = ''
    rm -rf $out/share/sddm/themes/custom-sddm-theme
    mkdir -p $out/share/sddm/themes/custom-sddm-theme
    cp -r * $out/share/sddm/themes/custom-sddm-theme
  '';

  meta = {
    description = "importing custom SDDM theme";
    platforms = pkgs.lib.platforms.linux;
};
}

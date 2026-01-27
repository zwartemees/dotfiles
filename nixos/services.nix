{pkgs,...}:
let
    custom-sddm-theme = import ./sddm-theme.nix { inherit pkgs;};
in
{
  services.flatpak.enable = true;
  services.upower.enable=true;
  services.hypridle.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.sddm = {
  	enable = true;
	wayland.enable = true;
    theme = "${custom-sddm-theme}/share/sddm/themes/custom-sddm-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = [
        custom-sddm-theme
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  services.chrony ={
      enable = true;
#      enableNTS = true;
#      initstepslew.enabled = true;
      servers = [
      "time.google.com"
      "time.cloudflare.com"
      "pool.ntp.org"
      ];
   };
  environment.systemPackages =[
    custom-sddm-theme
  ];
}

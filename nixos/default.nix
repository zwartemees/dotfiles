{pkgs,config, pkgs-unstable,ignis,... }:
let
    custom-sddm-theme = import ./sddm-theme.nix { inherit pkgs;};
in
{

  imports =
    [
        ./hardware-configuration.nix
        ./packages.nix
    ];
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.sandbox = "relaxed";
  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "adw";
        cursor-theme = "Bibata";
        icon-theme = "Flatery";
      };
    }
  ];


    boot = {
        consoleLogLevel = 0;
        initrd.verbose = false;
	    plymouth.theme = "spinner";
        plymouth.enable = true;
        kernelParams = [ "quiet" "loglevel=3" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail"];
        loader = {
            timeout = 0;
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
       };
     };

    services.displayManager.sddm = {
        theme = "custom-sddm-theme";
        package = pkgs.kdePackages.sddm;
        extraPackages = with pkgs; [
            custom-sddm-theme
        ];
 	    enable = true;
	    wayland.enable = true;
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
      
      servers = [
      "time.google.com"
      "time.cloudflare.com"
      "pool.ntp.org"
      ];
 };
  programs.walker.enable = true;
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  services.hypridle.enable = true;
  services.flatpak.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # # Set your time zone.
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_GB.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB
  }];
  users.users.mees = {
    isNormalUser = true;
    description = "mees";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
services.upower.enable=true;
nixpkgs.config.allowUnfree = true;
environment.systemPackages =[
      (ignis.packages.${pkgs.system}.default.override {
        enableAudioService = true;  # enable audio support
        useDartSass = true;
        enableNetworkService = true;      # installs networkmanager
        enableRecorderService = false;    # skips gpu-screen-recorder
        enableBluetoothService = true;    # installs gnome-bluetooth
        useGrassSass = false;  # enable Dart Sass
        })
        pkgs.gobatmon
        pkgs.xsettingsd
        pkgs.matugen
        pkgs.zip
        pkgs.jetbrains.jdk
        pkgs.jetbrains.idea-ultimate
        custom-sddm-theme
        pkgs.swww
        pkgs.wpaperd
        pkgs.libnotify
        pkgs-unstable.typtea
        pkgs-unstable.nmgui
        pkgs.networkmanager_dmenu
        pkgs.networkmanagerapplet
        pkgs-unstable.bzmenu
        pkgs.mako
        pkgs.cmake
	pkgs.gcc
        pkgs.hyprlock
        pkgs.upower-notify
        pkgs.wireguard-tools
        pkgs.pyright
        pkgs.nautilus
        pkgs.docker-language-server
];
programs.fish.enable = true;
system.stateVersion = "25.05"; # Did you read the comment?
}

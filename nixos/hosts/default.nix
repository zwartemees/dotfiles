{ config, pkgs, ... }:
let
    custom-sddm-theme = import ./../configuration/sddm-theme.nix { inherit pkgs;};
in
{

  imports =
    [
        ./../hardware-configuration.nix
        ./../configuration/packages.nix
    ];
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.sandbox = "relaxed";
  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "adw-gtk3-dark";
#        icon-theme = "Flat-Remix-Red-Dark";
#        font-name = "Noto Sans Medium 11";
#        document-font-name = "Noto Sans Medium 11";
#        monospace-font-name = "Noto Sans Mono Medium 11";
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

  users.users.mees = {
    isNormalUser = true;
    description = "mees";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
services.upower.enable=true;
nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
        zip
        jetbrains.jdk
        jetbrains.idea-ultimate
        custom-sddm-theme
        swww
        wpaperd
        libnotify
        networkmanager_dmenu
        networkmanagerapplet
        unstable.bzmenu
        mako
        hyprlock
        ignis
        upower-notify
        unstable.spotube
        wireguard-tools
        pyright
        nautilus
        docker-language-server
];
programs.fish.enable = true;
system.stateVersion = "25.05"; # Did you read the comment?
}

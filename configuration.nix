{ config, pkgs, ... }:
let
    unstable = import (builtins.fetchTarball {
        url = "https://github.com/NixOs/nixpkgs/archive/nixos-unstable.tar.gz";
    }) {
        config = {allowUnfree = true;}; 
    };
        custom-sddm-theme = import /etc/nixos/configuration/sddm-theme.nix { inherit pkgs;};
in
{

  imports =
    [
       /etc/nixos/hardware-configuration.nix
	    ./configuration/packages.nix
#       ./configuration/laptop.nix
    ];

# Bootloader.
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
  services.hypridle.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mees = {
    isNormalUser = true;
    description = "mees";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
environment.systemPackages = with pkgs; [
        custom-sddm-theme
        swww
        libnotify
       # fish
        networkmanager_dmenu
        networkmanagerapplet
        unstable.bzmenu
        mako
        hyprlock
];

programs.fish.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
 system.stateVersion = "25.05"; # Did you read the comment?

}

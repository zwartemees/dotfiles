 {pkgs, ...}:
 {
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  }; 
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # # Set your time zone.
  
  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.sandbox = "relaxed";
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_GB.UTF-8";
  swapDevices = [{
    device = "/swapfile";
    size = 160 * 1024; # 16GB
  }];
  
  users.users.mees = {
    isNormalUser = true;
    description = "mees";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
	plymouth.theme = "spinner";
    plymouth.enable = true;
    kernelParams = [ 
    "quiet"
    "loglevel=3"
    "splash"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "boot.shell_on_fail"
    ];
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      };
    };
 }

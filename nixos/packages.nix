{config, pkgs, pkgs-unstable, ignis, ...}:
{
    programs = {
      walker.enable = true;
      niri.enable = true;
      xwayland.enable = true;
      fish.enable = true;
	  dconf.profiles.user.databases = [{ 
        settings."org/gnome/desktop/interface" = {
            gtk-theme = "adw";
            cursor-theme = "Bibata";
            icon-theme = "Flatery";
        };
      }];
      firefox.enable = true;  
    };

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      
    # gui apps
    ghostty
	nautilus
    networkmanagerapplet
    jetbrains.idea-ultimate
 
    #cli tools
    jetbrains.jdk
    gnumake
    zoxide
    dotter
	git
	gh
    fish
    ripgrep
    fd
    neovim
	unzip
    zip
    
    #lsps
	lua-language-server
  	fish-lsp
  	nixd
    docker-language-server
    python313Packages.python-lsp-server
	
    #system tools
    pkgs-unstable.bzmenu
    xsettingsd
    gobatmon
    libnotify
    swww
    wpaperd
    mako
    cmake
    gcc
	wireguard-tools
    hyprlock
    playerctl
    xwayland-satellite
    (ignis.packages.${pkgs.system}.default.override {
        enableAudioService = true;  # enable audio support
        useDartSass = true;
        enableNetworkService = true;      # installs networkmanager
        enableRecorderService = false;    # skips gpu-screen-recorder
        enableBluetoothService = true;    # installs gnome-bluetooth
        useGrassSass = false;  # enable Dart Sass
        })
    ];
}

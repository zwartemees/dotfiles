{config, pkgs, pkgs-unstable, ignis, ...}:
{
    programs.walker.enable = true;
    programs.niri.enable = true;
    programs.xwayland.enable = true;
    programs.fish.enable = true;
	programs.dconf.profiles.user.databases = [{ 
        settings."org/gnome/desktop/interface" = {
            gtk-theme = "adw";
            cursor-theme = "Bibata";
            icon-theme = "Flatery";
        };
    }];

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      
    # gui apps
    ghostty
	firefox
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

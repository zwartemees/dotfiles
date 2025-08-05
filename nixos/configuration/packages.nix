{config, pkgs, ...}:

{
	environment.systemPackages = with pkgs; [

    ghostty
	firefox
	fuzzel
    xwayland-satellite
	#cli tools
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
    #lsps
	lua-language-server
  	fish-lsp
  	nixd
	nerd-fonts.fira-code
	];
}

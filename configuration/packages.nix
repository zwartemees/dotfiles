{config, pkgs, ...}:

{
	environment.systemPackages = with pkgs; [
	
	ghostty
	firefox
	fuzzel

	#cli tools
	zoxide
    	dotter
	git
	gh
    	fish
    	ripgrep
    	fd
    	neovim

	#lsps
	lua-language-server
  	fish-lsp
  	nixd
  	
	nerd-fonts.fira-code
	];
}

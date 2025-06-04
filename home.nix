{ config, pkgs, ... }:

{
  home.username = "mees";
  home.homeDirectory = "/home/mees";
  home.stateVersion = "25.05";
   home.packages = [
    pkgs.neovim
    pkgs.git
    pkgs.gh
# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.file = {
    ".gitconfig".source = git/gitconfig;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}

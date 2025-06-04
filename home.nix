{ config, pkgs, lib, ... }:

{
  home.username = "mees";
  home.homeDirectory = "/home/mees";
  home.stateVersion = "25.05";
   home.packages = [
    pkgs.neovim
    pkgs.git
    pkgs.gh
    pkgs.fish

# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.file = {
    ".gitconfig".source = git/gitconfig;
    ".config/fish".source = ./fish;
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.activation.setFishShell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  echo "Running shell script to set fish as default shell..."
  bash ${./scripts/setShell.sh}
'';


  programs.home-manager.enable = true;
}

{pkgs,config, pkgs-unstable,ignis,... }:
{

  imports =
    [
        /etc/nixos/hardware-configuration.nix
        ./packages.nix
        ./settings.nix
        ./services.nix
    ];
}

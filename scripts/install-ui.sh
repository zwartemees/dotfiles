#! /bin/bash

nix-env --switch-profile /nix/var/nix/profiles/default/

nix-env -if ~/dotfiles/packages/ui-packages.nix

nix-env --switch-profile $HOME/.local/state/nix/profiles/profile


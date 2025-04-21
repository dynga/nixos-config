#!/usr/bin/env fish

sudo nix flake update &&
    sudo nixos-rebuild build --flake . &&
    git commit -am "checkpoint $(git rev-list --count HEAD) (update)" &&
    git push &&
    sudo nixos-rebuild switch --flake

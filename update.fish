#!/usr/bin/env fish

sudo nix flake update &&
    sudo nixos-rebuild build --flake . &| nom &&
    git commit -am "checkpoint $(git rev-list --count HEAD) (update)" &&
    git push &&
    sudo nixos-rebuild switch --flake . &| nom

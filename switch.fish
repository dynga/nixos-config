#!/usr/bin/env fish

git commit -am "checkpoint $(git rev-list --count HEAD)"
sudo nixos-rebuild switch --flake . &| nom

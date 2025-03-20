#!/usr/bin/env fish

git commit -am "checkpoint $(git rev-list --count HEAD) (switch)"
git push
sudo nixos-rebuild switch --flake . &| nom

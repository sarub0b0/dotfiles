#!/bin/zsh

set -eu

home-manager switch --impure
home-manager expire-generations -3days
nix-collect-garbage -d

nvim --headless -c "Lazy! sync" -c "MasonUpdate" +qa

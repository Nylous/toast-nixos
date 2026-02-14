# toast-nixos
Sync repo for NixOS config tests
sudo nixos-rebuild switch --no-flake -I nixos-config=./configuration.nix
nixos-rebuild switch --flake . --upgrade --sudo --impure

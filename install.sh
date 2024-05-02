nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko lib/disko.nix
mkdir -p /mnt/nix/persist/etc/nixos/
cp -r * /mnt/nix/persist/etc/nixos/
nixos-install --no-root-password --flake .#oxygen --root /mnt




# NixOS configurations

A dead simple NixOS configuration using Nix [Flakes](https://www.tweag.io/blog/2020-05-25-flakes/).

## Partition setup

```
# parted /dev/sda -- mklabel gpt
# parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
# parted /dev/sda -- set 1 esp on
# parted /dev/sda -- mkpart primary 512MiB 100%
```

## Formatting

```
# mkfs.btrfs -L nixos /dev/sda2
# mount /dev/sda2 /mnt -o compress=zstd
# btrfs subvolume create /mnt/root
# btrfs subvolume create /mnt/home
# umount /mnt
# mount /dev/sda2 /mnt -o subvol=root,compress=zstd
# mkdir	-p /mnt/{boot,home}
# mount /dev/sda2 /mnt/home -o subvol=home,compress=zstd
# btrfs subvolume create /mnt/var
# btrfs subvolume create /mnt/tmp
# btrfs subvolume create /mnt/swap
# mkfs.fat -F32 -n esp /dev/sda1
# mount /dev/sda1 /mnt/boot
# truncate -s 0 /mnt/swap/swap.0
# chattr +C /mnt/swap/swap.0
# btrfs property set /mnt/swap/swap.0 compression none
# dd bs=1M count=16384 status=progress if=/dev/zero of=/mnt/swap/swap.0
# chmod 600 /mnt/swap/swap.0
# mkswap -L swap /mnt/swap/swap.0
# swapon /mnt/swap/swap.0
```

## Install

Install `nixFlakes` by e.g. `nix-shell -p nixFlakes`.
Then run
```
sudo nixos-rebuild switch --flake .#heisenberg
```

If it fails, bootstrap the machine by copying `hosts/heisenberg` to `/etc/nixos` and renaming `default.nix` to `configuration.nix`.

# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, inputs, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.disko.nixosModules.default
    ./../../system
    ./../../home
    (import ./../../lib/disko.nix { device = "/dev/nvme0n1"; })
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  time.timeZone = "Asia/Dhaka";

  users.users."xenoxanite" = {
    isNormalUser = true;
    initialPassword = "rainy";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ firefox fd fzf eza ];
  };

  programs = {
    hyprland.enable = true;
    nano.enable = false;
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "JetBrainsMono" "Hack" ]; }) ];

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performancee";
  };
  environment.sessionVariables = { TZ = "${config.time.timeZone}"; };
  services.udev.extraRules = ''
    KERNEL=="card0", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"
  '';
  services.getty.autologinUser = "xenoxanite";

  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.trusted-users = [ "xenoxanite" "root" ];
  programs.fuse.userAllowOther = true;
  systemd.tmpfiles.rules = [ "/persist 1777 root xenoxanite" ];
}

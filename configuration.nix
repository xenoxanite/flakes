# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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


  networking.hostName = "oxygen"; 
  time.timeZone = "Asia/Dhaka";

  users.users."xenoxanite" = {
    isNormalUser = true;
    initialPassword = "rainy";
    extraGroups = [ "wheel" ];  
    packages = with pkgs; [
      firefox
      gh
      foot
      kitty
    ];
  };

  programs = {
  	git.enable = true;
    waybar.enable = true;
    neovim.enable = true;
    hyprland.enable = true;
    nano.enable = false;
  };



  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


users.defaultUserShell = pkgs.zsh;
environment.shells = with pkgs; [ zsh ];
programs.zsh = {
	enable = true;
	enableCompletion = true;
	autosuggestions.enable = true;
	syntaxHighlighting.enable = true;
	loginShellInit = ''
        	if [[ "$(tty)" == "/dev/tty1" ]] then
        		Hyprland 
	        fi
      ''; 
};


fonts.packages = with pkgs; [
 (nerdfonts.override {
        fonts = [ "JetBrainsMono" "Hack" ];
      })
];


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



  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };

  nix.settings.trusted-users = ["xenoxanite" "root"];
  programs.fuse.userAllowOther = true;
systemd.tmpfiles.rules = [
	"/persist 1777 root xenoxanite"
];
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "xenoxanite" = import ./home.nix;
    };
  };
}


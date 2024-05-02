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
    (import ./../../lib/disko.nix)
  ];
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };

  time.timeZone = "Asia/Dhaka";

  users.users."xenoxanite" = {
    isNormalUser = true;
    initialPassword = "rainy";
    extraGroups = [ "wheel" ];
  };
  programs = {
    nano.enable = false;
    zsh.enable = true;
    fuse.userAllowOther = true;
  };
  users.defaultUserShell = pkgs.zsh;
  environment = {
    shells = with pkgs; [ zsh ];
    sessionVariables = { TZ = "${config.time.timeZone}"; };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performancee";
  };
  services = { gvfs.enable = true; };

  system.stateVersion = "23.11";
}

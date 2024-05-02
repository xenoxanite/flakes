{ config, pkgs, lib, ... }: {
  options.programs.discord = { enable = lib.mkEnableOption "Discord"; };
  imports = [ ./theme.nix ];
  config = lib.mkIf config.programs.discord.enable {
    home.packages = [ pkgs.discord ];
  };
}

{ pkgs, ... }: {
  imports = [ ./dir.nix ];
  home.packages = with pkgs; [ xdg-utils ];
}

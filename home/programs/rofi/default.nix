{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  home.file = {
    ".config/rofi/off.sh".source = ./off.sh;
    ".config/rofi/launcher.rasi".source = ./launcher.rasi;
  };
}

{ pkgs, ... }:
let ui = import ./ui.nix { };
in {
  home-manager.users.xenoxanite = {
    fonts.fontconfig.enable = true;
    home = {
      packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        fantasque-sans-mono
        (catppuccin-gtk.override {
          size = "compact";
          accents = [ "green" ];
          variant = "mocha";
          tweaks = [ "normal" ];
        })
        jetbrains-mono
      ];
      pointerCursor = {
        package = pkgs.cattpuccin-dark-cursor;
        name = "Catppuccin-Latte-Dark";
        size = 15;
      };
      sessionVariables = {
        GTK_USE_PORTAL = 0;
        GTK_THEME = ui.colors.gtk-theme;
      };
    };
    gtk = {
      enable = true;
      theme.name = ui.colors.gtk-theme;
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      font = {
        name = ui.nerd-font;
        size = 12;
      };
      cursorTheme = { name = "Catppuccin-Latte-Dark"; };
    };
  };
}

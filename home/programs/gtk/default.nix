{ pkgs, ... }: {
  home.sessionVariables = {
    GTK_THEME = "Nordic";
  };
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Green-Cursors";
    package = pkgs.catppuccin-cursors.mochaGreen;
    size = 16;
    gtk.enable = true;
  };
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Green-Cursors";
      package = pkgs.catppuccin-cursors.mochaGreen;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-cursor-theme-name = "Catppuccin-Mocha-Green-Cursors";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
    gtk4.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-cursor-theme-name = "Catppuccin-Mocha-Green-Cursors";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}

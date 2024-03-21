{ pkgs, ... }: {
  imports = [ ./config.nix ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
  };

  home.packages = with pkgs; [
    wayland
    wf-recorder
    qt6.qtwayland
    swww
    wf-recorder
    waypaper
    wl-clipboard
    cliphist
    swaylock
    grimblast
  ];
  systemd.user.targets.hyprland-session.Unit.Wants =
    [ "xdg-desktop-autostart.target" ];
  home = {
    sessionVariables = {
      QT_SCALE_FACTOR = "1";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      CLUTTER_BACKEND = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}

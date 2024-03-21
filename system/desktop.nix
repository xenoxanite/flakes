{ pkgs, inputs, ... }: {
  programs = { dconf.enable = true; };

  environment = {
    systemPackages = with pkgs; [
      libnotify
      cinnamon.nemo
      xdg-utils
      pamixer
      playerctl
      pulsemixer
      imagemagick
      imv
      mpv
      bat
      yt-dlp
      chromium
      telegram-desktop
    ];
    variables.NIXOS_OZONE_WL = "1";
  };

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = [ pkgs.gnome.gnome-session ];
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };

  hardware.pulseaudio.enable = false;
  services = {
    dbus.packages = [ pkgs.gcr ];
    getty.autologinUser = "xenoxanite";
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  programs.hyprland.enable = true;
  security.rtkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}

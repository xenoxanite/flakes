{ pkgs, ... }:
let ui = import ./../../theme/ui.nix { };
in with ui; {
  home.packages = [ pkgs.libnotify ];
  services.mako = {
    enable = true;
    font = "${nerd-font} 10";
    anchor = "top-right";
    textColor = "#${foreground-color}";
    backgroundColor = "#${colors.background}";
    borderColor = "#${border-color}";
    borderRadius = border-radius;
    borderSize = border-size;
    defaultTimeout = 5000;
    height = 100;
    width = 300;
    padding = "20";
    icons = true;
    maxVisible = 6;
    sort = "-time";
    markup = true;
    layer = "overlay";
    actions = true;

    extraConfig = ''
      max-history=100
      max-icon-size=48
      icon-location=left
      history=1

      [urgency=high]
      border-color=#${colors.red}
    '';
  };
}

{
  services.mako = {
    enable = true;
    font = "JetBrainsMono Nerd Font 12";
    width = 256;
    height = 500;
    margin = "10";
    padding = "5";
    borderSize = 3;
    borderRadius = 0;
    backgroundColor = "#101419";
    borderColor = "#8cc1ff";
    progressColor = "over #94f7c5";
    textColor = "#b6beca";
    defaultTimeout = 5000;
    extraConfig = ''
      text-alignment=center
      [urgency=high]
      border-color=#fc7b81
    '';
  };
}

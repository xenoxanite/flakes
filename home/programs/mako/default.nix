{
  services.mako = {
    enable = true;
    font = "JetBrainsMono Nerd Font 12";
    width = 256;
    height = 500;
    margin = "10";
    padding = "5";
    borderSize = 3;
    borderRadius = 3;
    backgroundColor = "#1E1D2F";
    borderColor = "#96CDFB";
    progressColor = "over #302D41";
    textColor = "#D9E0EE";
    defaultTimeout = 5000;
    extraConfig = ''
      text-alignment=center
      [urgency=high]
      border-color=#F8BD96
    '';
  };
}

{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
      truecolor = true;
      vim_keys = true;
      force_tty = false;
      rounded_corners = false;
      show_battery = false;
      check_temp = true;
      show_uptime = true;
      cpu_bottom = true;
    };
  };
}

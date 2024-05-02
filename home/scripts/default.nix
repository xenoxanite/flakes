{ pkgs, ... }:
let
  load-wallpaper = pkgs.writeShellScriptBin "load-wallpaper" ''
    xwallpaper --stretch $(grep -o "'/[^']*'" <<< cat $HOME/.fehbg | cut -d "'" -f 2)
    wal -i $(grep -o "'/[^']*'" <<< cat $HOME/.fehbg | cut -d "'" -f 2)
    xdotool key super+F5
  '';
  clipboard_dmenu = pkgs.writeShellScriptBin "clipboard_dmenu" ''
    greenclip print | sed "/^$/d" | rofi -dmenu -theme ~/.config/rofi/launcher.rasi | xargs -r -d"\n" -I "{}" greenclip print "{}"
  '';

  screenshot_dmenu = pkgs.writeShellScriptBin "screenshot_dmenu" ''
    ${builtins.readFile (./screenshot_dmenu)}
  '';

  schedule-power-off = pkgs.writeShellScriptBin "schedule-power-off" ''
    shutdown -P 22:00 &
    time=$(date '+%H')
    if [ "$time" -gt 21 ] || [ "$time" -lt 5 ]; then
      shutdown now
    fi
  '';
  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    #!/bin/sh

    wallpaper_daemon="wal -i"
    if [ -f "$1" ]; then
      xwallpaper --stretch $1 
      $wallpaper_daemon $1
      reload-wm
      betterlockscreen -u $wallpaper_location &
    else
      wallpaper_location=$(find $HOME/pix/wallpapers -name "*.png" -o -name "*.jpg" -o -name "*.gif" | nsxiv -tio)
      if [ -f "$wallpaper_location" ]; then
        xwallpaper --stretch $wallpaper_location 
        $wallpaper_daemon $wallpaper_location
        reload-wm
        betterlockscreen -u $wallpaper_location &
      fi
    fi
  '';
  reload-wm = pkgs.writeShellScriptBin "reload-wm" ''
    ln -sf ~/.cache/wal/colors.Xresources ~/.Xresources &                                        
    ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc &                                       
    xdotool key super+F5
    pkill dwmblocks && dwmblocks &
    pkill dunst && dunst &
    reload-discord &
    pywalfox update
  '';
in {
  home = {
    packages = [
      load-wallpaper
      # schedule-power-off
      clipboard_dmenu
      screenshot_dmenu
      set-wallpaper
      reload-wm
    ];
  };
}

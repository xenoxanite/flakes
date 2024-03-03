{ pkgs, ... }:
let
  myswaylock = pkgs.writeShellScriptBin "myswaylock" ''
    ${pkgs.swaylock-effects}/bin/swaylock  \
           --screenshots \
           --clock \
           --indicator \
           --indicator-radius 100 \
           --indicator-thickness 7 \
           --effect-blur 7x5 \
           --effect-vignette 0.5:0.5 \
           --ring-color 3b4252 \
           --key-hl-color 880033 \
           --line-color 00000000 \
           --inside-color 00000088 \
           --separator-color 00000000 \
           --grace 2 \
           --fade-in 0.3
  '';
  launch_waybar = pkgs.writeShellScriptBin "launch_waybar" ''
    killall .waybar-wrapped
    ${pkgs.waybar}/bin/waybar > /dev/null 2>&1 &
  '';
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    RUNNING_COUNT=$(${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg "state: \"running\"" -c || true)
    if [ -z "$RUNNING_COUNT" ]; then
      RUNNING_COUNT=0
    fi
    if [ $RUNNING_COUNT -le 2 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
  services.swayidle = {
    enable = true;
    events = [{
      event = "before-sleep";
      command = "${myswaylock}/bin/myswaylock";
    }];
    timeouts = [{
      timeout = 300;
      command = suspendScript.outPath;
    }];
  };
  wayland.windowManager.hyprland = {
    extraConfig = ''
      $mainMod = SUPER 
      monitor=,preferred,auto,1 

      input {
        kb_layout = us
        follow_mouse = 2 
        sensitivity = 0 
      }

      general {
        gaps_in = 3
        gaps_out = 5
        border_size = 3
        col.active_border = rgb(ffc0cb)
        col.inactive_border = rgb(2e3440)
        layout = dwindle # master|dwindle 
      }

      dwindle {
        no_gaps_when_only = false
        force_split = 0 
        special_scale_factor = 0.8
        split_width_multiplier = 1.0 
        use_active_for_splits = true
        pseudotile = yes 
        preserve_split = yes 
      }

      master {
        new_is_master = true
        special_scale_factor = 0.8
        new_is_master = true
        no_gaps_when_only = false
      }

      # cursor_inactive_timeout = 0
      decoration {
        rounding = 0
        active_opacity = 1.0
        inactive_opacity = 1.0
        fullscreen_opacity = 1.0
        drop_shadow = false
        dim_inactive = false
          blur {
              enabled = true
              size = 3
              passes = 3
              new_optimizations = true
              ignore_opacity = false
          }
      }
      animations {
        enabled=1
        bezier = overshot, 0.13, 0.99, 0.29, 1.1
        animation = windows, 1, 4, overshot, slide
        animation = windowsOut, 1, 5, default, popin 80%
        animation = border, 1, 5, default
        animation = fade, 1, 8, default
        animation = workspaces, 1, 6, overshot, slidevert
      }

      misc {
        disable_autoreload = true
        disable_hyprland_logo = true
        always_follow_on_dnd = true
        layers_hog_keyboard_focus = true
        animate_manual_resizes = false
        enable_swallow = true
        swallow_regex =
        focus_on_activate = true
      }

      bind = $mainMod, Return, exec, foot 
      bind = $mainMod SHIFT, Return, exec, foot --class="termfloat"
      bind = $mainMod, Q, killactive,
      bind = $mainMod SHIFT, Q, exit,
      bind = $mainMod,Space, togglefloating,
      bind = $mainMod, F,fullscreen
      bind = $mainMod, Y,pin
      bind = $mainMod, o, pseudo, # dwindle
      bind = $mainMod, T, togglesplit, # dwindle

      #------------#
      # change gap #
      #------------#
      bind = $mainMod SHIFT, G,exec,hyprctl --batch "keyword general:gaps_out 5;keyword general:gaps_in 3"
      bind = $mainMod , G,exec,hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"

      #--------------------------------------#
      # Move focus with mainMod + arrow keys #
      #--------------------------------------#
      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d

      #----------------------------------------#
      # Switch workspaces with mainMod + [0-9] #
      #----------------------------------------#
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      bind = $mainMod, n, workspace, e+1
      bind = $mainMod, p, workspace,e-1

      #-------------------------------#
      # special workspace(scratchpad) #
      #-------------------------------# 
      bind = $mainMod, minus, movetoworkspace,special
      bind = $mainMod, equal, togglespecialworkspace

      #----------------------------------#
      # move window in current workspace #
      #----------------------------------#
      bind = $mainMod SHIFT,h,movewindow, l
      bind = $mainMod SHIFT,l,movewindow, r
      bind = $mainMod SHIFT,k,movewindow, u
      bind = $mainMod SHIFT,j,movewindow, d

      #---------------------------------------------------------------#
      # Move active window to a workspace with mainMod + ctrl + [0-9] #
      #---------------------------------------------------------------#
      bind = $mainMod CTRL, 1, movetoworkspace, 1
      bind = $mainMod CTRL, 2, movetoworkspace, 2
      bind = $mainMod CTRL, 3, movetoworkspace, 3
      bind = $mainMod CTRL, 4, movetoworkspace, 4
      bind = $mainMod CTRL, 5, movetoworkspace, 5
      bind = $mainMod CTRL, 6, movetoworkspace, 6
      bind = $mainMod CTRL, 7, movetoworkspace, 7
      bind = $mainMod CTRL, 8, movetoworkspace, 8
      bind = $mainMod CTRL, 9, movetoworkspace, 9
      bind = $mainMod CTRL, 0, movetoworkspace, 10
      bind = $mainMod CTRL, p, movetoworkspace, -1
      bind = $mainMod CTRL, n, movetoworkspace, +1
      # same as above, but doesnt switch to the workspace
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      #-------------------------------------------#
      # switch between current and last workspace #
      #-------------------------------------------#
      binds {
           workspace_back_and_forth = 1 
           allow_workspace_cycles = 1
      }
      bind=$mainMod,slash,workspace,previous

      bind=$mainMod,z,exec, pkill rofi || rofi -show drun -theme ~/.config/rofi/launcher 
      bind=$mainMod,X,exec, bash ~/.config/rofi/powermenu.sh

      # volume control
      bind=,XF86AudioRaiseVolume,exec, pamixer -i 5
      bind=,XF86AudioLowerVolume,exec, pamixer -d 5
      bind=,XF86AudioMute,exec, pamixer -t

      # music control bindings
      bind=,XF86AudioPlay,exec, playerctl play-pause
      bind=,XF86AudioNext,exec, playerctl next
      bind=,XF86AudioPrev,exec, playerctl previous
      bind=, XF86AudioStop, exec, playerctl stop

      #---------------#
      # waybar toggle #
      # --------------#
      bind=$mainMod,B,exec, pkill -SIGUSR1 waybar

      #---------------#
      # resize window #
      #---------------#
      bind=ALT,R,submap,resize
      submap=resize
      binde=,l,resizeactive,15 0
      binde=,h,resizeactive,-15 0
      binde=,k,resizeactive,0 -15
      binde=,j,resizeactive,0 15
      bind=,escape,submap,reset 
      submap=reset

      bind=CTRL SHIFT, h, resizeactive, 15 0
      bind=CTRL SHIFT, l, resizeactive,-15 0
      bind=CTRL SHIFT, k, resizeactive, 0 -15
      bind=CTRL SHIFT, j, resizeactive, 0 15

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow


      #------------#
      # auto start #
      #------------#
      exec-once = ${launch_waybar}/bin/launch_waybar &
      exec-once = mako &
      exec-once = swww init &

      #---------------#
      # windows rules #
      #---------------#
      #`hyprctl clients` get class、title...
      windowrule=float,title:^(Picture-in-Picture)$
      windowrule=size 960 540,title:^(Picture-in-Picture)$
      windowrule=move 25%-,title:^(Picture-in-Picture)$
      windowrule=float,imv
      windowrule=move 25%-,imv
      windowrule=size 960 540,imv
      windowrule=float,mpv
      windowrule=move 25%-,mpv
      windowrule=size 960 540,mpv
      windowrule=float,danmufloat
      windowrule=move 25%-,danmufloat
      windowrule=pin,danmufloat
      windowrule=rounding 5,danmufloat
      windowrule=size 960 540,danmufloat
      windowrule=float,termfloat
      windowrule=move 25%-,termfloat
      windowrule=size 960 540,termfloat
      windowrule=rounding 5,termfloat
      windowrule=float,nemo
      windowrule=move 25%-,nemo
      windowrule=size 960 540,nemo
      windowrule=opacity 0.95,title:Telegram
      windowrule=animation slide right,foot
      windowrule=workspace name:TG, title:Telegram
      windowrule=workspace name:Music, musicfox
      windowrule=float,ncmpcpp
      windowrule=move 25%-,ncmpcpp
      windowrule=size 960 540,ncmpcpp
      windowrule=noblur,^(firefox)$
    '';
  };
}

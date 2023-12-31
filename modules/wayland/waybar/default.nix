let ui = import ../../theme/ui.nix { };

in {
  nixpkgs.overlays = [
    (final: prev: {
      waybar = prev.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        postPatch = (oldAttrs.postPatch or "") + ''
          sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp'';
      });
    })
  ];
  home-manager.users.xenoxanite = {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      settings = [{
        layer = "top";
        position = "top";
        modules-left = [ "clock" "custom/cava-internal" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "pulseaudio"
          "pulseaudio#microphone"
          "memory"
          # "cpu"
          # "disk"
          # "custom/ibus-layout"
          "tray"
        ];
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
          };
        };
        "disk" = {
          "format" = " {used}";
          "path" = "/";
          "interval" = 3;
        };
        "pulseaudio" = {
          "scroll-step" = 5;
          "format" = "{icon}{volume}%";
          "format-muted" = "";
          "format-icons" = { "default" = [ " " " " " " ]; };
          "on-click" = "pamixer -t";
          "on-click-right" = "pavucontrol";
        };
        "pulseaudio#microphone" = {
          "format" = "{format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          "on-click" = "pamixer --default-source -t";
          "on-scroll-up" = "pamixer --default-source -i 5";
          "on-scroll-down" = "pamixer --default-source -d 5";
          "scroll-step" = 5;
          "on-click-right" = "pavucontrol";
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%I:%M %b %d}";
          "tooltip-format" = "<tt>{calendar}</tt>";
        };
        "memory" = {
          "interval" = 2;
          "format" = " {used}G";
        };
        "cpu" = {
          "interval" = 2;
          "format" = " {usage}%";
        };
        "custom/cava-internal" = {
          "exec" = "sleep 1s && cava-internal";
          "tooltip" = false;
        };
        "custom/ibus-layout" = {
          "exec" = "cat ~/.cache/ibus-layout";
          "interval" = 1;
          "tooltip" = false;
        };
        "network" = {
          "interval" = 1;
          "format" = "󰣺 Connected";
          "format-alt" = " {bandwidthUpBytes}  {bandwidthDownBytes}";
          "format-disconnected" = "󰣼 Disconnected";
        };
        "tray" = {
          "icon-size" = 13;
          "spacing" = 8;
        };
      }];

      style = with ui; ''
        * {
          font-family: ${font}, 'FontAwesome 6 Free';
          font-weight: bold;
          font-size: 14px;
          min-height: 0;
          transition-property: background-color;
          transition-duration: 0.5s;
        }
        window#waybar {
          background: #${colors.background};
          color: #${foreground-color};
          border-bottom: ${toString border-size}px solid #${border-color};
          opacity: 0.97;
        }

        #workspaces { 
          border-radius: 0px; 
          margin: 4px 0px; 
          background-color: #${colors.background}; 
          border-radius: ${toString border-radius}px; 
        } 
        #workspaces button {
          padding: 0px 0px;
          margin: 6px 10px;
          border-radius: 0px;
          border-radius: 2px;
          color: #${colors.brightblack};
          font-size: 10pt;
        }
        #workspaces button.active {
          background-color: @background;
          color: #${foreground-color};
          
        }
        #workspaces button:hover {
          background-color: #${colors.background};
          border: none;
        }

        #clock, #custom-cava-internal {
          margin-left: 22px;
          color: #${foreground-color};
        }

        #pulseaudio, #memory, #cpu, #disk, #tray, #network, #custom-ibus-layout {
          margin-right: 22px;
          color: #${foreground-color};
        }
      '';
    };
  };

}

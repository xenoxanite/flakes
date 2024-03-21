{ pkgs-master, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs-master.waybar;
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        border-radius: 0px;
        transition-property: background-color;
        transition-duration: 0.5s;
      }
      @keyframes blink_red {
        to {
          background-color: #fc7b81;
          color: #101419;
        }
      }
      .warning,
      .critical,
      .urgent {
        animation-name: blink_red;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      window#waybar {
        background-color: transparent;
      }
      window > box {
        background-color: #101419;
      }
      #workspaces {
        font-size: 14pt;
        padding-left: 0px;
        padding-right: 4px;
      }
      #workspaces button {
        padding-top: 5px;
        padding-bottom: 5px;
        padding-left: 6px;
        padding-right: 6px;
        color: #384148;
      }
      #workspaces button.active {
        background-color: #94f7c5;
        color: #101419;
      }
      #workspaces button.urgent {
        color: #fc7b81;
      }
      #workspaces button:hover {
        background-color: #b38dac;
        color: rgb(26, 24, 38);
      }
      #pulseaudio {
        font-size: 14pt;
        margin: 6px;
        padding: 2px 8px;
        color: #94f7c5;
      }
      #clock {
        font-size: 14pt;
        margin: 6px;
        padding: 2px 8px;
        background-color: #384148;
        color: #70a5eb;
      }

      #tray {
        padding-right: 12px;
        padding-left: 8px;
      }

      #window {
        color: #384148;
        margin-left: 10px;
        font-size: 12pt;
        opacity: 0.6;
        font-style: italic;
      }
    '';
    settings = [{
      "layer" = "top";
      "position" = "bottom";
      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-right = [ "pulseaudio" "clock" "tray" ];
      "hyprland/workspaces" = {
        "format" = "{name}";
        "on-click" = "activate";
      };
      "hyprland/window" = {
        "max-length" = 200;
        "separate-outputs" = true;
      };
      "pulseaudio" = {
        "scroll-step" = 10;
        "format" = "󰕿{icon}";

        "format-icons" = { "default" = [ "" "" "" "" "" ]; };
        "format-muted" = "󰝟 ";

        "on-click" = "pamixer -t";
        "tooltip" = false;
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%I:%M %b %d}";
        "tooltip" = true;
        "tooltip-format" = ''
          {=%A; %d %B %Y}
          <tt>{calendar}</tt>'';
      };
      "tray" = {
        "icon-size" = 15;
        "spacing" = 5;
      };
    }];
  };
}

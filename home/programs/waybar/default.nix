{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false; # disable it,autostart it in hyprland conf
      target = "graphical-session.target";
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14pt;
        font-weight: bold;
        border-radius: 0px;
        transition-property: background-color;
        transition-duration: 0.5s;
      }
      @keyframes blink_red {
        to {
          background-color: rgb(242, 143, 173);
          color: rgb(26, 24, 38);
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
        background-color: rgb(30, 30, 46);
      }
      #workspaces {
        padding-left: 0px;
        padding-right: 4px;
      }
      #workspaces button {
        padding-top: 5px;
        padding-bottom: 5px;
        padding-left: 6px;
        padding-right: 6px;
        color: #d8dee9;
      }
      #workspaces button.active {
        background-color: rgb(181, 232, 224);
        color: rgb(26, 24, 38);
      }
      #workspaces button.urgent {
        color: rgb(26, 24, 38);
      }
      #workspaces button:hover {
        background-color: #b38dac;
        color: rgb(26, 24, 38);
      }
      tooltip {
        background: rgb(48, 45, 65);
      }
      tooltip label {
        color: rgb(217, 224, 238);
      }
      #custom-launcher {
        padding-left: 8px;
        padding-right: 6px;
        color: rgb(201, 203, 255);
      }
      #window,
      #clock,
      #memory,
      #cpu,
      #pulseaudio,
      #network {
        padding-left: 10px;
        padding-right: 10px;
      }
      #memory {
        color: rgb(181, 232, 224);
      }
      #cpu {
        color: rgb(245, 194, 231);
      }
      #clock {
        color: #eba0ac;
      }
      #pulseaudio {
        color: rgb(245, 224, 220);
      }
      #clock {
          color: rgb(242, 143, 173);
      }
      #network {
        color: #abe9b3;
      }

      #network.disconnected {
        color: rgb(255, 255, 255);
      }
      #tray {
        padding-right: 12px;
        padding-left: 8px;
      }
      #window {
        opacity: 0.9;
        color: #414868;
        font-style: italic;
        padding-left: 14px;
        font-size: 10pt;
      }
    '';
    settings = [{
      "layer" = "top";
      "position" = "bottom";
      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-right = [ "pulseaudio" "memory" "cpu" "network" "clock" "tray" ];
      "hyprland/workspaces" = {
        "format" = "{name}";
        "on-click" = "activate";
      };

      "hyprland/window" = {
        "max-length" = 200;
        "separate-outputs" = true;
      };
      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon} {volume}%";
        "format-muted" = "󰖁 Muted";
        "format-icons" = { "default" = [ "" "" "" ]; };
        "on-click" = "pamixer -t";
        "tooltip" = false;
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%I:%M %p}";
        "tooltip" = true;
        "tooltip-format" = ''
          {=%A; %d %B %Y}
          <tt>{calendar}</tt>'';
      };
      "memory" = {
        "interval" = 1;
        "format" = "󰍛 {percentage}%";
        "states" = { "warning" = 85; };
      };
      "cpu" = {
        "interval" = 1;
        "format" = "󰻠 {usage}%";
      };
      "network" = {
        "format-disconnected" = "󰯡 Disconnected";
        "format-ethernet" = "󰀂 {ifname}";
        "interval" = 1;
        "tooltip" = false;
      };
      "tray" = {
        "icon-size" = 15;
        "spacing" = 5;
      };
    }];
  };
}

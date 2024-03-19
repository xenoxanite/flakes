{ config, ... }: {
  programs.fish = {
    enable = true;
    loginShellInit = ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
    '';
    interactiveShellInit = ''set fish_greeting ""'';
    shellAliases = {
      l = "ls -ahl";
      la = "exa -a --icons";
      ll = "exa -l --icons";
      ls = "exa";
      n = "neofetch";
      nf = ''
        nvim (FZF_DEFAULT_COMMAND='fd' FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'" fzf --height 60% --layout reverse --info inline --border --color 'border:#b48ead')'';
    };

    functions = {
      f = ''
        FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'" fzf --height 60% --layout reverse --info inline --border --color $argv
      '';
    };
  };
  home.file = {
    ".config/fish/conf.d/mocha.fish".text = import ./mocha.nix;
    ".config/fish/functions/fish_prompt.fish".source =
      ./functions/fish_prompt.fish;
    ".config/fish/functions/xdg-get.fish".text = import ./functions/xdg-get.nix;
    ".config/fish/functions/xdg-set.fish".text = import ./functions/xdg-set.nix;
    ".config/fish/functions/owf.fish".text = import ./functions/owf.nix;
  };
}

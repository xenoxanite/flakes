{ user, pkgs, ... }: {
  home.packages = with pkgs; [ fd eza ];
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;
    shellAliases = {
      ls = "exa --icons";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      lt = "ls --tree";
      lta = "ls --tree -a";
      rebuild =
        "sudo nixos-rebuild switch --flake /home/${user}/dev/flakes#oxygen";
      update = "sudo nix flake update /home/${user}/dev/flakes";
      ncg =
        "nix-collect-garbage -d && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/*";
      v = ''nvim "$(fd --type f --hidden --exclude .git | fzf --reverse)"'';
      mus = ''
        mpv "$(fd /nix/persist/home/xenoxanite/musix | find -name "*.mp3" -o  -name "*.webp" |fzf --reverse)"'';
      aud =
        ''mpv "$(fd | find -name "*.mp3" -o  -name "*.webp" |fzf --reverse)"'';
      vid = ''
        mpv "$(fd | find -name "*.mkv" -o -name "*.mp4" -o -name "*.webm" |fzf --reverse)"'';
      record =
        "ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0+0,0 $HOME/vids/$(date +'%Y%m%d%H%M%S_1.mp4')";
    };
    dirHashes = {
      docs = "$HOME/docs";
      notes = "$HOME/docs/notes";
      dots = "$HOME/dev/flakes";
      dl = "$HOME/downloads";
      vids = "$HOME/vids";
      pix = "$HOME/pix";
      musix = "$HOME/musix";
      media = "/run/media/$USER";
    };
  };
}

{ self, inputs, user, ... }: {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  programs.nh = {
    enable = true;
    package = inputs.nh.packages.x86_64-linux.default;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/nix/persist/home/${user}/dev/flakes";
  };

  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnsupportedSystem = true;
      allowUnfree = true;

    };
    overlays = let
      myOverlay = self: super: {
        discord = super.discord.override { withVencord = true; };
      };
    in with inputs; [
      myOverlay
      self.overlays.default
      nur.overlay
      neovim-nightly-overlay.overlay
    ];
  };
}

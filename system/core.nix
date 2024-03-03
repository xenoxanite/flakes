{ self, inputs, ... }: {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  imports = with inputs; [ hosts.nixosModule hyprland.nixosModules.default ];
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

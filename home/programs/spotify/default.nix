{ pkgs, inputs, ... }:
let spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [ inputs.spicetify-nix.homeManagerModule ];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    enabledCustomApps = with spicePkgs.apps; [ lyrics-plus ];
    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts
      bookmark
      fullAppDisplay
      adblock
      keyboardShortcut
      volumePercentage
      autoSkip
    ];
  };
}

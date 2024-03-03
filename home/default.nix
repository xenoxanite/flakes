{ inputs, self, user, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs user; };
    users.${user} = {
      imports = [ ./wm/hyprland ./programs ./impermanence.nix ./editor/neovim ];
      home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
        stateVersion = "23.11";
        sessionPath = [ "$HOME/bin" "$HOME/.local/bin" "$HOME/.cargo/bin" ];
      };
      programs.home-manager.enable = true;
    };
  };
}

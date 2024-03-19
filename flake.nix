{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence = { url = "github:nix-community/impermanence"; };
    nur.url = "github:nix-community/NUR";
    hosts.url = "github:StevenBlack/hosts";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    BetterFox = {
      url = "github:yokoffing/BetterFox";
      flake = false;
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, self, ... }@inputs:

    let
      selfPkgs = import ./pkgs;
      system = "x86_64-linux";
      user = "xenoxanite";
      inherit nixpkgs;
    in {
      packages = nixpkgs.legacyPackages.${system};
      overlays.default = selfPkgs.overlay;
      nixosConfigurations.oxygen = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self user; };
        modules = [ ./hosts/oxygen ];
      };
    };
}

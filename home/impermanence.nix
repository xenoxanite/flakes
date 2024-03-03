{ inputs, ... }: {
  imports = [

    inputs.impermanence.nixosModules.home-manager.impermanence

  ];

  home.persistence."/persist/home" = {
    directories = [
      "pix"
      "docs"
      "dev"
      "vids"
      ".librewolf"
      ".config/gh"
      ".local/share"
      ".local/state"
      ".cache"
      ".gnupg"
      ".ssh"
    ];
    files = [ ".screenrc" ];
    allowOther = true;
  };
}

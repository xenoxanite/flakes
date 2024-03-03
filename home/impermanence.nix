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
      ".config/nvim"
      ".local/share/direnv"
      ".gnupg"
      ".ssh"
      ".local/share/nvim"
    ];
    files = [ ".screenrc" ];
    allowOther = true;
  };
}

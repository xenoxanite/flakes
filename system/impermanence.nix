{ inputs, user, ... }: {

  imports = [ inputs.impermanence.nixosModules.impermanence ];
  fileSystems."/nix".neededForBoot = true;
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories =
      [ "/etc/nixos" "/var/lib/" "/etc/NetworkManager/system-connections" ];
    files = [
      "/etc/machine-id"
      {
        file = "/var/keys/secret_file";
        parentDirectory = { mode = "u=rwx,g=,o="; };
      }
    ];
    users.${user} = {
      directories = [
        "dev"
        "docs"
        "vids"
        "pix"
        "musix"
        "virt"
        "Downloads"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }

        ".mozilla"
        ".config"
        ".suckless"
        ".cache"
        ".local"
        ".rustup"
        ".cargo"
      ];
      files = [ ".xinitrc" ".xresources" ".zsh_history" ".fehbg" ];
    };
  };
}

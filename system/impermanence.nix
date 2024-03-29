{ inputs, user, ... }: {

  imports = [ inputs.impermanence.nixosModules.impermanence ];
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
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
        "virt"
        "pics"
        "Downloads"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        ".cache"
        ".mozilla/"
        ".local"
        ".config"
      ];
      files = [ ".npmrc" ];
    };
  };
}

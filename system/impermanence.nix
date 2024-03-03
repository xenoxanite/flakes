{ inputs, user, ... }: {

  imports = [ inputs.impermanence.nixosModules.impermanence ];
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
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
        ".local"
        ".librewolf"
        ".config"
      ];
      files = [ ".npmrc" ];
    };
  };
}

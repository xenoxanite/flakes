{
  networking = {
    hostName = "oxygen";
    stevenblack = {
      enable = true;
      block = [ "fakenews" "gambling" "porn" "social" ];
    };
  };
  services.openssh = { enable = true; };
}

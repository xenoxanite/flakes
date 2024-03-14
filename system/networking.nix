{
  networking = {
    hostName = "oxygen";
    stevenblack = {
      enable = true;
      block = [ "fakenews" "gambling" "porn" ];
    };
  };
  services.openssh = { enable = true; };
}

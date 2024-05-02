{ pkgs, ... }: {
  networking = {
    hostName = "oxygen";
    stevenblack = {
      enable = true;
      block = [ "fakenews" "gambling" "porn" ];
    };
  };

  services.openssh = { enable = true; };
  systemd.packages = [ pkgs.cloudflare-warp ];
  systemd.services."warp-svc".wantedBy = [ "multi-user.target" ];
  environment.systemPackages = [ pkgs.cloudflare-warp ];

}

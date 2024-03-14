{ user, ... }: {
  virtualisation = {
    waydroid.enable = true;
    libvirtd.enable = true;
  };
  programs.virt-manager.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  programs.dconf.enable = true;
  users.groups.libvirtd.members = [ "${user}" ];
}

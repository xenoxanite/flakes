{ pkgs, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.udev.extraRules = ''
    KERNEL=="card0", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"
  '';
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    protonup-qt
    mangohud
    (lutris.override {
      extraLibraries = pkgs:
        [
          # List library dependencies here
        ];
      extraPkgs = pkgs:
        [
          # List package dependencies here
        ];
    })
  ];
}

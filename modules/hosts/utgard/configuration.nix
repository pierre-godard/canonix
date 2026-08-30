{ den, ... }: {
  den.aspects.utgard = {
    includes = [
      den.batteries.hostname
      den.aspects.locale
      den.aspects.catppuccin
      den.aspects.shell
      den.aspects.desktop
      den.aspects.gaming
      den.aspects.laptop
      den.aspects.sops
      den.aspects.common
    ];
    nixos = { config, ... }: {
      users.users.pierre.extraGroups = [ "gamemode" "networkmanager" ];

      hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      hardware.nvidia.prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };

      services.asusd.enable = true;
      services.supergfxd.enable = true;

      environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "nvidia";
        NVD_BACKEND = "direct";
        GBM_BACKEND = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
    };
  };
}

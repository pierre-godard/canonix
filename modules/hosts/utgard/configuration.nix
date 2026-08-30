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
    ];
    nixos = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      security.sudo.enable = true;
      system.stateVersion = "26.05";
      time.timeZone = "Europe/Paris";
      i18n.defaultLocale = "en_US.UTF-8";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = ".backup";

      users.users.pierre = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [ "wheel" "gamemode" "networkmanager" ];
      };

      # Configure network connections interactively with nmcli or nmtui.
      networking.networkmanager.enable = true;

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

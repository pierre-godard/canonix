{ den, ... }: {
  den.aspects.rog = {
    includes = [
      den.batteries.hostname
      den.aspects.catppuccin
      den.aspects.shell
      den.aspects.niri
      den.aspects.gaming
    ];
    nixos = { pkgs, lib, ... }: {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
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

      networking.networkmanager.enable = true;

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      services.blueman.enable = true;

      services.greetd = {
        enable = true;
        settings.default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
          user = "greeter";
        };
      };

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

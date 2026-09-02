{ inputs, den, ... }: {
  den.aspects.gaming = {
    includes = [ den.aspects.minecraft ];
    nixos = { pkgs, ... }: {
      imports = [ inputs.nix-gaming.nixosModules.pipewireLowLatency ];

      security.rtkit.enable = true;
      services.pipewire = {
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      boot.kernelPackages = pkgs.linuxPackages_zen;
      boot.kernel.sysctl."vm.max_map_count" = 2147483642;

      hardware.graphics.enable = true;
      hardware.steam-hardware.enable = true;
      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        open = false;
      };
      services.xserver.videoDrivers = [ "nvidia" ];

      programs.steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };
      programs.gamemode.enable = true;
      programs.gamescope.enable = true;
    };

    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.mangohud ];
    };
  };
}

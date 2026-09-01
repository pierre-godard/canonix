{ den, ... }: {
  den.aspects.utgard = {
    includes = [
      den.batteries.hostname
      den.aspects.locale
      den.aspects.catppuccin
      den.aspects.shell
      den.aspects.desktop
      den.aspects.gaming
      den.aspects.beyond-all-reason
      den.aspects.dms-shell
      den.aspects.laptop
      den.aspects.sops
      den.aspects.common
    ];
    homeManager = { lib, ... }: {
      home.activation.steamLibraryFolder = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        vdf="$HOME/.local/share/Steam/steamapps/libraryfolders.vdf"
        if ! grep -q '"/mnt/games"' "$vdf" 2>/dev/null; then
          mkdir -p "$(dirname "$vdf")"
          cat > "$vdf" << 'EOF'
"libraryfolders"
{
	"1"
	{
		"path"		"/mnt/games"
	}
}
EOF
        fi
      '';
      home.file."Pictures/Wallpapers".source = ../../../assets;
    };

    nixos = { config, pkgs, ... }: {
      boot.kernelParams = [ "pcie_aspm=off" ];
      users.users.pierre.extraGroups = [ "gamemode" "networkmanager" ];

      systemd.services.chown-games = {
        description = "Fix ownership of /mnt/games";
        after = [ "mnt-games.mount" ];
        requires = [ "mnt-games.mount" ];
        wantedBy = [ "mnt-games.mount" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = [
            "${pkgs.coreutils}/bin/mkdir -p /mnt/games/steamapps"
            "${pkgs.coreutils}/bin/chown pierre:users /mnt/games /mnt/games/steamapps"
          ];
        };
      };

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

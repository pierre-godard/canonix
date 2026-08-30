{ den, ... }: {
  den.aspects.yggdrasil = {
    includes = [
      den.batteries.hostname
      den.aspects.locale
      den.aspects.shell
      den.aspects.kubernetes
      den.aspects.sops
    ];
    nixos = { lib, ... }: {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      security.sudo.enable = true;
      system.stateVersion = "26.05";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = ".backup";
    };
  };
}

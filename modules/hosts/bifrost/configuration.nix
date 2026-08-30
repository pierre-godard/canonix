{ den, ... }: {
  den.aspects.bifrost = {
    includes = [
      den.batteries.hostname
      den.aspects.locale
    ];
    nixos = { lib, ... }: {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      wsl.defaultUser = "nixos";
      security.sudo.enable = true;
      system.stateVersion = "26.05";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = ".backup";
    };
  };
}

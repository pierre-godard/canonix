{ den, ... }: {
  den.aspects.common = {
    nixos = { ... }: {
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

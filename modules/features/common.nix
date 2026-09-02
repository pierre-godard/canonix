{ den, ... }: {
  den.aspects.common = {
    nixos = { ... }: {
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      nix.settings.auto-optimise-store = true;
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      networking.firewall.enable = true;
      security.sudo.enable = true;
      system.stateVersion = "26.05";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = ".backup";
    };
  };
}

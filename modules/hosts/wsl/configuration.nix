{ den, ... }: {
  den.aspects.wsl = {
    includes = [
      den.batteries.hostname
    ];
    nixos = { pkgs, lib, ... }: {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      wsl.defaultUser = "nixos";
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
        extraGroups = [ "wheel" ];
      };
      users.users.nixos = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [ "wheel" ];
      };
    };
  };
}

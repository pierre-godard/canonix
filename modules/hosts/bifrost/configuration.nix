{ den, ... }: {
  den.aspects.bifrost = {
    includes = [
      den.batteries.hostname
      den.aspects.locale
      den.aspects.common
    ];
    nixos = { lib, ... }: {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      wsl.defaultUser = "nixos";
    };
  };
}

{ den, ... }: {
  den.aspects.yggdrasil = {
    includes = [
      den.batteries.hostname
      den.aspects.locale
      den.aspects.shell
      den.aspects.kubernetes
      den.aspects.sops
      den.aspects.common
    ];
    nixos = { lib, ... }: {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
  };
}

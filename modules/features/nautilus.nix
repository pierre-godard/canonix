{ den, ... }: {
  den.aspects.nautilus = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.nautilus ];
      services.gvfs.enable = true;
    };
  };
}

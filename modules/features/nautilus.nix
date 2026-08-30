{ den, ... }: {
  den.aspects.nautilus = {
    nixos = { ... }: {
      services.gvfs.enable = true;
    };
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.nautilus ];
    };
  };
}

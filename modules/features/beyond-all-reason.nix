{ den, ... }: {
  den.aspects.beyond-all-reason = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.beyond-all-reason ];
    };
  };
}

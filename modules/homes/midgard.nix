{ den, ... }: {
  den.homes.x86_64-linux."pierre@midgard" = {
    aspect = {
      includes = [
        den.aspects.pierre
        den.aspects.data-science
      ];
      homeManager = { ... }: {
        home.username = "pierre";
        home.homeDirectory = "/home/pierre";
      };
    };
  };
}

{ den, ... }: {
  flake.homeModules.firefox = { ... }: {
    programs.firefox.enable = true;
  };

  den.aspects.firefox = {
    homeManager = { ... }: {
      programs.firefox.enable = true;
    };
  };
}

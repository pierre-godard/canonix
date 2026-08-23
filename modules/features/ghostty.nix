{ den, ... }: {
  flake.homeModules.ghostty = { ... }: {
    programs.ghostty.enable = true;
  };

  den.aspects.ghostty = {
    homeManager = { ... }: {
      programs.ghostty.enable = true;
    };
  };
}

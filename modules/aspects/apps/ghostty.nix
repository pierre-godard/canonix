{ den, ... }: {
  den.aspects.ghostty = {
    homeManager = { ... }: {
      programs.ghostty.enable = true;
    };
  };
}

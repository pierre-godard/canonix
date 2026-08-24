{ den, ... }: {
  den.aspects.pierre = {
    includes = [
      den.aspects.catppuccin
      den.aspects.shell
      den.aspects.development
      den.aspects.github
    ];
    homeManager = { ... }: {
      home.stateVersion = "26.05";
    };
  };
}

{ den, ... }: {
  den.aspects.nixos = {
    includes = [
      den.aspects.catppuccin
      den.aspects.shell
      den.aspects.development
      den.aspects.firefox
      den.aspects.ghostty
      den.aspects.github
    ];
    homeManager = { ... }: {
      home.stateVersion = "26.05";
    };
  };
}

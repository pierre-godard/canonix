{ den, ... }: {
  den.aspects.desktop = {
    includes = [
      den.aspects.niri
      den.aspects.greetd
    ];
  };
}

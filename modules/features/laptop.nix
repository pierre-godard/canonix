{ den, ... }: {
  den.aspects.laptop = {
    includes = [
      den.aspects.bluetooth
      den.aspects.networking
      den.aspects.power
    ];
  };
}

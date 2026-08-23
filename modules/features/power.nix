{ den, ... }: {
  den.aspects.power = {
    nixos = { ... }: {
      services.power-profiles-daemon.enable = true;
    };
  };
}

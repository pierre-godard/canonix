{ den, ... }: {
  den.aspects.power = {
    nixos = { ... }: {
      services.upower.enable = true;
      services.power-profiles-daemon.enable = true;
    };
  };
}

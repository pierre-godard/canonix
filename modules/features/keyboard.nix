{ den, ... }: {
  den.aspects.keyboard = {
    nixos = { ... }: {
      services.xserver.xkb = {
        layout = "fr";
        variant = "us";
        options = "caps:super";
      };
    };
  };
}

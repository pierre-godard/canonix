{ den, ... }: {
  den.aspects.keyboard = {
    nixos = { ... }: {
      services.xserver.xkb = {
        layout = "fr";
        variant = "us";
        options = "caps:super";
      };
      environment.variables = {
        XKB_DEFAULT_LAYOUT = "fr";
        XKB_DEFAULT_VARIANT = "us";
        XKB_DEFAULT_OPTIONS = "caps:super";
      };
    };
  };
}

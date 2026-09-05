{ den, ... }: {
  den.aspects.desktop = {
    nixos = { ... }: {
      programs.dconf.enable = true;
    };
    includes = [
      den.batteries.host-aspects
      den.aspects.niri
      den.aspects.greetd
      den.aspects.keyring
      den.aspects.firefox
      den.aspects.ghostty
      den.aspects.nautilus
      den.aspects.plymouth
    ];
  };
}

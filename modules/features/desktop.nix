{ den, ... }: {
  den.aspects.desktop = {
    includes = [
      den.aspects.niri
      den.aspects.greetd
      den.aspects.firefox
      den.aspects.ghostty
    ];
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.nautilus ];
      services.gvfs.enable = true;
    };
  };
}

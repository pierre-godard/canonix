{ den, ... }: {
  den.aspects.pierre = {
    includes = [
      den.aspects.catppuccin
      den.aspects.shell
      den.aspects.development
      den.aspects.github
      den.aspects.keyboard
    ];
    nixos = { pkgs, ... }: {
      users.users.pierre = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [ "wheel" ];
      };
    };
    homeManager = { ... }: {
      home.stateVersion = "26.05";
    };
  };
}

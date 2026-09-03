{ den, ... }: {
  den.aspects.nixos = {
    includes = [
      den.aspects.catppuccin
      den.aspects.shell
      den.aspects.development
      den.aspects.github
      den.aspects.direnv
      den.aspects.zellij
      den.aspects.neovim
      den.aspects.btop
    ];
    nixos = { pkgs, ... }: {
      users.users.nixos = {
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

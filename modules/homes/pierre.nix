{ self, inputs, den, ... }: {
  flake.homeConfigurations.pierreConfiguration = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.pierreModule
      {
        home.username = "pierre";
        home.homeDirectory = "/home/pierre";
      }
    ];
  };

  flake.homeModules.pierreModule = { pkgs, ... }: {
    imports = [
      self.homeModules.catppuccin
      self.homeModules.ghostty
      self.homeModules.firefox
      self.homeModules.shell
      self.homeModules.development
      self.homeModules.github
    ];
    home.username = "pierre";
    home.stateVersion = "26.05";
  };

  den.aspects.pierre = {
    includes = [
      den.aspects.catppuccin
      den.aspects.shell
      den.aspects.development
      den.aspects.firefox
      den.aspects.ghostty
      den.aspects.github
    ];
    homeManager = { ... }: {
      home.stateVersion = "26.05";
    };
  };
}

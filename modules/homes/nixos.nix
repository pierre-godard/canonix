{ self, inputs, ... }: {

  flake.homeConfigurations.nixosConfiguration = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.nixosModule
      {
        home.username = "nixos";
        home.homeDirectory = "/home/nixos";
      }
    ];
  };

  flake.homeModules.nixosModule = { pkgs, ... }: {
    imports = [
      self.homeModules.catppuccin
      self.homeModules.ghostty
      self.homeModules.firefox
      self.homeModules.shell
      self.homeModules.development
      self.homeModules.github
    ];
    home.username = "nixos";
    home.stateVersion = "26.05";
  };
}

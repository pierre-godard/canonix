{ self, inputs, ... }:
{
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.wslConfiguration
    ];
  };

  flake.homeConfigurations.wsl = inputs.home-manager.lib.homeConfiguration {
    modules = [
      self.homeModules.wslConfiguration
    ];
  };
}

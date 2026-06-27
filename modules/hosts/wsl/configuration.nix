{ self, inputs, ... }:
{
  flake.nixosModules.wslConfiguration = { config, lib, pkgs, ... }: {
    imports = [
      # include NixOS-WSL modules
      <nixos-wsl/modules>
      self.nixosModules.wslHardware
      self.nixosModules.homeManager
      self.nixosModules.niri
      self.nixosModules.catppuccin
      self.nixosModules.shell
    ];

    # Set the host platform for WSL
    # This could be made configurable if needed for different WSL instances
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    wsl.enable = true;
    wsl.defaultUser = "nixos";

    # Before changing this value read the documentation for this option
    system.stateVersion = "26.05";

    users.users = {
      pierre = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [ "wheel" ];
      };
      nixos = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [ "wheel" ];
      };
    };

    security.sudo = {
      enable = true;
    };

    home-manager.users = {
      nixos = self.homeModules.nixosModule;
      pierre = self.homeModules.pierreModule;
    };

    home-manager.backupFileExtension = ".backup";
  };

}

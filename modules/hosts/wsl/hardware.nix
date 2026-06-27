{ self, inputs, ... }:
{
  flake.nixosModules.wslHardware = { config, lib, pkgs, ... }: {
    imports = [
      # <nixos-wsl/modules>
    ];

  };
}

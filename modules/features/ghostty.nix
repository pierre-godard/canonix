{ config, lib, pkgs, ... }: {
  flake.homeModules.ghostty = { pkgs, lib, ... }: {
    programs.ghostty = {
      enable = true;
    };
  };
}

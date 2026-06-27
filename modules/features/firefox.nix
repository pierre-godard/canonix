{ config, lib, pkgs, ... }: {
  flake.homeModules.firefox = { pkgs, lib, ... }: {
    programs.firefox = {
      enable = true;
    };
  };
}

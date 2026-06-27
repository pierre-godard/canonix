{ config, lib, pkgs, ... }: {
  flake.homeModules.development = { pkgs, lib, ... }: {
    programs.git = {
      enable = true;
    };
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "pierre-godard@users.noreply.github.com";
          name = "Pierre Godard";
        };
      };
    };
    programs.jjui = {
      enable = true;
    };
  };
}

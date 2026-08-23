{ den, ... }: {
  flake.homeModules.development = { pkgs, lib, ... }: {
    programs.git.enable = true;
    programs.jujutsu = {
      enable = true;
      settings.user = {
        email = "pierre-godard@users.noreply.github.com";
        name = "Pierre Godard";
      };
    };
    programs.claude-code.enable = true;
    programs.jjui.enable = true;
  };

  den.aspects.development = {
    homeManager = { pkgs, ... }: {
      programs.git.enable = true;
      programs.jujutsu = {
        enable = true;
        settings.user = {
          email = "pierre-godard@users.noreply.github.com";
          name = "Pierre Godard";
        };
      };
      programs.claude-code.enable = true;
      programs.jjui.enable = true;
    };
  };
}

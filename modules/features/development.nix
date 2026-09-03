{ den, ... }: {
  den.aspects.development = {
    includes = with den.aspects; [ vscode claudecode ];
    homeManager = { pkgs, ... }: {
      programs.git.enable = true;
      programs.jujutsu = {
        enable = true;
        settings.user = {
          email = "pierre-godard@users.noreply.github.com";
          name = "Pierre Godard";
        };
      };
      programs.jjui.enable = true;
    };
  };
}

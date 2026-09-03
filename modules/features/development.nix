{ den, ... }: {
  den.aspects.development = {
    includes = with den.aspects; [ vscode claudecode git ];
    homeManager = { config, pkgs, ... }: {
      programs.jujutsu = {
        enable = true;
        settings.user = {
          name = config.user.name;
          email = config.user.email;
        };
      };
      programs.jjui.enable = true;
    };
  };
}

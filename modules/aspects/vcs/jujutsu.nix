# Jujutsu VCS configuration with identity injection
{ den, ... }:
{
  den.aspects.jujutsu = {
    includes = [ den.aspects.identity ];
    homeManager =
      { config, ... }:
      {
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

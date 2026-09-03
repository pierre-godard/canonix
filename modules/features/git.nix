# modules/features/git.nix
# Git configuration with identity injection
{ den, ... }:
{
  den.aspects.git = {
    includes = [ den.aspects.identity ];
    homeManager =
      { config, ... }:
      {
        programs.git = {
          enable = true;
          settings = {
            aliases = {
              co = "checkout";
              br = "branch";
              ci = "commit";
              st = "status";
              lg = "log --oneline --graph --decorate";
            };
            user = {
              name = config.user.name;
              email = config.user.email;
            };
          };
        };
      };
  };
}

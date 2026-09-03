# modules/features/identity.nix
# Shared user identity options, consumed by git.nix. Values are set per-home
# (see modules/homes/pierre.nix, modules/homes/nixos.nix).
{ ... }:
{
  den.aspects.identity.homeManager =
    { lib, ... }:
    {
      options.user = {
        name = lib.mkOption {
          type = lib.types.str;
          description = "User full name for Git and other tools";
        };

        email = lib.mkOption {
          type = lib.types.str;
          description = "User email address for Git and other tools";
        };
      };
    };
}

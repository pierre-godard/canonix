# modules/features/zellij.nix
# Zellij terminal multiplexer
{ ... }:
{
  den.aspects.zellij.homeManager =
    { ... }:
    {
      programs.zellij = {
        enable = true;
        extraConfig = ''
          show_startup_tips false
        '';
      };
    };
}

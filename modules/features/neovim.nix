# modules/features/neovim.nix
# Neovim as an editor option alongside Helix
{ ... }:
{
  den.aspects.neovim.homeManager =
    { config, lib, ... }:
    {
      programs.neovim = {
        enable = true;
        vimAlias = true;
      };
    };
}

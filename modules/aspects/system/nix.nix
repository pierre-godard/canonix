# Nix tooling
{ ... }:
{
  den.aspects.nix.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nil
        nixfmt
        statix
        deadnix
      ];
    };
}

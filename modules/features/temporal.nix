# modules/features/temporal.nix
# Temporal CLI tooling
{ ... }:
{
  den.aspects.temporal.homeManager =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        temporal-cli
      ];
    };
}

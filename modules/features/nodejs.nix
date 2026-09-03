# modules/features/nodejs.nix
# Node.js tooling
{ ... }:
{
  den.aspects.nodejs.homeManager =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        nodejs_24
      ];
    };
}

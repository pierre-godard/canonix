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

      nix.package = pkgs.nix;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
}

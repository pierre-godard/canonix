# 1Password CLI
{ ... }:
{
  den.aspects._1password.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs._1password-cli ];
    };
}

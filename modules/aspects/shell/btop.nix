# btop system monitor
{ ... }:
{
  den.aspects.btop.homeManager =
    { config, lib, ... }:
    {
      programs.btop.enable = true;
    };
}

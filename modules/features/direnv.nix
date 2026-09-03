# modules/features/direnv.nix
# Direnv and nix-direnv integration
{ ... }:
{
  den.aspects.direnv.homeManager =
    { config, ... }:
    {
      programs.direnv = {
        enable = true;
        enableFishIntegration = config.programs.fish.enable;
        nix-direnv.enable = true;
      };

      home.file.".envrc".text = "";
    };
}

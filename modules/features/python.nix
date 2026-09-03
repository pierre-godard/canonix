# modules/features/python.nix
# Python tooling configuration
{ ... }:
{
  den.aspects.python.homeManager =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.pyenv = {
        enable = true;
        enableFishIntegration = config.programs.fish.enable;
      };

      # UV_KEYRING_PROVIDER=subprocess makes uv shell out to `keyring` for
      # authenticated indexes, same GCP Artifact Registry backend poetry uses.
      home.packages = [
        (pkgs.python3.withPackages (
          ps: with ps; [
            keyring
            keyrings-google-artifactregistry-auth
            debugpy
          ]
        ))
      ];
      home.sessionVariables.UV_KEYRING_PROVIDER = "subprocess";

      programs.uv = {
        enable = true;
      };

      programs.poetry = {
        enable = true;
        package = pkgs.poetry.withPlugins (_: [ pkgs.poetry.python.pkgs.keyrings-google-artifactregistry-auth ]);
      };
    };
}

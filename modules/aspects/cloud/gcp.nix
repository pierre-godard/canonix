# Google Cloud SDK
{ ... }:
{
  den.aspects.gcp.homeManager =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        (google-cloud-sdk.withExtraComponents [
          google-cloud-sdk.components.gke-gcloud-auth-plugin
        ])
      ];
    };
}

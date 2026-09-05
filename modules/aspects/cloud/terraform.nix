{ ... }:
{
  den.aspects.terraform.homeManager =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        terraform-ls
        terraform
      ];
    };
}

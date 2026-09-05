# Go tooling configuration
{ ... }:
{
  den.aspects.go.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        golangci-lint
        gopls
        mockgen
        gotestsum
        delve
      ];

      programs.go.enable = true;
    };
}

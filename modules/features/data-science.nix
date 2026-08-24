{ den, ... }: {
  den.aspects.data-science = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        uv
        go
        rustup
        opentofu
      ];
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}

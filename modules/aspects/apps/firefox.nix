{ inputs, den, ... }: {
  den.aspects.firefox = {
    nixos = { ... }: {
      nixpkgs.overlays = [ inputs.nur.overlays.default ];
    };
    homeManager = { pkgs, ... }: {
      programs.firefox = {
        enable = true;
        profiles.default = {
          extensions = {
            force = true;
            packages = [
              pkgs.nur.repos.rycee.firefox-addons.proton-pass
            ];
          };
        };
      };
    };
  };
}

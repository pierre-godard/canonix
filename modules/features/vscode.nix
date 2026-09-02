{ den, ... }: {
  den.aspects.vscode = {
    nixos = { ... }: {
      programs.nix-ld.enable = true;
    };
    homeManager = { ... }: {
      programs.vscode.enable = true;
    };
  };
}

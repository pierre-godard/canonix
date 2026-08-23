{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    home-manager.url = "github:nix-community/home-manager";

    catppuccin.url = "github:catppuccin/nix";

    sops-nix.url = "github:Mic92/sops-nix";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    den.url = "github:denful/den";
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    {inherit inputs;}
    (inputs.import-tree ./modules);
}

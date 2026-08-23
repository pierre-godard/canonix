{ inputs, den, ... }: {
  flake.nixosModules.catppuccin = { ... }: {
    imports = [ inputs.catppuccin.nixosModules.catppuccin ];
    catppuccin = { flavor = "mocha"; enable = true; autoEnable = true; };
  };

  flake.homeModules.catppuccin = { ... }: {
    imports = [ inputs.catppuccin.homeModules.catppuccin ];
    catppuccin = { flavor = "mocha"; enable = true; autoEnable = true; };
  };

  den.aspects.catppuccin = {
    nixos = { ... }: {
      imports = [ inputs.catppuccin.nixosModules.catppuccin ];
      catppuccin = { flavor = "mocha"; enable = true; autoEnable = true; };
    };
    homeManager = { ... }: {
      imports = [ inputs.catppuccin.homeModules.catppuccin ];
      catppuccin = { flavor = "mocha"; enable = true; autoEnable = true; };
    };
  };
}

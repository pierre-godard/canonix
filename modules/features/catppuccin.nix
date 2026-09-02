{ inputs, den, ... }: {
  den.aspects.catppuccin = {
    nixos = { ... }: {
      imports = [ inputs.catppuccin.nixosModules.catppuccin ];
      catppuccin = { flavor = "mocha"; enable = true; autoEnable = true; };
    };
    homeManager = { pkgs, ... }: {
      imports = [ inputs.catppuccin.homeModules.catppuccin ];
      catppuccin = { flavor = "mocha"; enable = true; autoEnable = true; };
      gtk.enable = true;
      home.pointerCursor = {
        package = pkgs.catppuccin-cursors.mochaDark;
        name = "catppuccin-mocha-dark-cursors";
        size = 24;
        gtk.enable = true;
      };
    };
  };
}

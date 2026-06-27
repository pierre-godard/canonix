{ self, inputs, ... }: {
    flake.nixosModules.catppuccin = { pkgs, lib, ... }: {
      imports = [
        inputs.catppuccin.nixosModules.catppuccin
      ];
      catppuccin = {
        flavor = "mocha";
        enable = true;
        autoEnable = true;
      };
    };

    flake.homeModules.catppuccin = { pkgs, lib, ... }: {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
      ];
      catppuccin = {
        flavor = "mocha";
        enable = true;
        autoEnable = true;
      };
    };

}

{ self, inputs, ... }: {

  flake.homeModules.sops = { pkgs, lib, config, ... }: {
    imports = [
      inputs.sops-nix.homeManagerModules.sops
    ];

    sops = {
      defaultSopsFile = ./secrets.enc.yaml;
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };
  };

  flake.nixosModules.sops = { config, lib, pkgs, ... }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops = {
      defaultSopsFile = ./secrets.enc.yaml;
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };
  };

}

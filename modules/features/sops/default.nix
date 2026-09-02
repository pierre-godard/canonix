{ inputs, den, ... }: {
  den.aspects.sops = {
    nixos = { ... }: {
      imports = [ inputs.sops-nix.nixosModules.sops ];
      sops = {
        defaultSopsFile = ./secrets.enc.yaml;
        age.keyFile = "/root/.config/sops/age/keys.txt";
      };
    };
    homeManager = { config, ... }: {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];
      sops = {
        defaultSopsFile = ./secrets.enc.yaml;
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    };
  };
}

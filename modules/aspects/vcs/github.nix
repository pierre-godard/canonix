{ inputs, den, ... }: {
  den.aspects.github = {
    homeManager = { config, ... }: {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];
      sops = {
        defaultSopsFile = ../sops/secrets.enc.yaml;
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
        secrets.ssh_private_key.path = "${config.home.homeDirectory}/.ssh/github_pierre-godard";
      };
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings."*" = {
          PasswordAuthentication = false;
          ChallengeResponseAuthentication = false;
          PubkeyAuthentication = true;
        };
        extraConfig = ''
          Host github.com
            HostName github.com
            User git
            IdentityFile ~/.ssh/github_pierre-godard
            IdentitiesOnly yes
        '';
      };
    };
  };
}

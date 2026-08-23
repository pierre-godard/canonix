{ den, ... }: {
  flake.homeModules.ssh = { ... }: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*" = {
        PasswordAuthentication = false;
        ChallengeResponseAuthentication = false;
        StrictHostKeyChecking = "yes";
        PubkeyAuthentication = true;
      };
    };
  };

  den.aspects.ssh = {
    homeManager = { ... }: {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings."*" = {
          PasswordAuthentication = false;
          ChallengeResponseAuthentication = false;
          StrictHostKeyChecking = "yes";
          PubkeyAuthentication = true;
        };
      };
    };
  };
}

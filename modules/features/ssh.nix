{ self, inputs, ... }: {

  flake.homeModules.ssh = { pkgs, lib, config, ... }: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          PasswordAuthentication = false;
          ChallengeResponseAuthentication = false;
          StrictHostKeyChecking = "yes";
          PubkeyAuthentication = true;
        };
      };
    };
  };
}

{ self, inputs, ... }: {

  flake.homeModules.github = { pkgs, lib, config, ... }: {
    imports = [
      self.homeModules.sops
      self.homeModules.ssh
    ];

    sops.secrets.ssh_private_key = {
      path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    };

    programs.ssh.extraConfig = ''
      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes
    '';
  };
}

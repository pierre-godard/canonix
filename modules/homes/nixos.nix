{ den, ... }: {
  den.aspects.nixos = {
    includes = with den.aspects; [
      catppuccin
      shell
      vscode
      claudecode
      git
      jujutsu
      github
      direnv
      zellij
      neovim
      btop
    ];
    nixos = { pkgs, ... }: {
      users.users.nixos = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [ "wheel" ];
      };
    };
    homeManager = { ... }: {
      home.stateVersion = "26.05";
      user.name = "Pierre Godard";
      user.email = "pierre-godard@users.noreply.github.com";
    };
  };
}

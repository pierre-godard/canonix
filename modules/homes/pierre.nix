{ den, ... }: {
  den.aspects.pierre = {
    includes = with den.aspects; [
      catppuccin
      shell
      vscode
      claudecode
      git
      jujutsu
      github
      keyboard
      direnv
      zellij
      neovim
      btop
      den.batteries.host-aspects
    ];
    nixos = { pkgs, ... }: {
      users.users.pierre = {
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

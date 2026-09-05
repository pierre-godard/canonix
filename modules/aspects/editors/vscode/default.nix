# VSCode configuration with profile-based extension management
{ ... }:
{
  den.aspects.vscode = {
    nixos = { ... }: {
      programs.nix-ld.enable = true;
    };
    homeManager =
      {
        config,
        pkgs,
        ...
      }:
      let
        # nix4vscode.forVscode and the --no-sandbox override are only needed on
        # midgard (non-NixOS); NixOS hosts get the overlay-free system package.
        nonNixOS = pkgs ? nixgl;
        assetsPath = builtins.toString ./assets;
      in
      {
        home.packages = with pkgs; [
          meslo-lgs-nf
        ];

        programs.vscode = {
          enable = true;
          # --no-sandbox workaround for Ubuntu 24.04's hardened kernel
          # See: https://tamim.blog/post/fix-appimage-sandbox-issues-ubuntu-24-04/
          package = if nonNixOS then pkgs.vscode.override { commandLineArgs = "--no-sandbox"; } else pkgs.vscode;
          mutableExtensionsDir = false;
          profiles =
            let
              default_extensions = [
                "anthropic.claude-code"
                "Catppuccin.catppuccin-vsc"
                "ms-vscode-remote.remote-ssh-edit"
                "ms-vscode-remote.remote-ssh"
                "MS-vsliveshare.vsliveshare"
                "visualjj.visualjj"
                "vivaxy.vscode-conventional-commits"
              ];
              settings = config.lib.file.mkOutOfStoreSymlink "${assetsPath}/vscode-settings.json";
              keybindings = config.lib.file.mkOutOfStoreSymlink "${assetsPath}/vscode-keybindings.json";
              # nix4vscode overlay is applied both on midgard's custom pkgs and
              # system-wide for NixOS hosts, see common.nix.
              forVscode = pkgs.nix4vscode.forVscode;
            in
            {
              default = {
                extensions = forVscode default_extensions;
                userSettings = settings;
                keybindings = keybindings;
              };
              Golang = {
                extensions = forVscode (
                  [
                    "golang.go"
                    "DrBlury.protobuf-vsc"
                  ]
                  ++ default_extensions
                );
                userSettings = settings;
                keybindings = keybindings;
              };
              Nix = {
                extensions = forVscode (
                  [
                    "jnoortheen.nix-ide"
                  ]
                  ++ default_extensions
                );
                userSettings = settings;
                keybindings = keybindings;
              };
              Terraform = {
                extensions = forVscode (
                  [
                    "hashicorp.terraform"
                  ]
                  ++ default_extensions
                );
                userSettings = settings;
                keybindings = keybindings;
              };
              Python = {
                extensions = forVscode (
                  [
                    "charliermarsh.ruff"
                    "marimo-team.vscode-marimo"
                    "ms-python.debugpy"
                    "ms-python.mypy-type-checker"
                    "ms-python.python"
                    "ms-python.vscode-pylance"
                    "ms-toolsai.datawrangler"
                    "ms-toolsai.jupyter-keymap"
                    "ms-toolsai.jupyter-renderers"
                    "ms-toolsai.jupyter"
                    "ms-toolsai.vscode-jupyter-cell-tags"
                    "njpwerner.autodocstring"
                    "rust-lang.rust-analyzer"
                    "shinichi-takii.sql-bigquery"
                  ]
                  ++ default_extensions
                );
                userSettings = settings;
                keybindings = keybindings;
              };
            };
        };
      };
  };
}

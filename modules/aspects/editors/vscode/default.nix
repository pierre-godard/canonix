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
        lib,
        pkgs,
        ...
      }:
      let
        # nix4vscode.forVscode is only needed on midgard (non-NixOS); NixOS
        # hosts get the overlay-free system package.
        nonNixOS = pkgs ? nixgl;
        assetsPath = builtins.toString ./assets;
      in
      {
        home.packages = with pkgs; [
          meslo-lgs-nf
        ];

        # bin/code execs the package's own bundled `.code-wrapped` binary
        # (see `cat ${pkgs.vscode}/bin/code`) — that's the sandboxed process.
        # Restores VSCode's sandbox on Ubuntu 24.04's hardened kernel instead
        # of disabling it with --no-sandbox.
        home.activation = lib.mkIf nonNixOS (
          import ../../../_lib/apparmor-userns.nix {
            inherit pkgs lib;
            name = "code-wrapped";
            binPathGlob = "/nix/store/*-vscode-*/bin/.code-wrapped";
          }
        );

        programs.vscode = {
          enable = true;
          package = pkgs.vscode;
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

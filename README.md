# Canonix

A modular NixOS + home-manager configuration built with [den](https://den.denful.dev/) (aspect-oriented framework), [flake-parts](https://flake.parts/), and [import-tree](https://github.com/vic/import-tree).

## Hosts

| Host | Realm | Purpose | Kind | Notable aspects |
|---|---|---|---|---|
| `utgard` | Stronghold of challenges | Old ASUS ROG — LAN gaming | NixOS | desktop · laptop · gaming · catppuccin |
| `bifrost` | The bridge between worlds | NixOS-WSL — daily dev env | NixOS-WSL | locale · shell |
| `midgard` | The human realm | Ubuntu work laptop — data science | home-manager only | data-science |
| `yggdrasil` | The world tree | Home server — K3S cluster | NixOS | kubernetes |

## Structure

```
modules/
├── den.nix          # Host and standalone-home declarations
├── parts.nix        # Flake-parts wiring (home-manager module)
├── _lib/            # Shared helpers (e.g. nixGL wrapper)
├── aspects/         # Reusable den aspects, grouped by domain
│   ├── apps/          # firefox · ghostty · nautilus · obsidian
│   ├── cloud/          # gcp · kubernetes · terraform · container
│   ├── desktop/        # niri · greetd · plymouth · dms-shell · keyboard · keyring (composite)
│   ├── editors/        # vscode · neovim · claude-code
│   ├── gaming/         # beyond-all-reason · minecraft (composite)
│   ├── hardware/       # bluetooth · networking · power · laptop (composite)
│   ├── languages/      # go · nodejs · python · rust
│   ├── shell/          # fish · nushell · starship · helix · navi · zellij · btop
│   ├── sops/           # sops-nix age encryption
│   ├── system/         # common · nix · locale · direnv · temporal · catppuccin · identity
│   └── vcs/            # git · jujutsu · github (SSH key via sops)
├── hosts/
│   ├── utgard/            # LAN gaming laptop (NVIDIA Prime · asusd · supergfxd)
│   ├── bifrost/           # NixOS-WSL
│   └── yggdrasil/         # Home server
└── homes/
    ├── pierre.nix         # Base user aspect
    ├── nixos.nix          # WSL system user aspect
    └── midgard.nix        # Standalone home-manager (Ubuntu)
```

## Setup

### Prerequisites

- Nix with flakes enabled (`nix-command` and `flakes` experimental features)
- For WSL: [NixOS-WSL](https://github.com/nix-community/NixOS-WSL)
- For Ubuntu (midgard): [home-manager](https://nix-community.github.io/home-manager/) standalone

### Secrets (sops-nix)

This repo uses [sops-nix](https://github.com/Mic92/sops-nix) with age encryption.

Place your age private key at `~/.config/sops/age/keys.txt` before activating any configuration.

### Hardware configs (rog · yggdrasil)

The `hardware.nix` files in `hosts/utgard/` and `hosts/yggdrasil/` contain placeholder filesystem and bootloader values. Replace them with the output of `nixos-generate-config` on the actual hardware before deploying.

## Activating

```sh
# NixOS hosts
sudo nixos-rebuild switch --flake github:pierre-godard/canonix#utgard
sudo nixos-rebuild switch --flake github:pierre-godard/canonix#bifrost
sudo nixos-rebuild switch --flake github:pierre-godard/canonix#yggdrasil

# Ubuntu work laptop (standalone home-manager)
home-manager switch --flake 'github:pierre-godard/canonix#pierre@midgard'
```

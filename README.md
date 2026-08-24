# Canonix

A modular NixOS + home-manager configuration built with [den](https://den.denful.dev/) (aspect-oriented framework), [flake-parts](https://flake.parts/), and [import-tree](https://github.com/vic/import-tree).

## Hosts

| Host | Kind | Users | Notable aspects |
|---|---|---|---|
| `rog` | NixOS — ASUS ROG gaming laptop | pierre | desktop · laptop · gaming · catppuccin |
| `wsl` | NixOS-WSL — dev environment | nixos · pierre | locale · shell |
| `jotunheim` | NixOS — home server | pierre | kubernetes (K3S) |
| `midgard` | Ubuntu — home-manager only | pierre | data-science |

## Structure

```
modules/
├── den.nix          # Host and standalone-home declarations
├── parts.nix        # Flake-parts wiring (home-manager module)
├── features/        # Reusable den aspects
│   ├── bluetooth.nix
│   ├── catppuccin.nix
│   ├── data-science.nix   # uv · go · rustup · opentofu · direnv
│   ├── desktop.nix        # niri + greetd (composite)
│   ├── development.nix    # git · jj · claude-code · jjui
│   ├── firefox.nix
│   ├── gaming.nix         # zen kernel · Steam · Proton-GE · gamemode · gamescope
│   ├── ghostty.nix
│   ├── github.nix         # SSH key via sops
│   ├── greetd.nix         # tuigreet → niri-session
│   ├── kubernetes.nix     # K3S · kubectl · helm · k9s
│   ├── laptop.nix         # bluetooth + networking + power (composite)
│   ├── locale.nix         # timezone · i18n
│   ├── networking.nix     # NetworkManager
│   ├── niri.nix
│   ├── power.nix          # power-profiles-daemon
│   ├── shell/             # fish · nushell · starship · helix · navi
│   ├── sops/              # sops-nix age encryption
│   └── ssh.nix
├── hosts/
│   ├── rog/               # Gaming laptop (NVIDIA Prime · asusd · supergfxd)
│   ├── wsl/               # NixOS-WSL
│   └── jotunheim/         # Home server
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

### Hardware configs (rog · jotunheim)

The `hardware.nix` files in `hosts/rog/` and `hosts/jotunheim/` contain placeholder filesystem and bootloader values. Replace them with the output of `nixos-generate-config` on the actual hardware before deploying.

## Activating

```sh
# NixOS hosts
sudo nixos-rebuild switch --flake github:pierre-godard/canonix#rog
sudo nixos-rebuild switch --flake github:pierre-godard/canonix#wsl
sudo nixos-rebuild switch --flake github:pierre-godard/canonix#jotunheim

# Ubuntu work laptop (standalone home-manager)
home-manager switch --flake 'github:pierre-godard/canonix#pierre@midgard'
```

# Canonix

A modular NixOS flake configuration following the dendritic pattern (from Vimjoyer), built with flake-parts and home-manager.

## Structure

```
canonix/
├── flake.nix       # Entry point — inputs and outputs
├── flake.lock      # Locked dependencies
├── modules/
│   ├── parts.nix   # Flake-parts setup (systems, home-manager)
│   ├── features/   # Feature modules (sops, github, shell, niri, …)
│   ├── hosts/      # Host-specific configurations (wsl)
│   └── homes/      # Home-manager user configs (nixos, pierre)
└── README.md
```

## Features

- **Flake-based** — using flake-parts for modularity, import-tree for auto-discovery
- **Home-manager** — declarative user configuration
- **Sops-nix** — encrypted secrets with age encryption

## Setup

### Prerequisites

- NixOS (or Nix on any Linux) with flakes enabled (`nix-command` and `flakes` experimental features)
- For WSL: NixOS-WSL

### First-time setup: sops-nix

This repo uses sops-nix with age encryption for managing secrets.

**1. Retrieve your age key**

Retrieve your age key from wherever you store it (e.g. a password manager).

**2. Place it at the expected path**

Copy or symlink your key to `~/.config/sops/age/keys.txt` so sops-nix can find it during activation.

## Building from GitHub

```sh
# Replace <host> with your host configuration name (e.g. wsl)
sudo nixos-rebuild switch --flake github:pierre-godard/canonix#<host>
```

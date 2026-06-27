# Canonix NixOS Configuration Repository

## Overview

This repository contains a NixOS configuration flake for managing systems using Nix flakes and flake-parts. The configuration is designed to work with WSL (Windows Subsystem for Linux) and includes custom modules for window management and shell configurations.

## Repository Structure

```
canonix/
├── flake.nix              # Main flake configuration
├── flake.lock             # Locked dependencies
├── modules/
│   ├── parts.nix          # Flake-parts configuration
│   ├── features/          # Feature modules
│   │   ├── niri.nix        # Niri window manager configuration
│   │   └── noctalia.nix    # Noctalia shell configuration
│   └── hosts/             # Host-specific configurations
│       └── wsl/           # WSL-specific configuration
│           ├── configuration.nix  # Main WSL configuration
│           ├── default.nix        # WSL flake configuration
│           └── hardware.nix       # Hardware-specific settings
└── AGENTS.md              # This file
```

## Key Components

### Flake Configuration

- **flake.nix**: The main entry point that defines inputs and outputs using flake-parts
- **Inputs**:
  - `nixpkgs`: NixOS unstable channel
  - `flake-parts`: For modular flake management
  - `import-tree`: For importing module directories
  - `wrapper-modules`: For creating wrapped packages with custom configurations

### Modules

#### Feature Modules

1. **niri.nix**: Configures the Niri window manager
   - Enables Niri with custom keybindings
   - Uses `wrapper-modules` to create a custom Niri package with specific settings
   - Keybindings include Mod+Return for spawning ghostty terminal

2. **noctalia.nix**: Configures the Noctalia shell
   - Creates a custom Noctalia shell package using wrapper-modules
   - Currently has empty settings (placeholder for future configuration)

#### Host Modules

- **wsl/**: Windows Subsystem for Linux configuration
  - **default.nix**: Defines the WSL NixOS configuration in the flake
  - **configuration.nix**: Main WSL system configuration
    - Imports NixOS-WSL modules
    - Sets host platform to x86_64-linux
    - Enables WSL with default user "nixos"
    - System state version 26.05
  - **hardware.nix**: Placeholder for hardware-specific settings

## Build Systems

The flake supports the following systems:
- x86_64-linux
- x86_64-darwin
- aarch64-linux
- aarch64-darwin

## Usage

To use this configuration:

1. Ensure you have Nix with flakes support enabled
2. The configuration is designed for WSL but can be adapted for other systems
3. Customize the feature modules as needed for your specific requirements

## Customization Points

- Modify `modules/features/niri.nix` to change window manager settings
- Update `modules/features/noctalia.nix` to configure shell behavior
- Adjust `modules/hosts/wsl/configuration.nix` for WSL-specific settings
- Add new feature modules in the `m̑odules/features/` directory
- Add new host configurations in the `modules/hosts/` directory

## Dependencies

- Nix flakes
- flake-parts for modular flake management
- nix-wrapper-modules for creating wrapped packages
- NixOS-WSL for Windows Subsystem for Linux support

## Notes

- The configuration uses experimental Nix features (nix-command, flakes)
- The system state version is set to 26.05
- The default user for WSL is "nixos"

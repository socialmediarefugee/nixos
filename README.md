# NixOS Configurations

This repository contains my personal NixOS configurations. It uses flakes to manage the configurations for my different machines.

## Structure

The repository is structured as follows:

*   `flake.nix`: The main entry point for the flake.
*   `hosts`: Contains the configuration for each individual host.
*   `modules`: Contains shared NixOS modules that can be used by multiple hosts.
*   `packages`: Contains custom packages that are not in the main Nixpkgs repository.
*   `users`: Contains the user configurations.

## Usage

To use this repository, you can use the following command to build a specific host:

```bash
nixos-rebuild switch --flake .#<hostname>
```

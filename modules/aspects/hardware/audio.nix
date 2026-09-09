# ALSA/PipeWire user packages, for hosts with no NixOS-level PipeWire wiring (see gaming/default.nix)
{ ... }:
{
  den.aspects.audio = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.alsa-lib
        pkgs.alsa-utils
        pkgs.pipewire
      ];
    };
  };
}

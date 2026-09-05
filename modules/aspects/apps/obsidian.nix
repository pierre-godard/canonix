# Obsidian notes, nixGL-wrapped where the nixgl overlay is present (midgard only —
# NixOS hosts get OpenGL/Vulkan natively and never carry that overlay)
{ ... }:
{
  den.aspects.obsidian.homeManager =
    { lib, pkgs, ... }:
    let
      # No need to also substitute the package's bundled .desktop file: the
      # xdg.desktopEntries.obsidian entry below already writes a correctly
      # Exec=-pointed one to ~/.local/share/applications, which takes
      # priority per XDG_DATA_HOME precedence.
      obsidian-wrapped = import ../../_lib/nixgl-wrap.nix {
        inherit pkgs;
        package = pkgs.obsidian;
        binName = "obsidian";
      };
    in
    {
      programs.obsidian = {
        enable = true;
        package = obsidian-wrapped;
      };

      # bin/obsidian execs nixpkgs' shared `electron` binary directly (see
      # `cat ${pkgs.obsidian}/bin/obsidian`) — that's the sandboxed process,
      # not obsidian-wrapped itself.
      home.activation = lib.mkIf (pkgs ? nixgl) (
        import ../../_lib/apparmor-userns.nix {
          inherit pkgs lib;
          name = "electron";
          binPathGlob = "/nix/store/*-electron-*/bin/electron";
        }
      );

      # ~/.local/share/applications takes priority over ~/.nix-profile's per XDG_DATA_HOME precedence
      xdg.desktopEntries.obsidian = {
        name = "Obsidian";
        comment = "Knowledge base";
        exec = "${obsidian-wrapped}/bin/obsidian %u";
        icon = "obsidian";
        type = "Application";
        categories = [ "Office" ];
        mimeType = [ "x-scheme-handler/obsidian" ];
        settings = {
          StartupWMClass = "electron";
        };
      };
    };
}

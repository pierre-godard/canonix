# modules/features/obsidian.nix
# Obsidian notes, nixGL-wrapped where the nixgl overlay is present (midgard only —
# NixOS hosts get OpenGL/Vulkan natively and never carry that overlay)
{ ... }:
{
  den.aspects.obsidian.homeManager =
    { pkgs, ... }:
    let
      obsidian-base = pkgs.obsidian.override { commandLineArgs = "--no-sandbox"; };

      # No need to also substitute the package's bundled .desktop file: the
      # xdg.desktopEntries.obsidian entry below already writes a correctly
      # Exec=-pointed one to ~/.local/share/applications, which takes
      # priority per XDG_DATA_HOME precedence.
      obsidian-wrapped = import ../_lib/nixgl-wrap.nix {
        inherit pkgs;
        package = obsidian-base;
        binName = "obsidian";
      };
    in
    {
      programs.obsidian = {
        enable = true;
        package = obsidian-wrapped;
      };

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

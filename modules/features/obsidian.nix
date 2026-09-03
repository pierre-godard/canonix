# modules/features/obsidian.nix
# Obsidian notes, nixGL-wrapped where the nixgl overlay is present (midgard only —
# NixOS hosts get OpenGL/Vulkan natively and never carry that overlay)
{ ... }:
{
  den.aspects.obsidian.homeManager =
    { pkgs, ... }:
    let
      obsidian-base = pkgs.obsidian.override { commandLineArgs = "--no-sandbox"; };

      obsidian-wrapped =
        if pkgs ? nixgl then
          pkgs.symlinkJoin {
            name = "obsidian-wrapped";
            meta.mainProgram = "obsidian";
            paths = [ obsidian-base ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              rm $out/bin/obsidian
              makeWrapper ${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel $out/bin/obsidian \
                --add-flags "${obsidian-base}/bin/obsidian"

              rm $out/share/applications/obsidian.desktop
              substitute ${obsidian-base}/share/applications/obsidian.desktop $out/share/applications/obsidian.desktop \
                --replace-fail "Exec=obsidian" "Exec=$out/bin/obsidian"
            '';
          }
        else
          obsidian-base;
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

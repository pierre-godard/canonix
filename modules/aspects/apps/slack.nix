# Slack, nixGL-wrapped where the nixgl overlay is present (midgard only —
# NixOS hosts get OpenGL/Vulkan natively and never carry that overlay)
{ ... }:
{
  den.aspects.slack.homeManager =
    { lib, pkgs, ... }:
    let
      slack-wrapped = import ../../_lib/nixgl-wrap.nix {
        inherit pkgs;
        package = pkgs.slack;
        binName = "slack";
      };
    in
    {
      home.packages = [ slack-wrapped ];

      # bin/slack execs the package's own lib/slack/slack binary (see
      # `cat ${pkgs.slack}/bin/slack`) — that's the sandboxed process.
      home.activation = lib.mkIf (pkgs ? nixgl) (
        import ../../_lib/apparmor-userns.nix {
          inherit pkgs lib;
          name = "slack";
          binPathGlob = "/nix/store/*-slack-*/lib/slack/slack";
        }
      );

      # ~/.local/share/applications takes priority over ~/.nix-profile's per XDG_DATA_HOME precedence
      xdg.desktopEntries.slack = {
        name = "Slack";
        comment = "Slack Desktop";
        genericName = "Slack Client for Linux";
        exec = "${slack-wrapped}/bin/slack -s %U";
        icon = "slack";
        type = "Application";
        startupNotify = true;
        categories = [
          "GNOME"
          "GTK"
          "Network"
          "InstantMessaging"
        ];
        mimeType = [ "x-scheme-handler/slack" ];
        settings = {
          StartupWMClass = "Slack";
        };
      };
    };
}

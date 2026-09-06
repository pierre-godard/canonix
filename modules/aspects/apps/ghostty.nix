# Ghostty, nixGL-wrapped where the nixgl overlay is present (midgard only —
# NixOS hosts get OpenGL/Vulkan natively and never carry that overlay)
{ ... }: {
  den.aspects.ghostty = {
    homeManager =
      { pkgs, ... }:
      let
        ghostty-wrapped = import ../../_lib/nixgl-wrap.nix {
          inherit pkgs;
          package = pkgs.ghostty;
          binName = "ghostty";
        };
      in
      {
        programs.ghostty = {
          enable = true;
          package = ghostty-wrapped;
        };

        # ghostty's bundled .desktop sets DBusActivatable=true, which makes gnome-shell launch
        # it via its dbus-1/services/*.service file instead — that file hardcodes the original,
        # unwrapped store path, bypassing nixGL entirely. Override it (same filename, so it
        # shadows the package's via ~/.local/share precedence) without DBusActivatable, forcing
        # a plain exec of the wrapped binary.
        xdg.dataFile."applications/com.mitchellh.ghostty.desktop".text = ''
          [Desktop Entry]
          Version=1.0
          Name=Ghostty
          Type=Application
          Comment=A terminal emulator
          TryExec=${ghostty-wrapped}/bin/ghostty
          Exec=${ghostty-wrapped}/bin/ghostty --gtk-single-instance=true
          Icon=com.mitchellh.ghostty
          Categories=System;TerminalEmulator;
          Keywords=terminal;tty;pty;
          StartupNotify=true
          StartupWMClass=com.mitchellh.ghostty
          Terminal=false
          Actions=new-window;
          X-GNOME-UsesNotifications=true
          X-TerminalArgExec=-e
          X-TerminalArgTitle=--title=
          X-TerminalArgAppId=--class=
          X-TerminalArgDir=--working-directory=
          X-TerminalArgHold=--wait-after-command
          X-KDE-Shortcuts=Ctrl+Alt+T

          [Desktop Action new-window]
          Name=New Window
          Exec=${ghostty-wrapped}/bin/ghostty --gtk-single-instance=true
        '';
      };
  };
}

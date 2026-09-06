{ den, ... }: {
  den.aspects.keyboard = {
    nixos = { pkgs, ... }: {
      services.xserver.xkb.extraLayouts."us_qwerty-fr" = {
        description = "French QWERTY";
        languages = [ "fra" ];
        symbolsFile = "${pkgs.qwerty-fr}/share/X11/xkb/symbols/us_qwerty-fr";
      };
      services.xserver.xkb = {
        layout = "us_qwerty-fr";
        options = "lv3:caps_switch";
      };
      environment.variables = {
        XKB_DEFAULT_LAYOUT = "us_qwerty-fr";
        XKB_DEFAULT_OPTIONS = "lv3:caps_switch";
      };
    };

    homeManager = { pkgs, lib, ... }: {
      # No NixOS layer here to register services.xserver.xkb.extraLayouts
      # system-wide. A ~/.config/xkb/symbols file (libxkbcommon's documented
      # user search path) was tried and confirmed NOT picked up by GNOME's
      # keymap compilation on this Ubuntu/GNOME session (verified: the exact
      # same RMLVO compiles the accents fine standalone via `xkbcli
      # compile-keymap`, but the live session's keymap never gained them,
      # even across full logouts) — so instead use XKB's reserved "custom"
      # layout slot (xkeyboard-config(7): "aimed at systems ... where
      # additional lookup paths cannot easily be added"), which lives in the
      # system-wide path GNOME definitely already scans (every stock layout
      # loads from there). Needs a one-time root write; sudo only runs when
      # the installed content is actually out of date, same pattern as
      # ../../_lib/apparmor-userns.nix.
      home.activation.installCustomXkbLayout =
        let
          customSymbols = "${pkgs.qwerty-fr}/share/X11/xkb/symbols/us_qwerty-fr";
          installScript = pkgs.writeShellScript "install-custom-xkb-layout" ''
            set -euo pipefail
            find_bin() {
              for candidate in "$@"; do
                if [ -x "$candidate" ]; then
                  echo "$candidate"
                  return 0
                fi
              done
              return 1
            }
            sudo=$(find_bin /usr/bin/sudo /bin/sudo) || exit 0
            dest="/usr/share/xkeyboard-config-2/symbols/custom"
            if [ -f "$dest" ] && cmp -s "${customSymbols}" "$dest"; then
              exit 0
            fi
            echo "canonix: installing custom XKB layout at $dest (needs sudo)"
            "$sudo" install -Dm644 "${customSymbols}" "$dest"
          '';
        in
        lib.hm.dag.entryAfter [ "writeBoundary" ] "run ${installScript}";

      dconf.settings."org/gnome/desktop/input-sources" = {
        sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "custom" ]) ];
        xkb-options = [ "lv3:caps_switch" ];
      };
    };
  };
}

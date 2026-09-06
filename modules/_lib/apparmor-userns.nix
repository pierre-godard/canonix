# Grants a Nix-store Electron/Chromium binary permission to create
# unprivileged user namespaces via a scoped AppArmor profile, restoring its
# sandbox on Ubuntu 24.04+ (which blocks userns for unconfined binaries by
# default) instead of disabling sandboxing entirely with --no-sandbox.
#
# binPathGlob must match the *final* exec'd binary, not a wrapper script —
# trace the chain with e.g. `cat $(readlink -f $(which obsidian))` to find
# it, since AppArmor attaches to whatever actually calls unshare(CLONE_NEWUSER).
# A glob (not a literal path) is required because Nix store paths are
# content-addressed and change on every rebuild.
#
# Installing to /etc/apparmor.d and reloading needs root, which home-manager
# can't do directly: the activation script below shells out to sudo, but
# only when the checked-in profile differs from what's installed, so it
# stays a no-op (no password prompt) on every switch that isn't changing it.
#
# Underscore-prefixed dir so import-tree skips it: this is a plain helper
# function, not a den aspect/flake-parts module.
{
  pkgs,
  lib,
  name,
  binPathGlob,
}:
let
  profileFile = pkgs.writeText "apparmor-userns-${name}" ''
    abi <abi/4.0>,
    include <tunables/global>

    ${binPathGlob} flags=(unconfined) {
      userns,
      include if exists <local/${name}>
    }
  '';
  installScript = pkgs.writeShellScript "install-apparmor-userns-${name}" ''
    set -euo pipefail
    # home-manager's activate script strips PATH, so find these system binaries by absolute path
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
    apparmor_parser=$(find_bin /usr/sbin/apparmor_parser /sbin/apparmor_parser /usr/bin/apparmor_parser) || exit 0
    if [ "$(cat /sys/module/apparmor/parameters/enabled 2>/dev/null)" != "Y" ]; then
      exit 0
    fi
    dest="/etc/apparmor.d/${name}"
    if [ -f "$dest" ] && cmp -s "${profileFile}" "$dest"; then
      exit 0
    fi
    echo "canonix: installing AppArmor userns profile for ${name} (needs sudo)"
    "$sudo" install -Dm644 "${profileFile}" "$dest"
    "$sudo" "$apparmor_parser" -r "$dest"
  '';
in
{
  "apparmorUserns-${name}" = lib.hm.dag.entryAfter [ "writeBoundary" ] "run ${installScript}";
}

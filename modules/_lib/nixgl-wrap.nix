# Wraps `package`'s `binName` binary with nixGL, when the nixgl overlay is
# present (midgard only — NixOS hosts get OpenGL/Vulkan natively and never
# carry that overlay). Underscore-prefixed dir so import-tree skips it: this
# is a plain helper function, not a den aspect/flake-parts module.
{
  pkgs,
  package,
  binName,
  vendor ? "Intel",
}:
if pkgs ? nixgl then
  pkgs.symlinkJoin {
    name = "${binName}-wrapped";
    meta.mainProgram = binName;
    paths = [ package ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm $out/bin/${binName}
      makeWrapper ${pkgs.nixgl."nixGL${vendor}"}/bin/nixGL${vendor} $out/bin/${binName} \
        --add-flags "${package}/bin/${binName}"
    '';
  }
else
  package

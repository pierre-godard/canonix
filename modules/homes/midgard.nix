{ inputs, den, ... }:
let
  # nixGL-overlaid pkgs so GUI aspects (obsidian, zed, slack, vscode)
  # can render without a system-level OpenGL/Vulkan setup.
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    overlays = [ inputs.nixgl.overlay inputs.nix4vscode.overlays.default ];
  };
in
{
  den.homes.x86_64-linux."pierre@midgard" = {
    inherit pkgs;
    aspect = {
      includes = [
        den.aspects.pierre
        den.aspects.obsidian
      ];
      homeManager = { ... }: {
        home.username = "pierre";
        home.homeDirectory = "/home/pierre";
      };
    };
  };
}

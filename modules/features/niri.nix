{ self, inputs, den, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  den.aspects.niri = {
    nixos = { pkgs, lib, ... }: {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [ (lib.getExe self'.packages.myNoctalia) ];
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
        layout.gaps = 5;
        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.ghostty;

          # Focus — columns (horizontal)
          "Mod+H".focus-column-left = _: { };
          "Mod+Left".focus-column-left = _: { };
          "Mod+L".focus-column-right = _: { };
          "Mod+Right".focus-column-right = _: { };

          # Focus — windows within column, spills to workspace at edges
          "Mod+K".focus-window-or-workspace-up = _: { };
          "Mod+Up".focus-window-or-workspace-up = _: { };
          "Mod+J".focus-window-or-workspace-down = _: { };
          "Mod+Down".focus-window-or-workspace-down = _: { };

          # Move — columns
          "Mod+Ctrl+H".move-column-left = _: { };
          "Mod+Ctrl+Left".move-column-left = _: { };
          "Mod+Ctrl+L".move-column-right = _: { };
          "Mod+Ctrl+Right".move-column-right = _: { };

          # Move — windows within column, spills to workspace at edges
          "Mod+Ctrl+K".move-window-up-or-to-workspace-up = _: { };
          "Mod+Ctrl+Up".move-window-up-or-to-workspace-up = _: { };
          "Mod+Ctrl+J".move-window-down-or-to-workspace-down = _: { };
          "Mod+Ctrl+Down".move-window-down-or-to-workspace-down = _: { };

          # Mouse side buttons — column navigation
          "Mod+MouseBack".focus-column-left = _: { };
          "Mod+MouseForward".focus-column-right = _: { };

          # Scroll wheel — workspace (Mod up/down) and column (Shift+Mod up/down, or Mod left/right)
          "Mod+WheelScrollDown" = _: {
            props."cooldown-ms" = 150;
            content.focus-workspace-down = _: { };
          };
          "Mod+WheelScrollUp" = _: {
            props."cooldown-ms" = 150;
            content.focus-workspace-up = _: { };
          };
          "Mod+Shift+WheelScrollDown".focus-column-right = _: { };
          "Mod+Shift+WheelScrollUp".focus-column-left = _: { };
          "Mod+WheelScrollRight".focus-column-right = _: { };
          "Mod+WheelScrollLeft".focus-column-left = _: { };

          # Touchpad scroll — workspace (Mod up/down) and column (Shift+Mod up/down, or Mod left/right)
          "Mod+TouchpadScrollDown" = _: {
            props."cooldown-ms" = 150;
            content.focus-workspace-down = _: { };
          };
          "Mod+TouchpadScrollUp" = _: {
            props."cooldown-ms" = 150;
            content.focus-workspace-up = _: { };
          };
          "Mod+Shift+TouchpadScrollDown".focus-column-right = _: { };
          "Mod+Shift+TouchpadScrollUp".focus-column-left = _: { };
          "Mod+TouchpadScrollRight".focus-column-right = _: { };
          "Mod+TouchpadScrollLeft".focus-column-left = _: { };

          # Workspace — switch by number
        } // lib.listToAttrs (lib.map (n: {
          name = "Mod+${toString n}";
          value.focus-workspace = n;
        }) (lib.range 1 9))
          // lib.listToAttrs (lib.map (n: {
          name = "Mod+Ctrl+${toString n}";
          value.move-window-to-workspace = n;
        }) (lib.range 1 9));
      };
    };
  };
}

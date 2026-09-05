{ self, inputs, den, ... }: {
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
        input.keyboard.xkb = {
          layout = "us_qwerty-fr";
          options = "lv3:caps_switch";
        };
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
        layout = {
          gaps = 5;
          focus-ring.off = {};
        };
        binds = {

          # === Applications ===
          "Mod+T" = _: {
            props."hotkey-overlay-title" = "Open Terminal";
            content.spawn-sh = lib.getExe pkgs.ghostty;
          };
          "Mod+Ctrl+Return".spawn-sh = lib.getExe pkgs.fuzzel;
          "Mod+B".spawn-sh = lib.getExe pkgs.firefox;
          "Mod+E".spawn-sh = lib.getExe pkgs.nautilus;
          "Mod+Q".close-window = _: { };
          "Mod+Alt+L".spawn-sh = "loginctl lock-session";

          # === DMS Launchers ===
          "Mod+Space" = _: {
            props."hotkey-overlay-title" = "Application Launcher";
            content.spawn-sh = "dms ipc call spotlight toggle";
          };
          "Mod+V" = _: {
            props."hotkey-overlay-title" = "Clipboard Manager";
            content.spawn-sh = "dms ipc call clipboard toggle";
          };
          "Mod+M" = _: {
            props."hotkey-overlay-title" = "Task Manager";
            content.spawn-sh = "dms ipc call processlist focusOrToggle";
          };
          "Super+X" = _: {
            props."hotkey-overlay-title" = "Power Menu";
            content.spawn-sh = "dms ipc call powermenu toggle";
          };
          "Mod+Comma" = _: {
            props."hotkey-overlay-title" = "Settings";
            content.spawn-sh = "dms ipc call settings focusOrToggle";
          };
          "Mod+Y" = _: {
            props."hotkey-overlay-title" = "Browse Wallpapers";
            content.spawn-sh = "dms ipc call dankdash wallpaper";
          };
          "Mod+N" = _: {
            props."hotkey-overlay-title" = "Notification Center";
            content.spawn-sh = "dms ipc call notifications toggle";
          };
          "Mod+Shift+N" = _: {
            props."hotkey-overlay-title" = "Notepad";
            content.spawn-sh = "dms ipc call notepad toggle";
          };
          "Mod+Shift+W" = _: {
            props."hotkey-overlay-title" = "Window Rules";
            content.spawn-sh = "dms ipc call window-rules toggle";
          };
          "Ctrl+Shift+R" = _: {
            props."hotkey-overlay-title" = "Rename Workspace";
            content.spawn-sh = "dms ipc call workspace-rename open";
          };
          "Ctrl+Alt+Delete" = _: {
            props."hotkey-overlay-title" = "Task Manager";
            content.spawn-sh = "dms ipc call processlist focusOrToggle";
          };

          # === System & Overview ===
          "Mod+D" = _: { props."repeat" = false; content.toggle-overview = _: { }; };
          "Mod+Tab" = _: { props."repeat" = false; content.toggle-overview = _: { }; };
          "Mod+Shift+Slash".show-hotkey-overlay = _: { };
          "Mod+Escape" = _: {
            props."allow-inhibiting" = false;
            content.toggle-keyboard-shortcuts-inhibit = _: { };
          };
          "Mod+Shift+P".power-off-monitors = _: { };

          # === Window Management ===
          "Mod+F".maximize-column = _: { };
          "Mod+Shift+F".fullscreen-window = _: { };
          "Mod+Shift+T".toggle-window-floating = _: { };
          "Mod+Shift+V".switch-focus-between-floating-and-tiling = _: { };
          "Mod+W".toggle-column-tabbed-display = _: { };

          # === Layout & Sizing ===
          "Mod+R".switch-preset-column-width = _: { };
          "Mod+Shift+R".switch-preset-window-height = _: { };
          "Mod+Ctrl+R".reset-window-height = _: { };
          "Mod+C".center-column = _: { };
          "Mod+Ctrl+C".center-visible-columns = _: { };
          "Mod+Ctrl+F".expand-column-to-available-width = _: { };
          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          # === Consume / Expel ===
          "Mod+BracketLeft".consume-or-expel-window-left = _: { };
          "Mod+BracketRight".consume-or-expel-window-right = _: { };
          "Mod+Period".expel-window-from-column = _: { };

          # === Focus — window / column ===
          "Mod+H".focus-column-left = _: { };
          "Mod+Left".focus-column-left = _: { };
          "Mod+L".focus-column-right = _: { };
          "Mod+Right".focus-column-right = _: { };
          "Mod+K".focus-window-up = _: { };
          "Mod+Up".focus-window-up = _: { };
          "Mod+J".focus-window-down = _: { };
          "Mod+Down".focus-window-down = _: { };
          "Mod+Home".focus-column-first = _: { };
          "Mod+End".focus-column-last = _: { };

          # === Focus — workspace ===
          "Mod+I".focus-workspace-up = _: { };
          "Mod+Page_Up".focus-workspace-up = _: { };
          "Mod+U".focus-workspace-down = _: { };
          "Mod+Page_Down".focus-workspace-down = _: { };

          # === Focus — monitor (HJKL + L/R arrows; Up/Down arrows reserved for workspace move) ===
          "Mod+Ctrl+H".focus-monitor-left = _: { };
          "Mod+Ctrl+Left".focus-monitor-left = _: { };
          "Mod+Ctrl+L".focus-monitor-right = _: { };
          "Mod+Ctrl+Right".focus-monitor-right = _: { };
          "Mod+Ctrl+K".focus-monitor-up = _: { };
          "Mod+Ctrl+J".focus-monitor-down = _: { };

          # === Move — window / column ===
          "Mod+Shift+H".move-column-left = _: { };
          "Mod+Shift+Left".move-column-left = _: { };
          "Mod+Shift+L".move-column-right = _: { };
          "Mod+Shift+Right".move-column-right = _: { };
          "Mod+Shift+K".move-window-up = _: { };
          "Mod+Shift+Up".move-window-up = _: { };
          "Mod+Shift+J".move-window-down = _: { };
          "Mod+Shift+Down".move-window-down = _: { };
          "Mod+Ctrl+Home".move-column-to-first = _: { };
          "Mod+Ctrl+End".move-column-to-last = _: { };

          # === Move — to workspace ===
          "Mod+Ctrl+I".move-column-to-workspace-up = _: { };
          "Mod+Ctrl+Up".move-column-to-workspace-up = _: { };
          "Mod+Ctrl+U".move-column-to-workspace-down = _: { };
          "Mod+Ctrl+Down".move-column-to-workspace-down = _: { };

          # === Move — to monitor ===
          "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: { };
          "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = _: { };
          "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: { };
          "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = _: { };
          "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: { };
          "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = _: { };
          "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: { };
          "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = _: { };

          # === Move — workspace order ===
          "Mod+Shift+I".move-workspace-up = _: { };
          "Mod+Shift+Page_Up".move-workspace-up = _: { };
          "Mod+Shift+U".move-workspace-down = _: { };
          "Mod+Shift+Page_Down".move-workspace-down = _: { };

          # === Media Keys ===
          "XF86AudioRaiseVolume" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          };
          "XF86AudioLowerVolume" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          };
          "XF86AudioMute" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };
          "XF86AudioMicMute" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          };
          "XF86AudioPlay" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "${lib.getExe pkgs.playerctl} play-pause";
          };
          "XF86AudioPause" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "${lib.getExe pkgs.playerctl} play-pause";
          };
          "XF86AudioNext" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "${lib.getExe pkgs.playerctl} next";
          };
          "XF86AudioPrev" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "${lib.getExe pkgs.playerctl} previous";
          };
          "Ctrl+XF86AudioRaiseVolume" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "dms ipc call mpris increment 3";
          };
          "Ctrl+XF86AudioLowerVolume" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "dms ipc call mpris decrement 3";
          };

          # === Brightness ===
          "XF86MonBrightnessUp" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "dms ipc call brightness increment 5";
          };
          "XF86MonBrightnessDown" = _: {
            props."allow-when-locked" = true;
            content.spawn-sh = "dms ipc call brightness decrement 5";
          };

          # === Screenshots ===
          "Print".screenshot = _: { };
          "Ctrl+Print".screenshot-screen = _: { };
          "Alt+Print".screenshot-window = _: { };

          # === Scroll — workspace ===
          "Mod+WheelScrollDown" = _: {
            props."cooldown-ms" = 150;
            content.focus-workspace-down = _: { };
          };
          "Mod+WheelScrollUp" = _: {
            props."cooldown-ms" = 150;
            content.focus-workspace-up = _: { };
          };
          "Mod+TouchpadScrollDown" = _: {
            props."cooldown-ms" = 150;
            content.focus-workspace-down = _: { };
          };
          "Mod+TouchpadScrollUp" = _: {
            props."cooldown-ms" = 150;
            content.focus-workspace-up = _: { };
          };

          # === Scroll — column focus ===
          "Mod+WheelScrollRight".focus-column-right = _: { };
          "Mod+WheelScrollLeft".focus-column-left = _: { };
          "Mod+Shift+WheelScrollDown".focus-column-right = _: { };
          "Mod+Shift+WheelScrollUp".focus-column-left = _: { };
          "Mod+TouchpadScrollRight".focus-column-right = _: { };
          "Mod+TouchpadScrollLeft".focus-column-left = _: { };
          "Mod+Shift+TouchpadScrollDown".focus-column-right = _: { };
          "Mod+Shift+TouchpadScrollUp".focus-column-left = _: { };

          # === Scroll — column move ===
          "Mod+Ctrl+WheelScrollDown" = _: {
            props."cooldown-ms" = 150;
            content.move-column-to-workspace-down = _: { };
          };
          "Mod+Ctrl+WheelScrollUp" = _: {
            props."cooldown-ms" = 150;
            content.move-column-to-workspace-up = _: { };
          };
          "Mod+Ctrl+WheelScrollRight".move-column-right = _: { };
          "Mod+Ctrl+WheelScrollLeft".move-column-left = _: { };
          "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = _: { };
          "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = _: { };
          "Mod+Ctrl+TouchpadScrollRight".move-column-right = _: { };
          "Mod+Ctrl+TouchpadScrollLeft".move-column-left = _: { };
          "Mod+Ctrl+Shift+TouchpadScrollDown".move-column-right = _: { };
          "Mod+Ctrl+Shift+TouchpadScrollUp".move-column-left = _: { };

        } // lib.listToAttrs (lib.map (n: {
          name = "Mod+${toString n}";
          value.focus-workspace = n;
        }) (lib.range 1 9))
          // lib.listToAttrs (lib.map (n: {
          name = "Mod+Shift+${toString n}";
          value.move-column-to-workspace = n;
        }) (lib.range 1 9));
      };
    };
  };
}

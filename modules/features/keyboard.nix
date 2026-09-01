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
  };
}

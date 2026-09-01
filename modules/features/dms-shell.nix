{ den, ... }: {
  den.aspects.dms-shell = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.dms-shell pkgs.quickshell ];
      systemd.user.services.dms = {
        Unit = {
          Description = "DankMaterialShell";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.dms-shell}/bin/dms run --session";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
  };
}

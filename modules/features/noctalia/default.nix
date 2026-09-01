{ self, inputs, ... }: {
  perSystem = { pkgs, lib, ... }: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = lib.recursiveUpdate
        (builtins.fromJSON (builtins.readFile ./settings.json)).settings
        {
          wallpaper.directory = "${../../../assets}";
        };
    };
  };
}

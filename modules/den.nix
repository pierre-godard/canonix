{ inputs, lib, ... }: {
  imports = [
    inputs.den.flakeModule
  ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.hosts.x86_64-linux.wsl = {
    wsl.enable = true;
    users.nixos = { };
    users.pierre = { };
  };

  den.hosts.x86_64-linux.rog.users.pierre = { };
}

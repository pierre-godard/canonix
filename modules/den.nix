{ inputs, lib, ... }: {
  imports = [
    inputs.den.flakeModule
  ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.hosts.x86_64-linux.bifrost = {
    wsl.enable = true;
    users.nixos = { };
    users.pierre = { };
  };

  den.hosts.x86_64-linux.utgard.users.pierre = { };

  den.hosts.x86_64-linux.yggdrasil.users.pierre = { };
}

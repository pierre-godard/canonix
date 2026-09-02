{ den, ... }: {
  den.aspects.keyring = {
    nixos = { ... }: {
      services.gnome-keyring = {
        enable = true;
        components = [ "pkcs11" "secrets" "ssh" ];
      };
      security.pam.services.greetd.enableGnomeKeyring = true;
    };
  };
}

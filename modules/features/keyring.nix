{ den, ... }: {
  den.aspects.keyring = {
    nixos = { ... }: {
      services.gnome.gnome-keyring.enable = true;
      security.pam.services.greetd.enableGnomeKeyring = true;
    };
  };
}

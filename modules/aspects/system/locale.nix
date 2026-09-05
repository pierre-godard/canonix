{ den, ... }: {
  den.aspects.locale = {
    nixos = { ... }: {
      time.timeZone = "Europe/Paris";
      i18n.defaultLocale = "en_US.UTF-8";
    };
  };
}

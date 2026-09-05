{ den, ... }: {
  den.aspects.kubernetes = {
    nixos = { ... }: {
      services.k3s = {
        enable = true;
        role = "server";
      };
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 6443 ];
        allowedUDPPorts = [ 8472 ];
      };
    };
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        kubectl
        helm
        k9s
      ];
    };
  };
}

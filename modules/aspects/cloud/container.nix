# Podman, a rootless container engine with a Docker API-compatible socket
{ ... }:
{
  den.aspects.container.homeManager =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.podman
        pkgs.podman-compose
      ];

      # Convenience alias — podman implements the docker CLI closely enough
      # that muscle-memory `docker ...` invocations just work.
      home.shellAliases.docker = "podman";

      home.sessionVariables = {
        DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
      };

      systemd.user.sockets.podman = {
        Unit = {
          Description = "Podman API Socket";
          Documentation = "man:podman-system-service(1)";
        };
        Socket = {
          ListenStream = "%t/podman/podman.sock";
          SocketMode = "0660";
        };
        Install.WantedBy = [ "sockets.target" ];
      };

      systemd.user.services.podman = {
        Unit = {
          Description = "Podman API Service";
          Requires = [ "podman.socket" ];
          After = [ "podman.socket" ];
          StartLimitIntervalSec = 0;
        };
        Service = {
          Delegate = true;
          Type = "exec";
          KillMode = "process";
          ExecStart = "${pkgs.podman}/bin/podman system service";
        };
        Install.WantedBy = [ "default.target" ];
      };
    };
}

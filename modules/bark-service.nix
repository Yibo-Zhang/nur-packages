{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.barkServer;
in {
  options.services.barkServer = {
    enable = mkEnableOption "Bark Server";

    port = mkOption {
      type = types.int;
      default = 8080;
      example = 8080;
      description = "Port to listen on.";
    };

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/bark-server";
      description = "Directory where bark-server stores its data.";
    };

    package = mkOption {
      type = types.package;
      default = pkgs.bark-server;
      description = "The bark-server package to use.";
    };
  };

  config = mkIf cfg.enable {
    users.groups.barkserver = {};
    users.users.barkserver = {
      isSystemUser = true;
      group = "barkserver";
      home = cfg.dataDir;
      createHome = true;
    };

    systemd.services.barkServer = {
      description = "Bark Server";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/bark-server --addr 0.0.0.0:${toString cfg.port} --data ${cfg.dataDir}";
        Restart = "on-failure";
        User = "barkserver";
        Group = "barkserver";
        WorkingDirectory = cfg.dataDir;
      };
    };

    systemd.services.barkServer.preStart = ''
      mkdir -p ${cfg.dataDir}
      chown -R barkserver:barkserver ${cfg.dataDir}
    '';
  };
}

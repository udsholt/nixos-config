{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.services.disque;

    # Look at the sample config at:
    # https://github.com/antirez/disque/blob/master/disque.conf
    disqueConfig = pkgs.writeText "disque.conf" ''
        daemonize no
        pidfile   ${cfg.pidFile}
        port      ${toString cfg.port}
        dir       ${toString cfg.dataDir}

        ${cfg.extraConfig}
    '';
in

{
    options = {
        services.disque = {
            enable = mkOption {
                default = false;
                example = true;
                description = "Enable disque";
            };

            user = mkOption {
                type = types.str;
                default = "disque";
                description = ''
                    User account under which disque runs.
                '';
            };

            package = mkOption {
                type = types.package;
                default = pkgs.disque;
                description = ''
                    Which disque derivation to use.
                '';
            };

            port = mkOption {
                type = types.int;
                default = 7711;
                description = "The port for disque to listen to.";
            };

            pidFile = mkOption {
                type = types.path;
                default = "/var/lib/disque/disque.pid";
                description = "";
            };

            dataDir = mkOption {
                type = types.path;
                default = "/var/lib/disque";
                description = ''
                    Data directory for disque.
                '';
            };

            extraConfig = mkOption {
                default = "";
                description = "Extra configuration options for disque.conf";
                type = with types; string;
            };
        };
    };

    config = mkIf cfg.enable {
        users.extraUsers.disque = {
            name = cfg.user;
            description = "disque user";
        };

        environment.systemPackages = [
            cfg.package
        ];

        systemd.services.disque_init = {
            description = "disque server initialisation";

            wantedBy = [ "disque.service" ];
            before = [ "disque.service" ];

            serviceConfig.Type = "oneshot";

            script = ''
                if ! test -e ${cfg.dataDir}; then
                    install -d -m0700 -o ${cfg.user} ${cfg.dataDir}
                fi
            '';
        };

        systemd.services.disque = {
            description = "disque server";

            wantedBy = [ "multi-user.target" ];
            after = [ "network.target" ];

            serviceConfig = {
                ExecStart = "${cfg.package}/bin/disque-server ${disqueConfig}";
                User = cfg.user;
            };
        };
    };


    
}

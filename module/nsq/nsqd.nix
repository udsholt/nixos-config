{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.services.nsqd;

    nsqdConfig = pkgs.writeText "nsqd.conf" ''
        # path to store disk-backed messages
        data_path = "${toString cfg.dataDir}"

        # <addr>:<port> to listen on for HTTPS clients
        http-address = "${cfg.httpAddress}"

        # <addr>:<port> to listen on for TCP clients
        tcp_address = "${cfg.tcpAddress}"

        # cluster of nsqlookupd TCP addresses
        nsqlookupd_tcp_addresses = [ ${concatStringsSep ", " (map (host : ''"${host}"'') cfg.lookupdTcpAddresses) } ]

        # extra configuration
        ${cfg.extraConfig}
    '';
in

{
    options = {
        services.nsqd = {
            enable = mkOption {
                default = false;
                example = true;
                description = "Enable nsqd";
            };

            user = mkOption {
                type = types.str;
                default = "nsq";
                description = ''
                    User account under which nsqd runs.
                '';
            };

            package = mkOption {
                type = types.package;
                default = pkgs.nsq;
                description = ''
                    Which nsq derivation to use.
                '';
            };

            dataDir = mkOption {
                default = "/var/db/nsqd";
                description = ''
                    Data directory for nsqd.
                '';
            };

            httpAddress = mkOption {
                type = types.str;
                default = "0.0.0.0:4151";
                description = ''
                    <addr>:<port> to listen on for HTTP clients.
                '';
            };

            tcpAddress = mkOption {
                type = types.str;
                default = "0.0.0.0:4150";
                description = ''
                    <addr>:<port> to listen on for TCP clients.
                '';
            };

            lookupdTcpAddresses = mkOption {
                default = [ ];
                description = "Cluster of nsqlookupd TCP addresses";
                example = [ "127.0.0.1:4160" ];
            };

            extraConfig = mkOption {
                default = "";
                description = "Extra configuration options for nsqd.conf";
                type = with types; string;
            };
        };
    };

    config = mkIf cfg.enable {
        users.extraUsers.nsqd = {
            name = cfg.user;
            description = "nsqd user";
        };

        environment.systemPackages = [
            cfg.package
        ];

        systemd.services.nsqd_init = {
            description = "nsqd server initialisation";

            wantedBy = [ "nsqd.service" ];
            before = [ "nsqd.service" ];

            serviceConfig.Type = "oneshot";

            script = ''
                if ! test -e ${cfg.dataDir}; then
                    install -d -m0700 -o ${cfg.user} ${cfg.dataDir}
                fi
            '';
        };

        systemd.services.nsqd = {
            description = "nsqd server";

            wantedBy = [ "multi-user.target" ];
            after = [ "network.target" ];

            serviceConfig = {
                ExecStart = "${cfg.package}/bin/nsqd -config=${nsqdConfig}";
                User = cfg.user;
            };
        };
    };

}

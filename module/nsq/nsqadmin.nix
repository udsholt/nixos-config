{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.services.nsqadmin;

    nsqdHttpAddresses = concatStringsSep " " (map (host : ''-nsqd-http-address=${host}'') cfg.nsqdHttpAddresses);
    lookupdHttpAddresses = concatStringsSep " " (map (host : ''-lookupd-http-address=${host}'') cfg.lookupdHttpAddresses);
in

{
    options = {
        services.nsqadmin = {
            enable = mkOption {
                default = false;
                example = true;
                description = "Enable nsqadmin";
            };

            user = mkOption {
                type = types.str;
                default = "nsq";
                description = ''
                    User account under which nsqadmin runs.
                '';
            };

            package = mkOption {
                type = types.package;
                default = pkgs.nsq;
                description = ''
                    Which nsq derivation to use.
                '';
            };

            httpAddress = mkOption {
                type = types.str;
                default = "0.0.0.0:4171";
                description = ''
                    <addr>:<port> to listen on for HTTP clients.
                '';
            };

            nsqdHttpAddresses = mkOption {
                default = [ ];
                description = "Cluster of nsqlookupd TCP addresses";
                example = [ "127.0.0.1:4160" ];
            };

            lookupdHttpAddresses = mkOption {
                default = [ ];
                description = "Cluster of nsqlookupd TCP addresses";
                example = [ "127.0.0.1:4160" ];
            };
        };
    };

    config = mkIf cfg.enable {
        users.extraUsers.nsqadmin = {
            name = cfg.user;
            description = "nsqadmin user";
        };

        environment.systemPackages = [
            cfg.package
        ];

        systemd.services.nsqadmin = {
            description = "nsqadmin server";

            wantedBy = [ "multi-user.target" ];
            after = [ "network.target" ];

            serviceConfig = {
                ExecStart = ''${cfg.package}/bin/nsqadmin -http-address=${cfg.httpAddress} ${lookupdHttpAddresses} ${nsqdHttpAddresses}'';
                User = cfg.user;
            };
        };
    };

}

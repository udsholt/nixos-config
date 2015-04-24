{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.services.nsqlookupd;
in

{
    options = {
        services.nsqlookupd = {
            enable = mkOption {
                default = false;
                example = true;
                description = "Enable nsqlookupd";
            };
            
            user = mkOption {
                type = types.str;
                default = "nsq";
                description = ''
                    User account under which nsqlookupd runs.
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
                default = "0.0.0.0:4161";
                description = ''
                    <addr>:<port> to listen on for HTTP clients.
                '';
            };

            tcpAddress = mkOption {
                type = types.str;
                default = "0.0.0.0:4160";
                description = ''
                    <addr>:<port> to listen on for TCP clients.
                '';
            };
        };
    };

    config = mkIf cfg.enable {
        users.extraUsers.nsqlookupd = {
            name = cfg.user;
            description = "nsqlookupd user";
        };

        environment.systemPackages = [
            cfg.package
        ];

        systemd.services.nsqlookupd = {
            description = "nsqlookupd server";

            wantedBy = [ "multi-user.target" ];
            after = [ "network.target" ];

            serviceConfig = {
                ExecStart = ''${cfg.package}/bin/nsqlookupd -http-address=${cfg.httpAddress} -tcp-address=${cfg.tcpAddress}'';
                User = cfg.user;
            };
        };
    };
    
}

{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.services.beanstalkd;
in
{
    options = {
        services.beanstalkd = {
            enable = mkOption {
                default = false;
                example = true;
                description = "Enable beanstalkd";
            };

            user = mkOption {
                type = types.str;
                default = "beanstalkd";
                description = ''
                    User account under which beanstalkd runs.
                '';
            };

            package = mkOption {
                type = types.package;
                default = pkgs.beanstalkd;
                description = ''
                    Which beanstalkd derivation to use.
                '';
            };

            port = mkOption {
                type = types.int;
                default = 11300;
                description = "The port for beanstalkd to listen to.";
            };
        };
    };

    config = mkIf cfg.enable {

        users.extraUsers.beanstalkd = {
            name = cfg.user;
            description = "beanstalkd user";
        };

        environment.systemPackages = [
            cfg.package
        ];

        systemd.services.beanstalkd = {
            description = "beanstalkd server";

            wantedBy = [ "multi-user.target" ];
            after = [ "network.target" ];

            serviceConfig = {
                ExecStart = ''${cfg.package}/bin/beanstalkd -p ${toString cfg.port}'';
                User = cfg.user;
            };
        };
    };

}

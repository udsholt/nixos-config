{ config, pkgs, ... }:

{
    containers.database = {
        config = { config, pkgs, ... }: {
            services.mysql = {
                enable = true;
                package = pkgs.mysql;
                dataDir = "/var/lib/mysql";
                port = 3306;
                user = "mysql";
            };

            services.postgresql = {
                enable = true;
                package = pkgs.postgresql94;
                dataDir = "/var/lib/postgresql";
                port = 5432;
                authentication = ''
                    # Generated file; do not edit!
                    local all all                trust
                    host  all all 127.0.0.1/32   trust
                    host  all all ::1/128        trust
                    host  all all 192.168.1.0/24 trust
                '';
            };
            
            services.redis = {
                enable = true;
                dbpath = "/var/lib/redis";
                port = 6379;
                user = "redis";
            };
        };
    };
}

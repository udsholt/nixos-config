{ config, pkgs, ... }:

{
    containers.postgres = {
        config = { config, pkgs, ... }: {
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
        };
    };
}

{ config, pkgs, ... }:

{
    containers.redis = {
        config = { config, pkgs, ... }: {
            services.redis = {
                enable = true;
                dbpath = "/var/lib/redis";
                appendOnly = true;
                port = 6379;
                user = "redis";
            };
        };
    };
}

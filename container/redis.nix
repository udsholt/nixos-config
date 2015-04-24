{ config, pkgs, ... }:

{
    containers.redis = {
        config = { config, pkgs, ... }: {
            services.redis = {
                enable = true;
                dbpath = "/var/lib/redis";
                port = 6379;
                user = "redis";
            };
        };
    };
}
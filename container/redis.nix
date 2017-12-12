{ config, pkgs, ... }:

{
    containers.redis = {
        config = { config, pkgs, ... }: {
            services.redis = {
                enable = true;
                dbpath = "/var/lib/redis";
                port = 6379;
                user = "redis";

                # https://stackoverflow.com/questions/27681402/how-to-disable-redis-rdb
                appendOnly = true;
                save = [];
            };
        };
    };
}

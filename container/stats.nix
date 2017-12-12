{ config, pkgs, ... }:

{
    containers.stats = {
        config = { config, pkgs, ... }: {

            services.influxdb = {
                enable = true;
            };

            services.grafana = {
                enable = true;
                addr = "";
            };
        };
    };
}

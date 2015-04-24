{ config, pkgs, ... }:

{
    containers.nsq = {
        config = { config, pkgs, ... }: {

            require = [ ../module/nsq ];

            services.nsqd = {
                enable = true;
                httpAddress = "0.0.0.0:4151";
                tcpAddress = "0.0.0.0:4150";
                lookupdTcpAddresses = [
                    "127.0.0.1:4160"
                ];
            };

            services.nsqlookupd = {
                enable = true;
                httpAddress = "0.0.0.0:4161";
                tcpAddress = "0.0.0.0:4160";
            };

            services.nsqadmin = {
                enable = true;
                httpAddress = "0.0.0.0:4171";
                nsqdHttpAddresses = [];
                lookupdHttpAddresses = [
                    "127.0.0.1:4161"
                ];
            };
        };
    };
}
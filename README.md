# Nixos Configration


## Switching Channel

[Manual link](https://nixos.org/nixos/manual/#sec-upgrading)

See which channel is currently used:

    $ nix-channel --list | grep nixos
      nixos https://nixos.org/channels/nixos-unstable

Change channel with:

    $ nix-channel --add https://nixos.org/channels/nixos-17.09 nixos

Timesync issue when upgrading to 19.09: https://github.com/NixOS/nixpkgs/issues/31540

    rm -rf {/var/lib/systemd/timesync,/var/lib/private/systemd/timesync}

## Helpers

Jump to binary in nix store:

```bash
function nix-goto {
    cd $(dirname $(realpath $(which $1)))
}

```

Channel location:

/nix/var/nix/profiles/per-user/root/channels/nixos/pkgs

## Google Cloud SDK

Installing Google Cloud SDK should not be done through the nixos package as it is 
intended to be used for on GCE hosts.

But the python based tooling works fine with `pkgs.python`, and component installations
works fine.The java based tooling have not been tested yet.

Install as described in https://cloud.google.com/sdk/docs/quickstart-linux (or
https://cloud.google.com/sdk/docs/downloads-interactive).


## Problems

Git (over ssh) no longer working after upgrade to 19.03.
Add IPQoS=throughput to `ssh/config` for all hosts.
https://github.com/NixOS/nixpkgs/issues/50389


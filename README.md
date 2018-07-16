# Nixos Configration


## Switching Channel

[Manual link](https://nixos.org/nixos/manual/#sec-upgrading)

See which channel is currently used:

    $ nix-channel --list | grep nixos
      nixos https://nixos.org/channels/nixos-unstable

Change channel with:

    $ nix-channel --add https://nixos.org/channels/nixos-17.09 nixos


## Helpers

Jump to binary in nix store:

```bash
function nix-goto {
    cd $(dirname $(realpath $(which $1)))
}

```


Channel location:

/nix/var/nix/profiles/per-user/root/channels/nixos/pkgs


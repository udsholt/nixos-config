Package Notes
=============

Testing Packages
----------------

During package development it can make sense to nix expression which wraps the
package.

For example a file called `wrapper.nix` with the contents:

```nix
with import <nixpkgs> {}; {
    some-package-name = callPackage ./default.nix {};
}
```

The package can then be tested in a shell with:

    $ nix-shell wrapper.nix --pure -A some-package-name

This will drop you into a shell where the phases outlined in [Create and debug nix packages](https://nixos.org/wiki/Create_and_debug_nix_packages) can be run 
to build the package.

For example to fetch and unpack the source:

    $ unpackPhase
    $ cd $sourceRoot
    $ patchPhase
    $ configurePhase
    $ ...






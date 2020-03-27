# Reflex Workshop

## Development shell - Nix / NixOS

### Nix

Add something like this to your `nix.conf`:
```
substituters = https://cache.nixos.org/ https://nixcache.reflex-frp.org
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=
```

### NixOS

You'll want to add the reflex cache to `/etc/nix/configuration.nix`:
```
  nix.binaryCaches = [
    "https://nixcache.reflex-frp.org"
  ];
  nix.binaryCachePublicKeys = [
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
  ];
```
and then rebuild with `nixos-rebuild switch`.

### Shell

After that you'll want to run the `./dev.sh` and `hoogle server -p
9090 --local` commands from a nix-shell:

```
cd ~/reflex-workshop
nix-shell
```

## VirtualBox Appliance

`nix/vm.nix` is a nix expression that builds a VirtualBox
appliance. Now that the QFPL Hydra no longer exists, you will have to
build it yourself if you want it.

`nix build -f nix/vm.nix` will build the appliance, but be warned: it
will take a few hours and peak at about **25GiB** of disk usage. Mount
a large, empty directory over `/tmp` before building - your tmpfs
won't cut it.

## Getting set up

- Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Import the OVA into VirtualBox
  - The menu option should be something like: File > Import Appliance

## Editors and tools

The VirtualBox appliance comes with these text editors
  - `emacs`
  - `gedit`
  - `vim`
and these Haskell tools:
  - `cabal-install`
  - `ghcid`
  - `ghc-mod`
  - `hasktags`
  - `hindent`
  - `hlint`
  - `hoogle`
  - `stylish-haskell`

If you want to configure `vim` or `emacs` to your liking before the
workshop, go for it.

## Running the workshop

The workshop is run from within the VM

- Open a terminal
  - Run the workshop code under `ghcid`
    ```
    cd reflex-workshop
    ./dev.sh
    ```

- Open Chromium
  - Visit http://localhost:8080 for the workshop
  - Visit http://localhost:9090 for a local Hoogle instance

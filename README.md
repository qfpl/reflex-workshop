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

`vm.nix` is a nix expression that builds a VirtualBox appliance. Now
that the QFPL Hydra no longer exists, you will have to build it
yourself if you want it.

`nix build -f vm.nix` will build the appliance, but be warned: it will
take a while and peak at about **25GiB** of disk usage. If you have a
`tmpfs` mounted on `/tmp`, you will run out of space. I usually do
something like this:

```shell
  # On a multi-user nix install, build commands are passed
  # through the nix daemon. We switch to root to avoid this.
  # On a single-user nix install, working as root is probably
  # not necessary.
$ sudo -i

# mkdir /vmtmp

  # --no-link stops the creation of a `result` symlink owned by root.
# TMPDIR=/vmtmp nix build -f /path/to/vm.nix --no-link -L

# rmdir /vmtmp

  # As your normal user, re-run the build (which will be quick), to get
  # the link to the .ova from the nix store:
$ nix build -f /path/to/vm.nix
```

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

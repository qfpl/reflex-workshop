{ oldNixpkgs ? import <nixpkgs> {}}:
let
  reflex-platform = import ../deps/reflex-platform.nix {};
  nixpkgs = reflex-platform.nixpkgs;
  inherit (nixpkgs) pkgs;

  mkStatic = b : import ../content { local = b; };

  mkConfig = b: pkgs.stdenv.mkDerivation {
    name = "config";
    src = ../.;
    content = if b then "True" else "";
    builder = pkgs.writeScript "builder.sh" ''
      source $stdenv/setup
      mkdir -p $out/frontend
      echo $content >> $out/frontend/interactive
    '';
  };

  obelisk = import ../.obelisk/impl {};

  workshopBase = import ../. {};

  workshop = 
    let
      static = mkStatic true;
      config = mkConfig true;
    in 
      pkgs.stdenv.mkDerivation {
        name = "workshop";
        src = ../.;
        buildInputs = [pkgs.nix];
        builder = pkgs.writeScript "builder.sh" ''
          source $stdenv/setup

          mkdir $out
          cp $src/default.nix $out/
          cp -r $src/common $out/
          cp -r $src/deps $out/
          cp -r $src/devel $out/
          cp -r $src/backend $out/
          cp -r $src/frontend $out/
          cp -r $src/.obelisk $out/
          cp  $src/ghcid-output.txt $out/

          ln -s "${config}" $out/config
          mkdir $out/static
          cp -r "${static}"/* $out/static/
        '';
      };

  workshopOb = import "${workshop}" {};

  workshop-shell = 
   pkgs.stdenv.mkDerivation {
     name = "workshop-shell";
     src = ../.;
     buildInputs = workshopOb.shells.ghc.buildInputs;
     stdenv = pkgs.stdenv;
     builder = pkgs.writeScript "builder.sh" ''
       source $stdenv/setup
       mkdir "$out"
       echo "$buildInputs" > "$out/deps"
     ''; 
   };

  workshop-vm-config = {
      imports = [
        ./virtualbox-image.nix
      ];

      virtualbox = {
        baseImageSize = 15 * 1024;
        memorySize = 2 * 1024;
        vmName = "Reflex workshop (NixOS)";
        vmDerivationName = "nixos-ova-reflex-workshop"; 
        vmFileName = "reflex-workshop.ova";
      };

      services.xserver = {
        enable = true;
        displayManager.sddm = {
          enable = true;
          autoLogin = {
            enable = true;
            relogin = true;
            user = "workshop";
          };
        };
        desktopManager.xfce.enable = true;
        libinput.enable = true; # for touchpad support on many laptops
      };

      users.extraUsers.workshop = {
        isNormalUser = true;
        description = "Workshop user";
        extraGroups = [ "wheel" ];
        password = "workshop";
        uid = 1000;
      };

      environment.systemPackages = with pkgs; [
        utillinux
        coreutils
        binutils
        pkgconfig

        wmctrl

        gitAndTools.gitFull
        chromium
        ag

        emacs
        vim

        # cabal2nix
        # curl
        # nix-prefetch-scripts
        # nodejs
        # pkgconfig
        # closurecompiler
        # reflex-platform.ghc.cabal-install
        # reflex-platform.ghc.ghcid
        # reflex-platform.ghc.hasktags
        # reflex-platform.ghc.hlint
        # (reflex-platform.nixpkgs.haskell.lib.justStaticExecutables reflex-platform.ghc.ghc-mod)
        # reflex-platform.ghc.stylish-haskell

        workshopBase
        obelisk.command
        workshop
        workshop-shell
      ];

      nix.binaryCaches = [
        "https://cache.nixos.org/"
        "https://nixcache.reflex-frp.org"
        "http://hydra.qfpl.io"
      ];
      nix.binaryCachePublicKeys = [
        "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
        "qfpl.io:xME0cdnyFcOlMD1nwmn6VrkkGgDNLLpMXoMYl58bz5g="
      ];

      systemd.services.workshop-setup = {
        description = "Setup workshop";
        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = true;
        wantedBy = [ "multi-user.target" ];
        script = ''
          if [ ! -e /home/workshop/reflex-workshop ]; then
            mkdir /home/workshop/reflex-workshop
            cp -rT "${workshop}/" /home/workshop/reflex-workshop/
            chown -R workshop:users /home/workshop/reflex-workshop
          fi
        '';
      };
  };

  hydraJob = (import "${oldNixpkgs.path}/lib").hydraJob;
  workshop-vm = hydraJob ((import "${oldNixpkgs.path}/nixos/lib/eval-config.nix" {
      modules = [ workshop-vm-config ];
    }).config.system.build.virtualBoxOVA);

  tutorial = 
    let
      static = mkStatic false;
      config = mkConfig false;
    in
      pkgs.stdenv.mkDerivation {
        name = "tutorial";
        src = ../.;
        buildInputs = [ pkgs.closurecompiler pkgs.zopfli ];
        builder = pkgs.writeScript "builder.sh" ''
          source $stdenv/setup

          mkdir $out
          ln -s "${config}" $out/config
          ln -s "${static}/pages" $out/pages
          ln -s "${static}/fonts" $out/fonts
          ln -s "${static}/css" $out/css
          mkdir $out/js
          cp -r "${static}/js"/* $out/js/
          cp "${workshopOb}/ghcjs/frontend/bin/frontend.jsexe/all.js" $out/js/workshop.js
          closure-compiler $out/js/workshop.js --compilation_level=ADVANCED_OPTIMIZATIONS --isolation_mode=IIFE --assume_function_wrapper --jscomp_off="*" --externs="${workshopOb}/ghcjs/frontend/bin/frontend.jsexe/all.js.externs" > $out/js/workshop.min.js
          zopfli $out/js/workshop.min.js
        '';
      };
in
  { 
    inherit workshop-vm tutorial workshop-shell; 
    obelisk-command = obelisk.command;
  }

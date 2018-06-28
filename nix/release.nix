{ nixpkgs ? import <nixpkgs> {}}:
let
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

  obelisk = 
    import (pkgs.fetchFromGitHub (pkgs.lib.importJSON ../.obelisk/impl/github.json)) {};

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

        obelisk.command
        workshop
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

  hydraJob = (import "${nixpkgs.path}/lib").hydraJob;
  workshop-vm = hydraJob ((import "${nixpkgs.path}/nixos/lib/eval-config.nix" {
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
    inherit workshop-vm tutorial; 
    obelisk-command = obelisk.command;
  }

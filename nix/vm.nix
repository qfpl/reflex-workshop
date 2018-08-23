{ oldNixpkgs ? import <nixpkgs> {}}:
let
  reflex-platform = import ../deps/reflex-platform {};
  nixpkgs = reflex-platform.nixpkgs;
  pkgs = nixpkgs.pkgs;
  workshop-pkg = import ../. {};

  reflex-workshop-assets = import ../content {};

  reflex-workshop = pkgs.stdenv.mkDerivation {
    name = "reflex-workshop-source";
    src = pkgs.lib.cleanSource ../.;
    phases = ["installPhase"];
    installPhase = ''
      mkdir $out
      cp -r $src/* $out/
    '';
  };

  tools = with pkgs; [
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
    gnome3.gedit

    reflex-workshop-assets
    reflex-workshop
  ];

  haskell-tools = reflex-platform.ghc.ghcWithPackages (hp: with hp; [
    Cabal
    cabal-install
    ghcid
    hlint
    hasktags
    hindent
    hoogle
    stylish-haskell
    (nixpkgs.haskell.lib.justStaticExecutables ghc-mod)

    workshop-pkg
  ]);

  workshop-vm-config = {
      imports = [
        ./virtualbox-image.nix
      ];

      virtualbox = {
        baseImageSize = 15 * 1024;
        memorySize = 3 * 1024;
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

      environment.systemPackages =
        tools ++ [haskell-tools];

      # environment.variables.WORKSHOP_ASSETS = $workshop-assets;

      systemd.services.workshop-setup = {
        description = "Setup workshop";
        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = true;
        wantedBy = [ "multi-user.target" ];
        script = ''
          if [ ! -e /home/workshop/reflex-workshop ]; then
            cp -rT "${reflex-workshop}/" /home/workshop/reflex-workshop
            chmod -R u+w /home/workshop/reflex-workshop
            ln -s "${reflex-workshop-assets}" /home/workshop/reflex-workshop/assets
            chown -R workshop:users /home/workshop/reflex-workshop
          fi
        '';
      };

      systemd.services.hoogle-setup = {
        description = "Setup hoogle";
        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = true;
        wantedBy = [ "multi-user.target" ];
        environment = { HOME = "/home/workshop"; };
        path = [haskell-tools];
        script = ''
          if [ ! -e /home/workshop/.hoogle-setup ]; then
            hoogle generate --local
            touch /home/workshop/.hoogle-setup
          fi
            hoogle server -p 9090 --local
        '';
      };
  };

  hydraJob = (import "${oldNixpkgs.path}/lib").hydraJob;
  workshop-vm = hydraJob ((import "${oldNixpkgs.path}/nixos/lib/eval-config.nix" {
      modules = [ workshop-vm-config ];
    }).config.system.build.virtualBoxOVA);
in
  workshop-vm


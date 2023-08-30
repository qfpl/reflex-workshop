let
  sources = import ./nix/sources.nix {};
  newNixpkgs = import sources.nixpkgs {};
  reflex-platform = import sources.reflex-platform {};
  inherit (reflex-platform) nixpkgs;
  inherit (nixpkgs) pkgs;

  workshop-pkg = import ./. {};
  reflex-workshop-assets = import ./content {};
  reflex-workshop = newNixpkgs.lib.cleanSourceWith {
    src = ./.;
    name = "reflex-workshop-source";
    filter = newNixpkgs.lib.cleanSourceFilter;
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
    # (nixpkgs.haskell.lib.justStaticExecutables ghc-mod)

    workshop-pkg
  ]);

  nixpkgsSrc =
    let
      json = builtins.fromJSON
        (builtins.readFile "${sources.reflex-platform.outPath}/nixpkgs/github.json");
    in builtins.fetchTarball {
      inherit (json) sha256;
      url = "https://github.com/${json.owner}/${json.repo}/archive/${json.rev}.tar.gz";
    };

  workshop-vm-config = {
    imports = [ "${nixpkgsSrc}/nixos/modules/virtualisation/virtualbox-image.nix" ];

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

      # environment.variables.WORKSHOP_ASSETS = $reflex-workshop-assets;

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

  hydraJob = (import "${nixpkgsSrc}/lib").hydraJob;
  workshop-vm = hydraJob ((import "${nixpkgsSrc}/nixos/lib/eval-config.nix" {
    modules = [ workshop-vm-config ];
  }).config.system.build.virtualBoxOVA);
in
workshop-vm

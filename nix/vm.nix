{ nixpkgs ? import <nixpkgs> {}}:
with import "${nixpkgs.path}/lib";
let
  reflex-platform = import ./reflex-platform.nix;
  pkgs = nixpkgs.pkgs;
  workshop-pkg = import ../code/default.nix {};

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
  ];

  haskell-tools = reflex-platform.ghc.ghcWithPackages (hp: with hp; [
    cabal-install
    ghcid
    hindent
    hlint
    stylish-haskell
    hasktags
    hoogle
    (pkgs.haskell.lib.justStaticExecutables ghc-mod)

    workshop-pkg
  ]);

  workshop-vm-config = {
      imports = [
        "${nixpkgs.path}/nixos/modules/virtualisation/virtualbox-image.nix"
      ];

      virtualbox.baseImageSize = 15 * 1024;

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

      systemd.services.hoogle = {
        description = "hoogle";
        serviceConfig.User = "workshop";
        serviceConfig.Restart = "on-failure";
        wantedBy = [ "multi-user.target" ];
        path = [ haskell-tools ];
        preStart = ''
          if [ ! -e ~workshop/.hoogle-setup ]; then
            hoogle generate --local
            touch ~workshop/.hoogle-setup
          fi
        '';
        script = ''
            hoogle server --local
        '';
      };

  };

  workshopVM = hydraJob ((import "${nixpkgs.path}/nixos/lib/eval-config.nix" {
      modules = [ workshop-vm-config ];
    }).config.system.build.virtualBoxOVA);
in
  workshopVM


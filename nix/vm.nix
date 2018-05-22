{ nixpkgs ? import <nixpkgs> {}}:
with import "${nixpkgs.path}/lib";
let
  reflex-platform = import ./reflex-platform.nix;
  pkgs = nixpkgs.pkgs;
  workshop-pkg = import ../code/default.nix {};

  reflex-workshop = import ./reflex-workshop.nix;

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
  ];

  haskell-tools = reflex-platform.ghc.ghcWithPackages (hp: with hp; [
    cabal-install
    ghcid
    hoogle

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

      systemd.services.workshop-setup = {
        description = "Setup workshop";
        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = true;
        wantedBy = [ "multi-user.target" ];
        # after = [ "network-active.target" ];
        # requires = [ "network-active.target" ];
        # path = [ pkgs.bash pkgs.gitAndTools.gitFull ];
        script = ''
          if [ ! -e ~workshop/reflex-workshop ]; then
        #    cd ~workshop
        #    git clone https://github.com/qfpl/reflex-workshop
            mkdir ~workshop/reflex-worksop
            cp -r "${reflex-workshop}/*" ~workshop/reflex-workshop/
          fi
        '';
      };
  };

  workshopVM = hydraJob ((import "${nixpkgs.path}/nixos/lib/eval-config.nix" {
      modules = [ workshop-vm-config ];
    }).config.system.build.virtualBoxOVA);
in
  workshopVM


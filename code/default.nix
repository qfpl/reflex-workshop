{ reflex-platform ? import ../nix/reflex-platform.nix
, compiler   ? "ghc"
} :
let

  pkgs = reflex-platform.nixpkgs.pkgs;
  ghc = reflex-platform.${compiler};

  sources = {
    servant-reflex = import ../nix/servant-reflex.nix;
    reflex-basic-host = import ../nix/reflex-basic-host.nix;
    reflex-server-servant = import ../nix/reflex-server-servant.nix;
    reflex-server-wai = import ../nix/reflex-server-wai.nix;
    reflex-model = import ../nix/reflex-model.nix;
  };

  modifiedHaskellPackages = ghc.override {
    overrides = self: super: {
      ghc = super.ghc // { withPackages = super.ghc.withHoogle; };
      ghcWithPackages = self.ghc.withPackages;

      reflex-basic-host = self.callPackage sources.reflex-basic-host {};
      reflex-server-servant = self.callPackage sources.reflex-server-servant {};
      reflex-server-wai = self.callPackage sources.reflex-server-wai {};
      reflex-model = self.callPackage sources.reflex-model {};
      servant-reflex = self.callCabal2nix "servant-reflex" sources.servant-reflex {};
      pandoc = pkgs.haskell.lib.doJailbreak super.pandoc;
    };
  };

  drv = modifiedHaskellPackages.callPackage ./reflex-workshop.nix {};
in
  drv

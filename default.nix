{ compiler ? "ghc" }:
let
  sources = import ./nix/sources.nix {};
  reflex-platform = import sources.reflex-platform {};
  pkgs = reflex-platform.nixpkgs.pkgs;

  ghc = reflex-platform.${compiler};
  haskellPackages = ghc.override {
    overrides = self: super: {
      ghc = super.ghc // { withPackages = super.ghc.withHoogle; };
      ghcWithPackages = self.ghc.withPackages;
      reflex-dom-contrib =
        pkgs.haskell.lib.doJailbreak
          (super.callCabal2nix "reflex-dom-contrib"
            (sources.reflex-dom-contrib.outPath) {});
      reflex-dom-nested-routing =
        super.callCabal2nix "reflex-dom-nested-routing"
          (sources.reflex-dom-nested-routing.outPath) {};
      reflex-dom-storage =
        super.callPackage (sources.reflex-dom-storage.outPath) {};
      reflex-dom-template =
        super.callPackage (sources.reflex-dom-template.outPath) {};
    };
  };
  drv = haskellPackages.callPackage ./workshop.nix { newNixpkgs = import sources.nixpkgs {}; };
in
  drv

{ compiler ? "ghc" }:
let
  sources = import ../../nix/sources.nix {};
  reflex-platform = import sources.reflex-platform {};
  pkgs = reflex-platform.nixpkgs.pkgs;

  ghc = reflex-platform.${compiler};
  modifiedHaskellPackages = ghc.override {
    overrides = self: super: {
      pandoc = pkgs.haskell.lib.doJailbreak super.pandoc;
    };
  };

  drv = modifiedHaskellPackages.callPackage ./processor.nix {};
in
  drv

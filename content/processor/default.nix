{ reflex-platform ? import ./../../deps/reflex-platform {}
, compiler   ? "ghc"
} :
let

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

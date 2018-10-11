{ reflex-platform ? import ./deps/reflex-platform {}
, compiler   ? "ghc"
} :
let

  pkgs = reflex-platform.nixpkgs.pkgs;
  ghc = reflex-platform.${compiler};
  haskellPackages = ghc.override {
    overrides = self: super: {
      ghc = super.ghc // { withPackages = super.ghc.withHoogle; };
      ghcWithPackages = self.ghc.withPackages;
      reflex-dom-contrib = 
        pkgs.haskell.lib.doJailbreak (super.callCabal2nix "reflex-dom-contrib" (import ./deps/reflex-dom-contrib {}) {});
      reflex-dom-nested-routing = 
        super.callCabal2nix "reflex-dom-nested-routing" (import ./deps/reflex-dom-nested-routing {}) {};
      reflex-dom-storage = 
        super.callPackage (import ./deps/reflex-dom-storage {}) {};
      reflex-dom-template = 
        super.callPackage (import ./deps/reflex-dom-template {}) {};
      jsaddle-warp = 
        pkgs.haskell.lib.dontCheck (super.callCabal2nix "jsaddle-warp" "${import ./deps/jsaddle {}}/jsaddle-warp" {});
    };
  };
  drv = haskellPackages.callPackage ./workshop.nix {};
in
  drv

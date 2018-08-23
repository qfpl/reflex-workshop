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
        super.callCabal2nix "reflex-dom-contrib" (import ./deps/reflex-dom-contrib {}) {};
      reflex-dom-nested-routing = 
        super.callCabal2nix "reflex-dom-nested-routing" (import ./deps/reflex-dom-nested-routing {}) {};
      reflex-dom-storage = 
        super.callCabal2nix "reflex-dom-storage" (import ./deps/reflex-dom-storage {}) {};
      reflex-dom-template = 
        super.callCabal2nix "reflex-dom-template" (import ./deps/reflex-dom-template {}) {};
      jsaddle-warp = 
        pkgs.haskell.lib.dontCheck (super.callCabal2nix "jsaddle-warp" "${import ./deps/jsaddle {}}/jsaddle-warp" {});
    };
  };
  drv = haskellPackages.callPackage ./workshop.nix {};
in
  drv

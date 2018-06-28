{ system ? builtins.currentSystem # TODO: Get rid of this system cruft
, iosSdkVersion ? "10.2"
}:
with import ./.obelisk/impl { inherit system iosSdkVersion; };
project ./. ({ ... }: {
  overrides = self: super: let 
      reflex-dom-contrib-version = nixpkgs.pkgs.lib.importJSON ./deps/reflex-dom-contrib.json;
      reflex-dom-contrib = nixpkgs.pkgs.fetchFromGitHub {
        owner = "reflex-frp";
        repo = "reflex-dom-contrib";
        inherit (reflex-dom-contrib-version) rev sha256;
      };
      reflex-dom-nested-routing-version = nixpkgs.pkgs.lib.importJSON ./deps/reflex-dom-nested-routing.json;
      reflex-dom-nested-routing = nixpkgs.pkgs.fetchFromGitHub {
        owner = "3noch";
        repo = "reflex-dom-nested-routing";
        inherit (reflex-dom-nested-routing-version) rev sha256;
      };
      reflex-dom-storage-version = nixpkgs.pkgs.lib.importJSON ./deps/reflex-dom-storage.json;
      reflex-dom-storage = nixpkgs.pkgs.fetchFromGitHub {
        owner = "qfpl";
        repo = "reflex-dom-storage";
        inherit (reflex-dom-storage-version) rev sha256;
      };
      reflex-dom-template-version = nixpkgs.pkgs.lib.importJSON ./deps/reflex-dom-template.json;
      reflex-dom-template = nixpkgs.pkgs.fetchFromGitHub {
        owner = "qfpl";
        repo = "reflex-dom-template";
        inherit (reflex-dom-template-version) rev sha256;
      };
      dontHaddock = nixpkgs.pkgs.haskell.lib.dontHaddock;
    in {
      reflex-dom-contrib = dontHaddock (self.callCabal2nix "reflex-dom-contrib" reflex-dom-contrib {});
      reflex-dom-nested-routing = dontHaddock (self.callCabal2nix "reflex-dom-nested-routing" reflex-dom-nested-routing {});
      reflex-dom-storage = dontHaddock (self.callCabal2nix "reflex-dom-storage" reflex-dom-storage {});
      reflex-dom-template = dontHaddock (self.callCabal2nix "reflex-dom-template" reflex-dom-template {});
      frontend = dontHaddock super.frontend;
    };
})

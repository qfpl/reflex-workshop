{ nixpkgs ? import <nixpkgs> {}
, compiler ? "ghc"
} :
let
  inherit (nixpkgs) pkgs;
  reflex-platform = import ../../deps/reflex-platform {};
  drv = import ./. { inherit reflex-platform compiler; };
  drvWithTools = pkgs.haskell.lib.addBuildDepends drv
    [ pkgs.cabal-install
    ];
in
  drvWithTools.env

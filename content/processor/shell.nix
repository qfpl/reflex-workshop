{ compiler ? "ghc" }:
let
  sources = import ./nix/sources.nix {};
  reflex-platform = import sources.reflex-platform {};
  pkgs = reflex-platform.nixpkgs.pkgs;

  drv = import ./. { inherit compiler; };
  drvWithTools = pkgs.haskell.lib.addBuildDepends drv
    [ pkgs.cabal-install
    ];
in
  drvWithTools.env

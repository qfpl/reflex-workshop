{ oldNixpkgs ? import <nixpkgs> {}}:
let
  reflex-platform = import ../deps/reflex-platform {};
  nixpkgs = reflex-platform.nixpkgs;
  pkgs = nixpkgs.pkgs;
  workshop-pkg = import ../. {};

  reflex-workshop = pkgs.stdenv.mkDerivation {
    name = "reflex-workshop-source";
    src = pkgs.lib.cleanSource ../.; # import ./reflex-workshop.nix;
    phases = ["installPhase"];
    installPhase = ''
      mkdir $out
      cp -r $src/* $out/
    '';
  };

in
  reflex-workshop


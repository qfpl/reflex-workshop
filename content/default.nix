{ nixpkgs ? import <nixpkgs> {} 
, local ? true
}:
let
  inherit (nixpkgs) pkgs;
in
with pkgs; stdenv.mkDerivation {
  name = "reflex-workshop-content-0.1";
  builder = if local then ./builderLocal.sh else ./builderNonLocal.sh;
  src = ./.;
  inherit pandoc nix;
  processor = import ./processor {};
}

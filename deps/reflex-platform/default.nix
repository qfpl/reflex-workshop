{ nixpkgs ? import <nixpkgs> {}}:
  import (import ../github.nix { 
    inherit nixpkgs; 
    owner = "reflex-frp"; 
    repo = "reflex-platform"; 
    jsonFile = ./github.json;
  }) {}


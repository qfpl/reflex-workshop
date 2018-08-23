{ nixpkgs ? import <nixpkgs> {}}:
  import ../github.nix { 
    inherit nixpkgs; 
    owner = "reflex-frp"; 
    repo = "reflex-dom-contrib"; 
    jsonFile = ./github.json;
  }


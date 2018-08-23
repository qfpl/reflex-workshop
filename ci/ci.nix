{nixpkgs ? import <nixpkgs> {}}:
let
  reflex-workshop = import ../. {};
  reflex-workshop-assets = import ../content {};
  reflex-workshop-vm = import ../nix/vm.nix {};
  jobs = {
    inherit reflex-workshop reflex-workshop-assets reflex-workshop-vm;
  };
in
  jobs

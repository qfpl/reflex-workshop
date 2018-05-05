{nixpkgs ? import <nixpkgs> {}}:
let
  reflex-workshop = import ../code/default.nix {};
  reflex-workshop-vm = import ../nix/vm.nix {};
  jobs = {
    reflex-workshop = reflex-workshop;
    reflex-workshop-vm = reflex-workshop-vm;
  };
in
  jobs

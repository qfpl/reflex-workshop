let  
  initialNixpkgs = import <nixpkgs> {};

  sources = rec {
    reflex-basic-host-info-pinned = initialNixpkgs.pkgs.lib.importJSON ./reflex-basic-host.json;
    reflex-basic-host = initialNixpkgs.pkgs.fetchFromGitHub {
      owner = "dalaing";
      repo = "reflex-basic-host";
      inherit (reflex-basic-host-info-pinned) rev sha256;
    };
  };
in
  sources.reflex-basic-host


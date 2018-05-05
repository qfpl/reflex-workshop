let  
  initialNixpkgs = import <nixpkgs> {};

  sources = rec {
    reflex-log-info-pinned = initialNixpkgs.pkgs.lib.importJSON ./reflex-log.json;
    reflex-log = initialNixpkgs.pkgs.fetchFromGitHub {
      owner = "dalaing";
      repo = "reflex-log";
      inherit (reflex-log-info-pinned) rev sha256;
    };
  };
in
  sources.reflex-log


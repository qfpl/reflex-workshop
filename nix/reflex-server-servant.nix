let  
  initialNixpkgs = import <nixpkgs> {};

  sources = rec {
    reflex-server-servant-info-pinned = initialNixpkgs.pkgs.lib.importJSON ./reflex-server-servant.json;
    reflex-server-servant = initialNixpkgs.pkgs.fetchFromGitHub {
      owner = "dalaing";
      repo = "reflex-server-servant";
      inherit (reflex-server-servant-info-pinned) rev sha256;
    };
  };
in
  sources.reflex-server-servant


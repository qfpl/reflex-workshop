{ mkDerivation, base, directory, filepath, pandoc, stdenv, text }:
mkDerivation {
  pname = "processor";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base directory filepath pandoc text ];
  license = stdenv.lib.licenses.bsd3;
}

{stdenv, fetchgit}:

stdenv.mkDerivation {
  name = "k380-conf-0.0.1";
  src = fetchgit {
    url = https://github.com/jergusg/k380-function-keys-conf;
    rev = "b1798b8350b90e93ec20d420632a2ac07ad36be2";
    sha256 = "11sydfzlb0avvqxk43wasq5g8hjmc1n3vwag791lgv5h7aq34a75";
  };

  buildPhase = "./build.sh";
  installPhase = "mkdir -p $out/sbin; install -v -m755 k380_conf $out/sbin";

  meta = with stdenv.lib; {
    homepage = https://github.com/jergusg/k380-function-keys-conf;
    description = "Utility to manage function keys behavior on Logitech K380 keyboard";
    platforms = stdenv.lib.platforms.linux;
    licenses = licenses.gpl3;
  };
}

{stdenv, fetchgit}:

stdenv.mkDerivation {
  name = "k380-conf-0.0.1";
  src = fetchgit {
    url = https://github.com/jergusg/k380-function-keys-conf;
    rev = "ed8eb60709a14ff26a36f993f40fe26f7aa6543a";
    sha256 = "01zdbrqq0f4lg7ywm9knddb2dd4iv8k4ggrh94q106gic04aiijn";
  };

  buildPhase = "./build.sh";
  installPhase = ''
    mkdir -p $out/sbin $out/etc/udev/rules.d
    install -v -m755 k380_conf $out/sbin
    echo "KERNEL==\"hidraw*\", KERNELS==\"*:046D:B342.*\", RUN+=\"$out/sbin/k380_conf -f on -d '%E{DEVNAME}'\"" > $out/etc/udev/rules.d/90-k380.rules
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/jergusg/k380-function-keys-conf;
    description = "Utility to manage function keys behavior on Logitech K380 keyboard";
    platforms = stdenv.lib.platforms.linux;
    licenses = licenses.gpl3;
  };
}

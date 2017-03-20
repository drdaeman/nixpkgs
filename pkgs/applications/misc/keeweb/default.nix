{ stdenv, lib, libXScrnSaver, makeWrapper, fetchurl, unzip, atomEnv }:

stdenv.mkDerivation rec {
  name = "keeweb-${version}";
  version = "1.4.0";

  src = fetchurl {
    url = "https://github.com/keeweb/keeweb/releases/download/v${version}/KeeWeb-${version}.linux.x64.zip";
    sha256 = "0wi4vhzl6dqhzl9q78zxhpklj77f8i859j9zgryqs3phfd2z0z9r";
    name = "${name}.zip";
  };

  buildInputs = [ unzip makeWrapper ];

  buildCommand = ''
    mkdir -p $out/lib/keeweb $out/bin
    unzip -d $out/lib/keeweb $src
    ln -s $out/lib/keeweb/KeeWeb $out/bin/keeweb

    fixupPhase

    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${atomEnv.libPath}:$out/lib/keeweb" \
      $out/lib/keeweb/KeeWeb

    wrapProgram $out/lib/keeweb/KeeWeb \
      --prefix LD_PRELOAD : ${stdenv.lib.makeLibraryPath [ libXScrnSaver ]}/libXss.so.1
  '';

  meta = with stdenv.lib; {
    description = "Free cross-platform password manager compatible with KeePass";
    homepage = https://keeweb.info/;
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
  };
}

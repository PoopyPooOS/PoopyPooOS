{
  pkgs ? import <nixpkgs> { },
  ...
}:

let
  crossPkgs = import <nixpkgs> { system = "aarch64-unknown-linux-gnu"; };
  openssl = crossPkgs.openssl;
in
pkgs.mkShell {
  packages = with crossPkgs; [
    pkgs.pkgsCross.aarch64-multiplatform.buildPackages.gcc

    pkg-config
    openssl
  ];

  shellHook = ''
    export CC=aarch64-unknown-linux-gnu-cc
    export AR=aarch64-unknown-linux-gnu-ar

    export PKG_CONFIG_PATH=${openssl}/lib/pkgconfig
    export PKG_CONFIG_SYSROOT_DIR=${openssl}
    export PKG_CONFIG=${crossPkgs.pkg-config}/bin/pkg-config

    export OPENSSL_DIR=${openssl}
    export OPENSSL_LIB_DIR=${openssl.out}/lib
    export OPENSSL_INCLUDE_DIR=${openssl.dev}/include
  '';
}

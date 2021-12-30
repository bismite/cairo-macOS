#!/bin/bash

PREFIX=$(pwd)/build
export PATH=${PREFIX}/bin:$PATH

(
  cd build
  tar xf cairo-1.17.4.tar.xz
)

(
  cd build/cairo-1.17.4
  ./configure --prefix=${PREFIX} --enable-static=no --disable-svg --disable-ps --disable-pdf CFLAGS="-g0 -O2 -arch arm64 -arch x86_64" LDFLAGS="-arch arm64 -arch x86_64"
  make install
)

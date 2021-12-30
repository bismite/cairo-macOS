#!/bin/bash

PREFIX=$(pwd)/build
export PATH=${PREFIX}/bin:$PATH

(
  cd build
  tar xf freetype-2.11.1.tar.xz
)

(
  cd build/freetype-2.11.1
  ./configure --prefix=${PREFIX} --disable-static CFLAGS="-g0 -O2 -arch arm64 -arch x86_64" LDFLAGS="-arch arm64 -arch x86_64"
  make install
)

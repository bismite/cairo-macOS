#!/bin/bash

PREFIX=$(pwd)/build
export PATH=${PREFIX}/bin:$PATH

(
  cd build
  tar xf libpng-1.6.37.tar.gz
)

mkdir -p build/lib/pkgconfig
cp zlib.pc build/lib/pkgconfig/

(
  cd build/libpng-1.6.37
  ./configure --prefix=${PREFIX} --enable-static=no CFLAGS="-g0 -O2 -arch arm64 -arch x86_64" LDFLAGS="-arch arm64 -arch x86_64"
  make install
)

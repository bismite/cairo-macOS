#!/bin/bash

PREFIX=$(pwd)/build
export PATH=${PREFIX}/bin:$PATH

mkdir -p build/libpng-1.6.37-arm64
mkdir -p build/libpng-1.6.37-x86_64
(
  cd build
  tar --strip-components=1 -xf libpng-1.6.37.tar.gz -C libpng-1.6.37-arm64
  tar --strip-components=1 -xf libpng-1.6.37.tar.gz -C libpng-1.6.37-x86_64
)

mkdir -p build/lib/pkgconfig
cp zlib.pc build/lib/pkgconfig/

(
  cd build/libpng-1.6.37-x86_64
  ./configure --prefix=${PREFIX} --enable-static=no CFLAGS="-g0 -O2 -arch x86_64" LDFLAGS="-arch x86_64"
  make install
)

mv build/lib/libpng16.16.dylib build/libpng16.16.x86_64.dylib

ARCH=uname -m
(
  cd build/libpng-1.6.37-arm64
  if [ ${ARCH} = "arm64" ]
  then
    ./configure --prefix=${PREFIX} --enable-static=no --enable-arm-neon=yes CFLAGS="-g0 -O2 -arch arm64" LDFLAGS="-arch arm64"
  else
    ./configure --prefix=${PREFIX} --enable-static=no --enable-arm-neon=yes --host=x86_64-apple-darwin CFLAGS="-g0 -O2 -arch arm64" LDFLAGS="-arch arm64"
  fi
  make install
)

mv build/lib/libpng16.16.dylib build/libpng16.16.arm64.dylib

lipo -create build/libpng16.16.x86_64.dylib build/libpng16.16.arm64.dylib -output build/lib/libpng16.16.dylib

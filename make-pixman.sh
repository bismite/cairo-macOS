#!/bin/bash

PREFIX=$(pwd)/build
export PATH=${PREFIX}/bin:$PATH

(
  cd build
  tar xf pixman-0.40.0.tar.gz
)

(
  cd build/pixman-0.40.0
  ./configure --prefix=${PREFIX} CFLAGS="-g0 -O2 -arch arm64 -arch x86_64" LDFLAGS="-arch arm64 -arch x86_64"
  make install
)

#!/bin/bash

PREFIX=$(pwd)/build

(
  cd build
  tar xf pkg-config-0.29.2.tar.gz
)

(
  cd build/pkg-config-0.29.2
  ./configure --prefix=${PREFIX} --with-internal-glib
  make install
)

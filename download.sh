#!/bin/bash
mkdir_p build
for url in \
  https://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz \
  https://download.sourceforge.net/libpng/libpng-1.6.37.tar.gz \
  https://cairographics.org/snapshots/cairo-1.17.4.tar.xz \
  https://cairographics.org/releases/pixman-0.40.0.tar.gz \
  https://download.savannah.gnu.org/releases/freetype/freetype-2.11.1.tar.xz
do
  echo $url
  (cd build ; curl "-JOL#" $url)
done

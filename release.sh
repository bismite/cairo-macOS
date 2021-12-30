#!/bin/bash

mkdir -p release/lib
RELEASE=$(pwd)/release

(
  cd build/lib
  cp libpng16.16.dylib ${RELEASE}/lib/
  cp libpixman-1.0.dylib ${RELEASE}/lib/
  cp libfreetype.6.dylib ${RELEASE}/lib/
  cp libcairo.2.dylib ${RELEASE}/lib/
)
cp -R build/include release/

DIR=$(pwd)/build/lib
(
  cd release/lib
  # cairo update
  install_name_tool -change ${DIR}/libpixman-1.0.dylib @rpath/libpixman-1.0.dylib libcairo.2.dylib
  install_name_tool -change ${DIR}/libfreetype.6.dylib @rpath/libfreetype.6.dylib libcairo.2.dylib
  install_name_tool -change ${DIR}/libpng16.16.dylib   @rpath/libpng16.16.dylib   libcairo.2.dylib
  # freetype update
  install_name_tool -change ${DIR}/libpng16.16.dylib @rpath/libpng16.16.dylib libfreetype.6.dylib
  # rename
  install_name_tool -id @rpath/libpng16.16.dylib   libpng16.16.dylib
  install_name_tool -id @rpath/libcairo.2.dylib    libcairo.2.dylib
  install_name_tool -id @rpath/libfreetype.6.dylib libfreetype.6.dylib
  install_name_tool -id @rpath/libpixman-1.0.dylib libpixman-1.0.dylib
)

# License Files
mkdir -p release/licenses
# cairo License
cp build/cairo-1.17.4/COPYING          release/licenses/cairo-1.17.4-COPYING
cp build/cairo-1.17.4/COPYING-LGPL-2.1 release/licenses/cairo-1.17.4-COPYING-LGPL-2.1
cp build/cairo-1.17.4/COPYING-MPL-1.1  release/licenses/cairo-1.17.4-COPYING-MPL-1.1
# FreeType License
cp build/freetype-2.11.1/LICENSE.TXT    release/licenses/freetype-2.11.1-LICENSE.TXT
cp build/freetype-2.11.1/docs/FTL.TXT   release/licenses/freetype-2.11.1-FTL.TXT
cp build/freetype-2.11.1/docs/GPLv2.TXT release/licenses/freetype-2.11.1-GPLv2.TXT
# pixman License
cp build/pixman-0.40.0/COPYING release/licenses/pixman-0.40.0-COPYING
# libpng License
cp build/libpng-1.6.37/LICENSE release/licenses/libpng-1.6.37-LICENSE

(
  cd release
  tar czf cairo-macOS.tgz *
)

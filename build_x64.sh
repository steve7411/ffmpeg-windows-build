#!/bin/sh
MY_BUILD=${HOME}/build
MY_X64=${MY_BUILD}/x64

#Compiling faac
# note:
# faac is incompatible with GPL/LGPL.
cd ${MY_X64}/faac-*
./configure --prefix=/mingw/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 \
 --disable-shared --without-mp4v2
make clean && make && make install-strip

#Compiling opencore-amr
# note:
# opencore-amr's license(Apache 2.0) is compatible with GPLv3 or later.
cd ${MY_X64}/opencore-amr-*
./configure --prefix=/mingw/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --disable-shared
make clean && make && make install-strip

#Compiling vo-aacenc
# note:
# vo-aacenc's license(Apache 2.0) is compatible with GPLv3 or later.
# vo-aacenc-0.1.0.tar.gz includes some clitical issues.
# thus you should get latest source code from git repo.
cd ${MY_X64}/vo-aacenc
autoreconf
./configure --prefix=/mingw/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --disable-shared
make clean && make && make install-strip

#Compiling vo-amrwbenc
# note:
# vo-amrwbenc's license(Apache 2.0) is compatible with GPLv3 or later.
cd ${MY_X64}/vo-amrwbenc
autoreconf
./configure --prefix=/mingw/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --disable-shared
make clean && make && make install-strip

#Compiling libogg (libtheora/libvorbis/speex requires this)
cd ${MY_X64}/libogg-*
./configure --prefix=/mingw/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --disable-shared
make clean && make && make install-strip

#Compiling libtheora
cd ${MY_X64}/libtheora-*
./configure --prefix=/mingw/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --disable-shared
make clean && make && make install-strip

#Compiling libvorbis
cd ${MY_X64}/libvorbis-*
./configure --prefix=/mingw/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --disable-shared
make clean && make && make install-strip

#Compiling speex
cd ${MY_X64}/speex-*
./configure --prefix=/mingw/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --disable-shared --enable-sse
make clean && make && make install-strip

#Compiling openjpeg
# note:
# Compiling openjpeg is weird.
cd ${MY_X64}/openjpeg_*
./configure && make clean
./configure --prefix=/mingw/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --disable-shared
make clean && make && make install-strip
# note:
#  The .pc files of openjpeg-1.4.0 are installed into /usr/lib/pkgconfig
# instead of install-prefix/lib/pkgconfig.
#  You should move these files into install-prefix/lib/pkgconfig.
mv /usr/lib/pkgconfig/libopenjpeg*.pc /mingw/x86_64-w64-mingw32/lib/pkgconfig/

#Compiling libx264
# Edit configure line assume r1995 or later(20110514)
cd ${MY_X64}/x264
./configure --prefix=/mingw/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 \
 --cross-prefix=x86_64-w64-mingw32- --disable-cli --enable-static --disable-gpac --disable-swscale --enable-win32thread
make clean && make # or make fprofiled VIDS='/path/to/file.y4m'
make install

# ------------compiling 64bit ffmpeg----------------
# note:
#  If you want to redistribute your ffmpeg binaries,
# delete '--enable-nonfree' and '--enable-libfaac' from following configures.
#  Add enable-libvo-aacenc and enable-libvo-amrwbenc (22/04/2011).
cd ${MY_X64}/ffmpeg
FFMPEGVER=`./version.sh`
PKG_CONFIG_PATH=/mingw/x86_64-w64-mingw32/lib/pkgconfig/ \
 ./configure --prefix=/mingw/x86_64-w64-mingw32 --disable-doc --disable-ffprobe \
 --cross-prefix=x86_64-w64-mingw32- --target-os=mingw32 --arch=x86_64 \
 --enable-gpl --enable-version3 --enable-nonfree --enable-postproc \
 --enable-w32threads --enable-runtime-cpudetect --enable-memalign-hack \
 --enable-avisynth --enable-libopencore-amrnb --enable-libopencore-amrwb \
 --enable-libfaac --enable-libmp3lame --enable-libopenjpeg --enable-libspeex \
 --enable-libtheora --enable-libvorbis --enable-libvo-aacenc --enable-libvo-amrwbenc \
 --enable-libx264 --disable-hwaccels --cpu=x86_64 --disable-debug \
 --extra-cflags=-fno-strict-aliasing
make clean && make && make install
cp /mingw/x86_64-w64-mingw32/bin/ffmpeg.exe /usr/local/bin/ffmpeg_x64_${FFMPEGVER}.exe
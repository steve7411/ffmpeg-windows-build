#!/bin/sh
MY_BUILD=${HOME}/build
MY_X86=${MY_BUILD}/x86

#Compiling SDL (ffplay requires this as renderer)
# note:
#  It becomes impossible for me to link SDL libraries statically with ffplay
# because of some recent changes. thus you have to copy SDL.dll to the folder
# in your PATH.(26/03/2011)
cd ${MY_X86}/SDL-*
./configure --prefix=/mingw/i686-pc-mingw32
make clean && make && make install
cp /mingw/i686-pc-mingw32/bin/SDL.dll /usr/local/bin/

#Compiling OpenSSL (librtmp requires this)
cd ${MY_X86}/openssl-*
# note:
# for openssl, the first 'C' of Configure is a capital letter. 
./Configure mingw --prefix=/mingw/i686-pc-mingw32
make && make install

#Compiling librtmp(rtmpdump)
cd ${MY_X86}/rtmpdump-*
make prefix=/mingw/i686-pc-mingw32 SYS=mingw SHARED=no
make install prefix=/mingw/i686-pc-mingw32 SYS=mingw SHARED=no
# note:
# librtmp links libws2_32 and libwinmm on MinGW, but it is not written in librtmp.pc.
# And, ffmpeg's configure requires pkg-config to check librtmp.
# Thus you should edit librtmp.pc as follows.
sed -i -e 's/Libs: -L${libdir} -lrtmp -lz/Libs: -L${libdir} -lrtmp -lz -lws2_32 -lwinmm/g' /mingw/i686-pc-mingw32/lib/pkgconfig/librtmp.pc

#Delete orc and schroedinger compile(20110421)

#Compiling libvpx
#20110313:update libvpx version from 0.9.5 to 0.9.6
cd ${MY_X86}/libvpx-*
./configure --target=x86-win32-gcc --cpu=i686 --disable-examples --enable-runtime-cpu-detect
make clean && make
cp libvpx.a /mingw/i686-pc-mingw32/lib/
mkdir -p /mingw/i686-pc-mingw32/include/vpx
cp ./vpx/*.h /mingw/i686-pc-mingw32/include/vpx/
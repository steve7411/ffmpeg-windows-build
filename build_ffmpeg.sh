#!/bin/sh

#These scripts were initally taken from http://csbarn.blogspot.com/2011/02/how-to-compile-ffmpegx264-for-windows.html
./get_source.sh

(./build_x86.sh) &
(./build_x64.sh) &
wait

echo Done building ffmpeg x86 and x64

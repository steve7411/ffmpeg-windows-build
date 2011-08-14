./get_source.sh

(./build_x86.sh) &
(./build_x64.sh) &
wait

echo Done building ffmpeg x86 and x64
MY_BUILD=${HOME}/build
MY_X86=${MY_BUILD}/x86
MY_X64=${MY_BUILD}/x64


# -----------------download source codes------------------
mkdir -p ${MY_BUILD}/src

cd ${MY_BUILD}/src
git clone git://git.videolan.org/ffmpeg.git ffmpeg
git clone git://git.videolan.org/x264.git x264
svn co http://ffmpegsource.googlecode.com/svn/trunk/ ffms2
git clone git://github.com/mstorsjo/vo-aacenc.git
git clone git://github.com/mstorsjo/vo-amrwbenc.git
wget http://downloads.sourceforge.net/project/lame/lame/3.98.4/lame-3.98.4.tar.gz
wget http://downloads.xiph.org/releases/ogg/libogg-1.2.2.tar.gz
wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.2.tar.bz2
wget http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2
wget http://downloads.xiph.org/releases/speex/speex-1.2rc1.tar.gz
wget http://openjpeg.googlecode.com/files/openjpeg_v1_4_sources_r697.tgz
wget http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/0.1.2/opencore-amr-0.1.2.tar.gz
wget http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.bz2

cp -r ./ $MY_X64

wget http://www.libsdl.org/release/SDL-1.2.14.tar.gz
wget http://www.openssl.org/source/openssl-1.0.0d.tar.gz
wget http://rtmpdump.mplayerhq.hu/download/rtmpdump-2.3.tgz
wget http://webm.googlecode.com/files/libvpx-v0.9.6.tar.bz2
wget http://downloads.xvid.org/downloads/xvidcore-1.3.2.tar.gz
cp -r ./ $MY_X86

cd $MY_X86
for i in ./*gz; do tar zxvf $i; done
for i in ./*.tar.bz2; do tar jxvf $i; done
rm ./*gz ./*.tar.bz2

cd $MY_X64
for i in ./*gz; do tar zxvf $i; done
for i in ./*.tar.bz2; do tar jxvf $i; done
rm ./*gz ./*.tar.bz2
#!/bin/sh

#These scripts were initally taken from http://csbarn.blogspot.com/2011/02/how-to-compile-ffmpegx264-for-windows.html

# How to compile ffmpeg/x264 binaries for both 32bit and 64bit on Windows
#
#  At first, you should install Git into your Windows.
#   1. Download Git from http://msysgit.googlecode.com/files/Git-1.7.4-preview20110204.exe
#   2. Doubleclick Git-1.7.4-preview20110204.exe
#   3. "Welcome to the Git Setup Wizard" : Next>
#   4. "Information" (GPLv2 descliption) : Next>
#   5. "Select Destination Location" : C:\Git (or where you want) and Next>
#   6. "Select Components" : all checks off and Next>
#   7. "Select Start Menu Folder" : check "Don't create a Start Menu folder" and Next>
#   8. "Adjusting your PATH environment" :
#         check "Run Git and included Unix tool from the Windows Command Prompt" and Next>
#      * This method has the possibility to cause some trouble to your system.
#        When it happens, uninstall Git via ControlPanel.
#        If you know how to edit /etc/profile, you will choose "Use Git Bash only".
#   9. "Configuring the line ending conversions" :
#         check "Checkout as-is,commit as-is" and Next>
# 
#  Next, you have to get latest MSYS, mingw-w64 binaries, pkg-config, subversion, nasm,
# yasm, and the others.
#  I recommend you to use XhmikosR's toolchain.
#  You will be able to get all dependencies at once.
#   1. Go to http://xhmikosr.1f0.de/index.php?folder=dG9vbHM=
#   2. Download MSYS_MinGW_GCC_***_x86-x64_Full.7z
#     * You should download MSYS_MinGW_GCC_***_x86-x64_'Full'.7z because some dependencies
#      are not included in MSYS_MinGW_***_x86-x64.7z(e.g. perl.exe).
#   3. extract it with 7zip, and put it on the place that you want (e.g. C:\MSYS).
#   4. Doubleclick C:\MSYS\msys.bat
#     * If you want to use other MinGW, edit /etc/fstab.
#
#  Now, you finished all the preparations to run this script.
#  Save this script into $HOME as 'my_build.sh', and type './my_build.sh' on bash.

./get_source.sh

echo Building ffmpeg x86 and x64.  This could take a few hours...
(./build_x86.sh &> x86.log) &
(./build_x64.sh &> x64.log) &
wait

echo Done building ffmpeg x86 and x64

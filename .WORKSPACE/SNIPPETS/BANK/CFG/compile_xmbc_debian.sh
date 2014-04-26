sudo apt-get install subversion
cd $HOME
svn checkout http://xbmc.svn.sourceforge.net/svnroot/xbmc/trunk xbmc
 
sudo apt-get install autopoint
 
sudo add-apt-repository ppa:team-xbmc-svn
sudo apt-get update
 
apt-get build-dep -y xbmc
 
# GLES only
apt-get install libegl1-mesa-dev libgles2-mesa-dev
 
cd xbmc
 
./bootstrap
 
# default config
./configure
 
# minimal GLES config
./configure --enable-gles --enable-openmax --disable-pulse --disable-optimizations --disable-ccache \
--disable-xrandr --disable-vdpau --disable-webserver --disable-dvdcss --disable-hal --disable-avahi \
--disable-faac --disable-rtmp --disable-joystick
 
make
 
 
# LINKS
http://wiki.xbmc.org/index.php?title=HOW-TO_compile_XBMC_for_Linux_on_Debian/Ubuntu
https://xbmc.svn.sourceforge.net/svnroot/xbmc/trunk/README.ubuntu
 
 
 
 
 
 
# OLD version
 
# dependency for compile on ubuntu 8.04
sudo apt-get install apt-get install make g++-4.1 gcc-4.1 libsdl1.2-dev libsdl-image1.2-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev libsdl-sound1.2-dev libsdl-stretch-dev libfribidi0 libfribidi-dev liblzo1 liblzo-dev libfreetype6 libfreetype6-dev libsqlite3-0 libsqlite3-dev libogg-dev libasound2-dev python2.4-dev python2.4 python-sqlite libglew1.5 libglew1.5-dev libcurl3-dev g++ gawk x11proto-xinerama-dev libxinerama-dev libxrandr-dev libxrender-dev libmms-dev pmount libmad0-dev libtre-dev libogg-dev libvorbis-dev libmysqlclient15-dev libhal1 libhal-dev libhal-storage1 libhal-storage-dev libpcre3-dev subversion libjasper1 libfontconfig-dev
 
cd /tmp
svn checkout https://xbmc.svn.sourceforge.net/svnroot/xbmc/branches/linuxport/XBMC
 
cd XBMC
svn up
./configure --disable-debug
make
 
# optional
make install
 
 
# LINKS
# http://xbmc.svn.sourceforge.net/viewvc/*checkout*/xbmc/branches/linuxport/XBMC/README.linux

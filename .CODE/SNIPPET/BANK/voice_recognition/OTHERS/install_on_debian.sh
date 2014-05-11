#!/bin/bash - 
#====================================================================
#
#   DESCRIPTION: on Debian-based systems, installs dependencies for 
#   blather, gets source code for sphinx stuff, builds, installs 
#   program, config files, and so forth. USE AT YOUR OWN RISK! 
#   READ THE SCRIPT CAREFULLY AND DECIDE IF YOU WANT TO USE IT
# 
#  REQUIREMENTS: debian-based system, sudo privileges
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jonathan Kulp ()
#       CREATED: 07/09/2013 09:03:38 PM CDT
#====================================================================

user=$(whoami)
builddir="/home/$user/blather"
configdir="/home/$user/.config/blather"

install_deps(){
  buildtools="git build-essential gnome-common bison"
  libs="python-pyside libgstreamer-plugins-base0.10-dev libgstreamer0.10-cil-dev libgstreamer0.10-dev python-gst0.10-dev rygel-gst-launch gstreamer0.10-plugins-good python-sphinx gstreamer0.10-tools python-gtk2 python-gtk2-dev"
  packages="xvkbd xdotool espeak wmctrl elinks xclip curl"
  sudo apt-get update
  sudo apt-get install $buildtools $libs $packages
}

get_sphinx(){
  version="0.8"
  cd /home/$(whoami)
  wget http://sourceforge.net/projects/cmusphinx/files/sphinxbase/$version/sphinxbase-$version.tar.gz
  tar xvf sphinxbase-$version.tar.gz
  cd sphinxbase-$version/
  ./autogen.sh && make && sudo make install
}

get_pocketsphinx(){
  version="0.8"
  cd /home/$(whoami)
  wget http://sourceforge.net/projects/cmusphinx/files/pocketsphinx/$version/pocketsphinx-$version.tar.gz
  tar xvf pocketsphinx-$version.tar.gz
  cd pocketsphinx-$version/
  ./autogen.sh && make && sudo make install
  sudo cp ./src/gst-plugin/.libs/libgstpocketsphinx.so /usr/local/lib/gstreamer-0.10/
}

get_blather(){
  cd /home/$user
  git clone git://gitorious.org/blather/blather.git
}

conf(){
startupscript=/home/$user/bin/blather.sh
mkdir -p $configdir
cp $builddir/commands.tmp $configdir/commands.conf
# create a startup script
cat > $startupscript << EOFstartup
#!/bin/bash

# tell it where the Gstreamer libraries are located

export GST_PLUGIN_PATH=/usr/local/lib/gstreamer-0.10

# set some shortcuts to use in the commands file

export VOICE="/usr/bin/espeak"
export CONFIGDIR="/home/$(whoami)/.config/blather"
#export KEYPRESS="xvkbd -xsendevent -secure -text"
#export BROWSER="firefox"

# start blather in continuous mode with the GTK GUI 
# and a history of 20 recent commands

python2 $builddir/Blather.py -c -i g -H 20
EOFstartup

chmod +x $startupscript
}

install_deps
get_sphinx
get_pocketsphinx
get_blather
conf

exit 0

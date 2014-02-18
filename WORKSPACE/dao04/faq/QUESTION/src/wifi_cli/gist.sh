
http://askubuntu.com/questions/55805/how-do-i-re-install-network-manager-without-an-internet-connection

The following describes how to establish a wireless network connection via command line utilities.

I think this is a better option because it gives you the useful ability to interface with relevant command line utilities.

Use ifconfig -a to identify your wireless card. From hence forward, I will assume it's eth1.
sudo ifconfig eth1 up
iwlist eth1 scan to find available networks. iwlist eth1 scan | less if it's a long list.
sudo iwconfig eth1 essid [network] [key [pass]] Also, read man iwconfig to figure out how the wifi password is entered. You might also need to configure the channel and stuff.
If you use WPA, wpa_supplicant will be necessary. http://ubuntuforums.org/showthread.php?t=263136
sudo dhclient eth1
sudo service networking restart

http://linuxpoison.blogspot.co.il/2008/07/network-configuration-for-debian.html
The network interfaces in debian are configured in /etc/network/interfaces. There are scripts to bring things up and down (i.e. "ifup eth0"), although "ifconfig eth0 up" should work, too. This would be a basic configurations...

If you want to get the ip using dhcp

#/etc/network/interfaces
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet dhcp

Or for a static IP

#/etc/network/interfaces
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
address 192.168.0.100
netmask 255.255.255.0
gateway 192.168.0.1
broadcast 192.168.0.255

Read more: http://linuxpoison.blogspot.co.il/2008/07/network-configuration-for-debian.html#ixzz30Zmnu300

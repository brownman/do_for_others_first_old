echo Let’s set up a Docker container on your Vagrant machine:

echo SSH in Vagrant if you’re not in already:

vagrant ssh
echo Install Docker, as explained on the official website:

sudo apt-get update
sudo apt-get install linux-image-generic-lts-raring linux-headers-generic-lts-raring
sudo reboot
sudo sh -c "curl https://get.docker.io/gpg | apt-key add -"
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get install lxc-docker
echo Verify it worked by trying to build your first container:

sudo docker run -i -t ubuntu /bin/bash

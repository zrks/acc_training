#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive

# echo "Updating..."
# 	apt-get update > /dev/null

echo "Installing Vim..."
	apt-get install vim -y > /dev/null

echo "Installing htop..."
	apt-get install htop -y > /dev/null

echo "Installing tree..."
	apt-get install tree -y > /dev/null

echo "Installing tmux..."
	apt-get install tmux -y > /dev/null

echo "Installing Git..."
    apt-get install git -y > /dev/null

echo "Installing ShellCheck..."
	apt-get install shellcheck -y > /dev/null

echo "Installing dos2unix..."
	apt-get install dos2unix -y > /dev/null

echo "Installing pip2 & 3..."
	apt-get install python-pip -y > /dev/null	
	apt-get install python3-pip -y > /dev/null

echo "Installing ipython2 & 3..."
	apt-get install ipython ipython3 -y > /dev/null

# echo "Installing Docker..."
# 	apt-get install apt-transport-https ca-certificates -y > /dev/null && \
# 	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
# 	echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
# 	apt-get update > /dev/null && \
# 	apt-get install docker-engine -y > /dev/null && \
# 	service docker start

echo "Configuring docker..."
	 groupadd docker && usermod -aG docker vagrant

echo "Creating jenkins directory..."
	mkdir /home/vagrant/jenkins/

echo "Setting aliases..."
	echo "alias c=clear" >> /home/vagrant/.bash_aliases

echo "Setting tmux config..."
	git clone https://gist.github.com/7ffa37264763b230c6ac.git ./tmux-config && mv ./tmux-config/.tmux.conf ./ && rm -rf tmux-config/

echo "Setting vi config..."
	git clone https://gist.github.com/bb6361445a7bbefb3008.git ./vi-config && mv ./vi-config/.vimrc ./ && rm -rf vi-config/

echo "Getting Vundle for Vi..."
	git clone https://github.com/VundleVim/Vundle.vim.git /home/vagrant/.vim/bundle/Vundle.vim

echo "Configuring swap space..."
	fallocate -l 2G /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile && \
	echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab

echo "Installing Jenkins..."
	wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
	sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
	apt-get update > /dev/null
	set +e
	apt-get install jenkins -y > /dev/null
	set -e
	service jenkins start

	service jenkins status

echo "Done!"

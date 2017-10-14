#!/bin/bash
# Author: Panhao Wu

cd $HOME

sudo apt update
sudo apt install -y \
	python-pip \
	git \
	mpg123 
sudo pip install --upgrade pip
sudo pip install setuptools && sudo pip install flask

git clone https://github.com/wupanhao/py-web-player

mkdir Music

#sudo mount /dev/sda1 $HOME/Music
echo "sh $HOME/py-web-player/start.sh " >> $HOME/start.sh
sudo sed -i "/^exit/i\nohup sh $HOME/start.sh  &"  /etc/rc.local

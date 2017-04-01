# py-web-player

This is a small script  for my raspberrypi 
You can use it to control your pi to play music

## Get the code
To get the code,you could run
```
git clone https://github.com/wupanhao/py-web-player.git
```
if you didn't install git,you need to run ```sudo apt-get install git``` to install it


## Usage
To run this script , you will need to install some modules

```
sudo apt-get install mpg123
sudo apt-get install python-pip
sudo pip install flask
```

put your music file to /home/pi/kugou/ ,or you could edit the default dir

then you can ```cd py-web-player``` and run ```python webplayer.py &``` to start the server

if successful,you can open the webpage [you raspberrpi's ip]:5000 to control your pi to play music

#coding=utf-8
from flask import Flask,request,render_template
import os
import sys
import thread
import subprocess
import time
reload(sys)
sys.setdefaultencoding('utf-8')
app = Flask(__name__)
root_dir = '/home/pi/kugou'
playing = None
player='omxplayer '
lists = []
current = root_dir

def list_play():
	global playing
	while True:
		if lists and not playing:
			playing = lists.pop()
			os.system(player +'"'+ playing +'" ')	
			os.system("killall omxplayer.bin" )
			playing = None
			time.sleep(5)
		else :	time.sleep(10)
		print lists		

thread.start_new_thread(list_play,())

@app.route('/')
def index():
	global playing
	global lists
	global current
	if request.args.get('path') and os.path.isdir(request.args.get('path')):
		current = request.args.get('path') 
	music = request.args.get('music')
	add = request.args.get('add')
	cmd = request.args.get('cmd')
	rm = request.args.get('rm')
	files = os.listdir(current)
	musics = []
	dirs = []
	stat = subprocess.check_output('ps aux | grep omxplayer  | wc -l',shell=True)
	if stat == 1 :
		playing = None
	for file in files:
		if os.path.isdir(current + '/' + file):	dirs.append(file)
		elif file[-4:] == '.mp3' :	musics.append(file)
	dirs.append('..')
	musics.sort()
	dirs.sort()
	if music:
		print music
		
	#	thread.start_new_thread(os.system,player +'"'+ music+'" &')
		os.system("killall omxplayer.bin" )
		os.system(player +'"'+ music+'" &')
		playing = music
#		return music + 'is on playing\n' + render_template('views.html',current = path , dirs = dirs ,musics = musics)
	if cmd:
		if cmd == 'killall':
			os.system("killall omxplayer.bin" )
			playing =  None
	if add:	
		print add
		lists.append(add)
	if rm:
		print rm
		lists.remove(rm)
	print playing
	mlists = []
	for list in lists:
		mlists.append(os.path.basename(list))
	return render_template('views.html',playing = playing,lists = lists ,mlists = mlists,current = current , dirs = dirs ,musics = musics)


if __name__ == '__main__':
    app.run("0.0.0.0")

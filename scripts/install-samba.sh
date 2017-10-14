#!/bin/bash
# Author: Panhao Wu

#sudo apt update
#sudo apt install -y samba
sudo cat >> /etc/samba/smb.conf  << EOF
[Music]
	path = $HOME/Music
	guest ok = yes
	read only = no	
EOF

sudo service smbd restart

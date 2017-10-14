#sudo apt install hostapd udhcpd
sudo cat > /etc/hostapd/hostapd.conf  << EOF
#ThisisthenameoftheWiFiinterfaceweconfiguredabove
interface=wlan0
#Usethenl80211driverwiththebrcmfmacdriver
driver=nl80211
#Thisisthenameofthenetwork
ssid=OrangePi_Zero
#Usethe2.4GHzband
hw_mode=g
#Usechannel6
channel=6
#Enable802.11n
ieee80211n=1
#EnableWMM
wmm_enabled=1
#Enable40MHzchannelswith20nsguardinterval
ht_capab=[HT40]
#NotsureifOPisupportsthese:
#[sHORT-GI-20][DSSS_CCK-40]
#AcceptallMACaddresses
macaddr_acl=0
#UseWPAauthentication
auth_algs=3
#Requireclientstoknowthenetworkname
ignore_broadcast_ssid=0
#UseWPA2
wpa=2
#Useapre-sharedkey
wpa_key_mgmt=WPA-PSK
#Thenetworkpassphrase
wpa_passphrase=orangepi
#UseAES,insteadofTKIP
rsn_pairwise=CCMP
EOF
sudo sed -i '/^#DAEMON_CONF/i\DAEMON_CONF="/etc/hostapd/hostapd.conf"' /etc/default/hostapd 

sudo sed -i 's/eth0/wlan0/' /etc/udhcpd.conf 
sudo sed -i 's/^DHCPD_ENABLED/#DHCPD_ENABLED/' /etc/default/udhcpd
sudo service udhcpd restart
sudo cat >> /etc/network/interfaces << EOF
allow-hotplug wlan0
iface wlan0 inet static
  address 192.168.0.1
  netmask 255.255.255.0
EOF

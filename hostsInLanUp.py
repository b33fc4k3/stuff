import os, sys

for ip in (range 1 254):
	os.system("ping -c 1 192.168.102." + ip)

# http://www.cyberciti.biz/faq/mapping-lan-with-linux-unix-ping-command/
# fping
# ping -b 192.168.102.255
# arping 192.168.102.1
# nmap -sP 192.168.102.0/24
# arp-scan -l

# cat /boot/System.map-(uname -r)
# xset b off # sets off bell in terminal

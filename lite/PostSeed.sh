#!/bin/bash

# Authors: J0nan / n0t4u
# Version: 1.2.0
# Description: Automatic installation of hacking tools on Kali Lite

DEBIAN_FRONTEND=noninteractive

# Source: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# Regular Colors
Red='\033[0;31m'		  # Red
Green='\033[0;32m'		# Green
Yellow='\033[0;33m'		# Yellow
Blue='\033[0;34m'		  # Blue
ColorOff='\033[0m'		# Text Reset

# Setup
# Change hostname to kali due to vbox changing it
current_hostname=$(hostname)
if [ "$current_hostname" == "vbox" ]; then
  echo "${Blue}[*] Current hostname is 'vbox'. Changing it to 'kali'...${ColorOff}"
  hostnamectl set-hostname kali
  sed -i 's/vbox/kali/g' /etc/hosts
  echo "kali" | sudo tee /etc/hostname > /dev/null
fi

# Configuration of the terminal
mkdir -p /home/kali/.config/qterminal.org
wget --no-check-certificate -O /home/kali/.config/qterminal.org/qterminal.ini https://raw.githubusercontent.com/J0nan/AutoKali/refs/heads/main/lite/qterminal.ini
chown -R kali:kali /home/kali/.config/qterminal.org

# Change the default terminal to zsh
chsh -s /bin/zsh root
chsh -s /bin/zsh kali

# # Add kali user to vboxsf group, needed to access shared folders
groupadd vboxsf
usermod -a -G vboxsf kali

# Power manager XFCE in user kali
# Disabling power safe, blank screen and switch-off in the monitor
mkdir -p /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml
wget --no-check-certificate -O /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml https://raw.githubusercontent.com/J0nan/AutoKali/refs/heads/main/lite/xfce4-power-manager.xml
chown -R kali:kali /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml
chmod 664 /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml

# General purpose tools
# Python3 and PIP3
echo -e "${Blue}[*] Installing python3 ${ColorOff}"
apt install python3 python3-venv -y

# git
echo -e "${Blue}[*] Installing git${ColorOff}"
apt install git -y

# Go
echo -e "${Blue}[*] Installing go and dependencies (BETA)${ColorOff}"
apt install golang-go -y
go env -w GOBIN="/opt/go/bin"
echo -en 'export PATH="$PATH:/usr/local/go/bin:/opt/go/bin"\ngo env -w GOBIN="/opt/go/bin"' >>/etc/profile
mkdir -p /opt/go/bin
chown -R kali:kali /opt/go/bin

# Docker + docker compose
echo -e "${Blue}[*] Installing Docker and docker compose${ColorOff}"
apt remove docker.io docker-compose -y
apt update
apt install ca-certificates curl -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "bookworm") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl disable docker.service
systemctl disable docker.socket
usermod -a -G docker kali

# Dig and Nslookup
echo -e "${Blue}[*] Installing dnsutils (dig, nslookup)${ColorOff}"
apt install dnsutils -y

# Web applications tools
# Nuclei
echo -e "${Blue}[*] Installing nuclei${ColorOff}"
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Testssl.sh
echo -e "${Blue}[*] Installing testssl${ColorOff}"
git clone https://github.com/drwetter/testssl.sh.git /opt/testssl
ln -s /opt/testssl/testssl.sh /usr/bin/testssl

# wafw00f
echo -e "${Blue}[*] Installing wafw00f${ColorOff}"
apt remove wafw00f -y
pipx install git+https://github.com/EnableSecurity/wafw00f.git
ln -s /.local/share/pipx/venvs/wafw00f/bin/wafw00f /usr/bin/wafw00f

# httpx
echo -e "${Blue}[*] Installing httpx${ColorOff}"
rm /usr/bin/httpx
go install github.com/projectdiscovery/httpx/cmd/httpx@latest

# Dirb
echo -e "${Blue}[*] Installing dirb${ColorOff}"
apt install dirb -y

# Gobuster
echo -e "${Blue}[*] Installing gobuster${ColorOff}"
apt install gobuster -y

# AMASS
echo -e "${Blue}[*] Installing AMASS${ColorOff}"
apt install amass -y

# Subfinder
echo -e "${Blue}[*] Installing subfinder${ColorOff}"
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Arjun
echo -e "${Blue}[*] Installing arjun${ColorOff}"
pipx install arjun
ln -s /.local/share/pipx/venvs/arjun/bin/arjun /usr/bin/arjun

# ffuf
echo -e "${Blue}[*] Installing ffuf${ColorOff}"
apt install ffuf -y 

# Bypass-403
echo -e "${Blue}[*] Installing Bypass-403${ColorOff}"
git clone https://github.com/iamj0ker/bypass-403 /opt/bypass-403
chmod +x /opt/bypass-403/bypass-403.sh
ln -s /opt/bypass-403/bypass-403.sh /usr/bin/bypass-403

# Corsy
echo -e "${Blue}[*] Installing Corsy${ColorOff}"
git clone https://github.com/s0md3v/Corsy /opt/corsy
python3 -m venv /opt/corsy
/opt/corsy/bin/python /opt/corsy/bin/pip install -r /opt/corsy/requirements.txt
chmod +x /opt/corsy/corsy.py
ln -s /opt/corsy/corsy.py /usr/bin/corsy

# git-dumper
echo -e "${Blue}[*] Installing git-dumper${ColorOff}"
mkdir -p /opt/git-dumper
curl -s -k https://api.github.com/repos/holly-hacker/git-dumper/releases/latest \
| grep "browser_download_url.*linux\"" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget --no-check-certificate -O /opt/git-dumper/git-dumper -qi -
chmod +x /opt/git-dumper/git-dumper
ln -s /opt/git-dumper/git-dumper /usr/bin/git-dumper

# Infrastructure tools
# Onesixtyone (SNMP)
echo -e "${Blue}[*] Installing onesixtyone${ColorOff}"
apt remove onesixtyone -y
git clone https://github.com/trailofbits/onesixtyone.git /opt/onesixtyone
gcc -o /opt/onesixtyone/onesixtyone /opt/onesixtyone/onesixtyone.c
ln -s /opt/onesixtyone/onesixtyone /usr/bin/onesixtyone

# dnsrecon
echo -e "${Blue}[*] Installing dnsrecon${ColorOff}"
apt install dnsrecon

# domain_analyzer
echo -e "${Blue}[*] Installing domain_analyzer${ColorOff}"
git clone https://github.com/eldraco/domain_analyzer.git /opt/domain_analyzer
python3 -m venv /opt/domain_analyzer
/opt/domain_analyzer/bin/python /opt/domain_analyzer/bin/pip install -r /opt/domain_analyzer/requirements.txt
chmod +x /opt/domain_analyzer/domain_analyzer.py
ln -s /opt/domain_analyzer/domain_analyzer.py /usr/bin/domain_analyzer

# dnsmasq
echo -e "${Blue}[*] Installing dnsmasq${ColorOff}"
apt install dnsmasq -y

# SSH-Audit
echo -e "${Blue}[*] Installing ssh-audit${ColorOff}"
git clone https://github.com/jtesta/ssh-audit /opt/ssh-audit
chmod +x /opt/ssh-audit/ssh-audit.py
ln -s /opt/ssh-audit/ssh-audit.py /usr/bin/ssh-audit

# SSLScan
echo -e "${Blue}[*] Installing SSLScan${ColorOff}"
apt install sslscan -y


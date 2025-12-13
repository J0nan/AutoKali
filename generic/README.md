# Kali Generic <!-- omit in toc -->

## What it does

### Preseed.cfg

#### Credentials

User: `kali`
Password: `kali`

### PostSeed.sh

This script is executed by the installer after performing all the configurations and updating all the packages already install on the OS. The script does some [configuration](#configuration) and install some useful [tools](#tools).

#### Configuration

- Removes the transparency of the terminal.
- Disables power safe, blank screen and switch-off in the monitor

#### Tools

##### General Purpose

- python3 & python3-venv
- git
- golang-go
- docker (The services are disabled, use this to start them `systemctl start docker.service; systemctl start docker.socket`)
- snapd
- [SecList](https://github.com/danielmiessler/SecLists)
- dnsutils
- [DBeaver](https://dbeaver.io/)
- [VSCodium](https://github.com/VSCodium/vscodium) (Added an alias so it can be launch with `code` as well as with `codium`)
<!-- - [LibreOffice](https://www.libreoffice.org/) -->

##### Web applications tools

- [Nuclei](https://github.com/projectdiscovery/nuclei)
- [Interactsh](https://github.com/projectdiscovery/interactsh)
- [Testssl.sh](https://github.com/drwetter/testssl.sh)
- [wafw00f](https://github.com/EnableSecurity/wafw00f)
- [httpx](https://github.com/projectdiscovery/httpx)
- dirb
- gobuster
- [AMASS](https://github.com/owasp-amass/amass)
- [Subfinder](https://github.com/projectdiscovery/subfinder)
- arjun
- ffuf
- [Bypass-403](https://github.com/iamj0ker/bypass-403)
- [Corsy](https://github.com/s0md3v/Corsy)
- EyeWitness
- [git-dumper](https://github.com/holly-hacker/git-dumper)

##### Infrastructure tools

- [Onesixtyone](https://github.com/trailofbits/onesixtyone)
- dnsrecon
- [Domain Analyzer](https://github.com/eldraco/domain_analyzer)
- dnsmasq
- [ssh-audit](https://github.com/jtesta/ssh-audit)
- [Terrapin-Scanner](https://github.com/RUB-NDS/Terrapin-Scanner)
- [JexBoss](https://github.com/joaomatosf/jexboss)
- sslscan

##### Mobile Tools

- jadx
- google-android-platform-tools-installer
- [scrcpy](https://github.com/Genymobile/scrcpy)

##### WiFi tools

- [Airgeddon](https://github.com/v1s1t0r1sh3r3/airgeddon)

##### Cracking

- [COOK](https://github.com/glitchedgitz/cook)

## Update

Work in progress...

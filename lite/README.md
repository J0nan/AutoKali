# Kali Lite <!-- omit in toc -->

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
- dnsutils

##### Web applications tools

- [Nuclei](https://github.com/projectdiscovery/nuclei)
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
- [git-dumper](https://github.com/holly-hacker/git-dumper)

##### Infrastructure tools

- [Onesixtyone](https://github.com/trailofbits/onesixtyone)
- dnsrecon
- [Domain Analyzer](https://github.com/eldraco/domain_analyzer)
- dnsmasq
- [ssh-audit](https://github.com/jtesta/ssh-audit)
- sslscan

## Update

Work in progress...

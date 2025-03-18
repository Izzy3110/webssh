# webssh
Webssh on Ubuntu

## Installation steps
 - Install neccesary apt-packages (nginx, letsencrypt, python3, python3-pip, python-is-python3
 - Install system-wide webssh
 - Allow nginx and ssh access in ufw
 - Setting up nginx systemd
 - Request SSL-Certificate from letsencrypt
 - Setup cron.d for certificate auto-renewal
 - Setup systemd for webssh

### &#9888; Attention!
Requires Domain/Subdomain setup on a DNS-Server for the letsencrypt certificate request

### Installation
```
git clone https://github.com/Izzy3110/webssh
cd webssh
```

#### Modify the install.sh and setup your email and domain/subdomain


#### Install and setup webssh
```
bash install.sh
```

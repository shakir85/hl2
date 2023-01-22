#!/bin/bash
set -ex


if [ "$EUID" -ne 0 ]; then
    error "Please run as root"
    exit
else

# Get IP from local ip address
IPorFQDN=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')

# Disable swap
swapoff --all

# Load docker daemon config
tee /etc/docker/daemon.json >/dev/null <<EOF
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "insecure-registries" : ["$IPorFQDN:443","$IPorFQDN:80","0.0.0.0/0"],
    "log-driver": "journald",
}
EOF

# Reload Docker to pickup new daemon.json configs
systemctl reload docker.service
sleep 5

# Downloas latest stable Harbor release
wget -q $(curl -s https://api.github.com/repos/goharbor/harbor/releases/latest|grep browser_download_url|grep online|cut -d'"' -f4|grep '.tgz$'|head -1) -O harbor-online-installer.tgz

# Untar in the current directory & set the custom config file
tar xvf harbor-online-installer.tgz
cd harbor
cp harbor.template.yml harbor.yml

# Create default log dir, all Harbor related services (postgres, redis, ..etc) will
# log to this path
mkdir -p /var/log/harbor

# Run Harbor's installer
./install.sh --with-chartmuseum
echo "Harbor Installation Complete"
echo "Restart docker deamon and to Login to harbor instance:"
echo "docker login -u admin -p Harbor12345 $IPorFQDN"

fi

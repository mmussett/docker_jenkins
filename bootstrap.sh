#! /bin/bash -e

# Check we are root
if [[ $EUID -ne 0 ]]; then
  echo "Thi script must be run as root"
  exit 1
fi

# Check to see if docker is already installed
if [[ -x "$(command -v docker)" ]]; then
  echo "Docker already installed"
  exit 1
fi

# Remove any references to Debian CDROM repositories or next line will fail
sed -i "s/\(^deb cdrom.*$\)/\#/g" /etc/apt/sources.list

# Update/upgrade apt
apt-get update && apt-get upgrade -y

# Install dependencies for docker to run
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Download docker repository key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add docker repository key to apt
add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

# Update apt now we've added docker repository
apt-get update

# Install docker CE
apt-get install -y docker-ce

# Install docker compose
curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

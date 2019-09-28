#! /bin/bash -e
if [[ $EUID -ne 0 ]]; then
  echo "Thi script must be run as root"
  exit 1
fi

sed -i "s/\(^deb cdrom.*$\)/\#/g" /etc/apt/sources.list

apt-get update && apt-get upgrade -y && apt-get install -y curl

curl -fsSL https://get.docker.com -o get-docker.sh

sh get-docker.sh
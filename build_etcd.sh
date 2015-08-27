#!/bin/sh

if [ $# -gt 0 ]
then
  ETCD_VERSION="$1";
else
  ETCD_VERSION="master";
fi

echo "Using ETCD version $ETCD_VERSION"

git clone https://github.com/coreos/etcd.git
cd etcd
git checkout $ETCD_VERSION
./build

#Temporal solution to travis issue #155
sudo rm -rf /dev/shm && sudo ln -s /run/shm /dev/shm
echo "All Done"

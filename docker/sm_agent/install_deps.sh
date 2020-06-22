#!/bin/bash
set -e

VERSIONS=("2.7.14" "3.7.4")
LOCALBIN="/usr/local/bin"
exec 2> ./stderr.log

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

[[ ":$PATH:" != *":$LOCALBIN:"* ]] && PATH="$LOCALBIN:${PATH}"

yum update -y && yum install yum-utils -y && \
    yum groupinstall "Development Tools" -y

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install wget bzip2-devel \
    docker-ce docker-ce-cli containerd.io \
    sqlite libffi-devel gcc gcc-c++ \
    yum-utils python-devel python3-devel zlib-devel \
    openssl-devel epel-release supervisor \
    at sharutils -y

systemctl enable --now atd

for VERSION in ${VERSIONS[@]};
do
    PYURL="https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz"
    PKGARCHIVE=${PYURL##*/}
    PKGNAME=${PKGARCHIVE%%.tgz*}
    cd /usr/local
    
    echo "Dowloading Python ${VERSION}..."
    wget $PYURL
    tar -xzf ${PKGARCHIVE}
    cd $PKGNAME
    ./configure --prefix=/usr/local --enable-unicode=ucs4
    make
    make altinstall
done

ln -s /usr/local/bin/python2.7 /usr/local/bin/python2
ln -s /usr/local/bin/python3.7 /usr/local/bin/python3

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python2 get-pip.py && python3 get-pip.py

pip2 install --upgrade pip
pip3 install --upgrade pip
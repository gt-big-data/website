apt-get -qq -o Dpkg::Use-Pty=0 update
apt-get -qq -o Dpkg::Use-Pty=0 install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - -qq
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" -qq
apt-get -qq -o Dpkg::Use-Pty=0 update
apt-get -qq -o Dpkg::Use-Pty=0 install -y docker-ce
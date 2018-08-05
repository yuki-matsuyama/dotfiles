sudo apt-get remove -y docker docker-engine docker.io
uname -r
sudo apt-get update
sudo apt-get install  -y    apt-transport-https      ca-certificates      curl      gnupg2      software-prope
ommon
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/debian \
b_release -cs) \
le"
sudo apt-get -y update
sudo apt-get -y install docker-ce
sudo docker run hello-world

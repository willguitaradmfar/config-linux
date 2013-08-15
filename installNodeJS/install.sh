read -p "DOCUMENTACAO 

./install.sh /usr/local/src 10
 " pause


cd $1
sudo mkdir -p node
USUARIO=$USER
sudo wget -O node/node-v0.$2.0.tar.gz http://nodejs.org/dist/v0.$2.0/node-v0.$2.0-linux-x64.tar.gz
cd node && sudo tar -zxvf node-v0.$2.0.tar.gz
sudo chown root.root -R $1/node

sudo rm -f /usr/local/bin/node
sudo rm -f /usr/local/bin/npm
sudo ln -s $1/node/node-v0.$2.0-linux-x64/bin/node /usr/local/bin/node
sudo ln -s $1/node/node-v0.$2.0-linux-x64/bin/npm /usr/local/bin/npm

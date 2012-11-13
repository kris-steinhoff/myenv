# copy this script to a new home directory to bootstrap it

echo 'test -r ${HOME}/.bashrc && source ${HOME}/.bashrc' >> ~/.bash_profile
mkdir src bin
cd src
git clone git://github.com/ksteinhoff/myenv.git ~/src/myenv
cd ~/src/myenv
git submodule init
git submodule update
./install.sh

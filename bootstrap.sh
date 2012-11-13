# copy this script to a new home directory to bootstrap it

cd ${HOME}
echo 'test -r ${HOME}/.bashrc && source ${HOME}/.bashrc' >> ${HOME}/bash_profile
mkdir src bin
cd src
git clone git://github.com/ksteinhoff/myenv.git ${HOME}/src/myenv
cd myenv
git submodule init
git submodule update
./install.sh
source ${HOME}/.bashrc

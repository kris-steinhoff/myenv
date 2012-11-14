This is a collection of shell configuration files and utilities that I use in
a number of places. I have collected it here to make my life easier whenr
starting work on a new machine.

**To clone:**

1. Clone this repository: git clone git://github.com/ksteinhoff/myenv.git ~/src/myenv
2. Change to the cloned repository: cd ~/src/myenv
2. Update the submodule file: git submodule init
3. Update the submodule repositories: git submodule update
4. Install the config and utilities: ./install.sh

**To update:**

1. Change to the repository: cd ~/src/myenv
2. Update the submodule repositories: git submodule update
3. Install the config and utilities: ./install.sh

`cd ~/src/myenv && git pull && git submodule update && ./install.sh && source ~/.bashrc`

Kris Steinhoff, 2012

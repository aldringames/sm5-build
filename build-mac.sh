#!/bin/bash -e
_msg() {
	echo -e "\e[1;32m>>\e[m $1"
}

_msg "Entering sm"
git clone --depth=1 https://github.com/stepmania/stepmania.git sm
cd sm
_msg "Using SM5-Build derivatives"
rm -rf Themes/{default,home,legacy}
git clone --depth=1 https://github.com/Simply-Love/Simply-Love-SM5.git "Themes/Simply Love"
rm -rf Themes/*/.git
_msg "Configuring sm"
cd Build
cmake -DCMAKE_BUILD_TYPE=Release ..
_msg "Building sm"
ls
cmake --build .
ls
cpack
ls

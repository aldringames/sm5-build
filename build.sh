#!/bin/bash -e
_msg() {
	echo -e "\e[1;32m>>\e[m $1"
}

mkdir StepMania
_msg "Entering sm"
git clone --depth=1 --recurse-submodules https://github.com/stepmania/stepmania.git sm
cd sm/Build
_msg "Configuring sm"
cmake -DCMAKE_BUILD_TYPE=Release -G Ninja .. >> ../../StepMania/build.log
_msg "Building sm"
ls
ninja >> ../../StepMania/build.log
ls
cpack
ls
cd ..

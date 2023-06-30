#!/bin/bash -e
_msg() {
	echo -e "\e[1;32m>>\e[m $1"
}

mkdir StepMania
_msg "Entering sm"
git clone --depth=1 https://github.com/stepmania/stepmania.git sm
cd sm/Build
_msg "Configuring sm"
cmake -DCMAKE_BUILD_TYPE=Release -G Xcode >> ../../StepMania/build.log
_msg "Building sm"
cmake .. >> ../../StepMania/build.log
cpack
ls
cd ..

#!/bin/bash -e
_msg() {
	echo -e "\e[1;32m>>\e[m $1"
}

mkdir StepMania
_msg "Entering sm"
git clone --depth=1 --recurse-submodules https://github.com/stepmania/stepmania.git sm
cd sm/Build
_msg "Configuring sm"
cmake -DCMAKE_BUILD_TYPE=Release \
      -DWITH_SYSTEM_FFMPEG=ON    \
      -DWITH_SYSTEM_GLEW=ON      \
      -DWITH_SYSTEM_JPEG=ON      \
      -DWITH_SYSTEM_JSONCPP=ON   \
      -DWITH_SYSTEM_MAD=ON       \
      -DWITH_SYSTEM_OGG=ON       \
      -DWITH_SYSTEM_PCRE=ON      \
      -DWITH_SYSTEM_PNG=ON       \
      -DWITH_SYSTEM_TOMCRYPT=ON  \
      -DWITH_SYSTEM_TOMMATH=ON   \
      -DWITH_SYSTEM_ZLIB=ON      \
      -G Ninja .. >> ../../StepMania/build.log
_msg "Building sm"
ninja >> ../../StepMania/build.log
cd ..
ls

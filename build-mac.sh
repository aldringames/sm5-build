#!/bin/bash -e
_msg() {
	echo -e "\e[1;32m>> \e[m$1..."
}

for arch in x86_64 arm64
do
	_msg "Entering sm (${arch})"
	git clone --depth=1 https://github.com/stepmania/stepmania.git "sm-${arch}"
	cd "sm5-${arch}"
	_msg "Using SM5-Build derivatives"
	rm -rf Themes/{default,home,legacy}
	git clone --depth=1 https://github.com/Simply-Love/Simply-Love-SM5.git "Themes/Simply Love"
	rm -rf Themes/*/.git
	_msg "Configuring sm (${arch})"
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_ARCHITECTURES="${arch}" -G XCode ..
	_msg "Building sm"
	ls
	xcodebuild -project StepMania.xcodeproj -configuration Release
	ls
	cpack
	ls
done

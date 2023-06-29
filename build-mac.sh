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
rm -rf "Songs/StepMania 5"
_msg "Configuring sm"
cd Build
cmake -DCMAKE_BUILD_TYPE=Release ..
_msg "Building sm"
cmake --build .
_msg "Creating dmg archive using cpack"
cpack
mkdir ../../SM5
tar -xf *.tar* -C ../../SM5
cd ../../SM5
mv * StepMania
datestamp="$(date +%Y%m%d)"
echo "$datestamp" >> StepMania/date.stamp
cd ..
create-dmg --volname StepMania "SM5-Build-$datestamp-mac.dmg" SM5
echo "DATESTAMP=$datestamp" >> "$GITHUB_ENV"
rm -rf sm SM5

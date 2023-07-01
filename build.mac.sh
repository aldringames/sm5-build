#!/bin/bash -e
_msg() {
	echo -e "\e[1;32m>>\e[m $1"
}

mkdir StepMania
_msg "Entering sm"
git clone --depth=1 https://github.com/stepmania/stepmania.git sm
cd sm/Build
_msg "Configuring sm"
cmake -DCMAKE_BUILD_TYPE=Release -Wno-dev .. >> ../../StepMania/build.log
_msg "Building sm"
cmake --build . >> ../../StepMania/build.log
cd ..
_msg "Using SM5-Build derivatives"
rm -rf Themes/{default,home,legacy}
git clone --depth=1 https://github.com/Simply-Love/Simply-Love-SM5.git "Themes/Simply Love"
rm -rf Themes/*/.git
rm -rf "Songs/StepMania 5"
rm -rf Courses/Default/Jupiter.*
_msg "Copying StepMania files"
cp -rf {Announcers,Background{Effects,Transitions},BGAnimations,Characters,Courses,Data,Docs,Manual,NoteSkins,Scripts,Songs,Themes,StepMania.app} ../StepMania
cd ..
datestamp="$(date +%Y%m%d)"
echo "$datestamp" > StepMania/date.stamp
mkdir dmg
mv StepMania dmg
_msg "Create archive as SM5-Build"
create-dmg --volname "SM5-Build-$datestamp" SM5-Build-$datestamp-mac.dmg dmg
rm -rf dmg sm StepMania
echo "DATESTAMP=$datestamp" >> $GITHUB_ENV

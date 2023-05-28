function _msg {
	[CmdletBinding()]
	param(
		[Parameter()]
		[string]$Message
	)

	Write-Host ">> " -ForegroundColor Green -NoNewline; Write-Host "$Message"
}

_msg "Entering stepmania"
git clone --depth=1 https://github.com/stepmania/stepmania.git
cd stepmania/Build
_msg "Configuring stepmania"
cmake -DCMAKE_BUILD_TYPE=Release -G "Visual Studio 17 2022" -A x64 ..
_msg "Building stepmania"
msbuild StepMania.sln /p:Platform="x64" /p:Configuration="Release"
cd ..
_msg "Using SM5-Build derivatives"
git clone --depth=1 -b v1.2.5 https://github.com/stepmania/stepmania.git stepmania-legacy
Remove-Item src/archutils/Win32/StepMania.ico
Copy-Item stepmania-legacy/src/archutils/Win32/StepMania.ico src/archutils/Win32
Remove-Item Data/splash.png
Copy-Item stepmania-legacy/Data/splash.png Data
Remove-Item -Recurse -Force Themes/default
# Remove-Item -Recurse -Force Themes/home
Remove-Item -Recurse -Force Themes/legacy
Copy-Item -Recurse -Force -Path stepmania-legacy/Themes/default -Destination Themes
#git clone --depth=1 https://github.com/Simply-Love/Simply-Love-SM5 "Themes/Simply Love"
#git clone --depth=1 https://github.com/JoseVarelaP/SM5-GrooveNights "Themes/ITG GrooveNights"
#git clone --depth=1 https://github.com/MidflightDigital/XX--STARLiGHT--twopointzero "Themes/DDR XX -STARLiGHT- 2.0"
#Remove-Item -Recurse -Force Themes/*/.git
Remove-Item -Recurse -Force stepmania-legacy
_msg "Copying StepMania files"
mkdir -p Dist/StepMania
Copy-Item -Recurse -Force -Path Announcers -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path BackgroundEffects -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path BackgroundTransitions -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path BGAnimations -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path Characters -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path Courses -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path Data -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path Docs -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path Manual -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path NoteSkins -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path Program -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path Scripts -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path Songs -Destination Dist/StepMania
Copy-Item -Recurse -Force -Path Themes -Destination Dist/StepMania
$datestamp = (Get-Date).ToString("yyyyMMdd")
$datestamp | Out-File -FilePath Dist/StepMania/datestamp
"" | Out-File -FilePath Dist/StepMania/portable.ini
_msg "Create archive as a SM5-Build"
7z a ../SM5-Build-win64-$datestamp.zip Dist/StepMania
echo "DATESTAMP=$datestamp" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append

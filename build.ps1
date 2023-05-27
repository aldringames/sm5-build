function _msg {
	[CmdletBinding()]
	param(
		[Parameter()]
		[string]$Message
	)

	Write-Host ">> " -ForegroundColor Green -NoNewline; Write-Host "$Message"
}

_msg "Entering stepmania"
git clone https://github.com/stepmania/stepmania.git
cd stepmania/Build
_msg "Configuring stepmania"
cmake -DCMAKE_BUILD_TYPE=Release -G "Visual Studio 17 2022" -A x64 ..
_msg "Building stepmania"
msbuild StepMania.sln /p:Platform="x64" /p:Configuration="Release"
cd ..
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
7z a SM5-Build-win64-$datestamp.zip Dist/StepMania
ls
ls Dist/StepMania

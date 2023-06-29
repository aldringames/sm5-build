function _msg {
	[CmdletBinding()]
	param(
		[Parameter()]
		[string]$Message
	)

	Write-Host ">> " -ForegroundColor Green -NoNewline; Write-Host "$Message"
}

_msg "Entering sm"
git clone --depth=1 https://github.com/stepmania/stepmania.git sm
cd sm/Build
_msg "Configuring sm"
cmake -DCMAKE_BUILD_TYPE=Release -G "Visual Studio 17 2022" -A x64 ..
_msg "Building sm"
msbuild StepMania.sln /p:Platform="x64" /p:Configuration="Release"
cd ..
_msg "Using SM5-Build derivatives"
Remove-Item -Recurse -Force Themes/default
Remove-Item -Recurse -Force Themes/home
Remove-Item -Recurse -Force Themes/legacy
git clone --depth=1 https://github.com/Simply-Love/Simply-Love-SM5.git "Themes/Simply Love"
Remove-Item -Recurse -Force Themes/*/.git
Remove-Item -Recurse -Force "Songs/StepMania 5"
_msg "Copying StepMania files"
mkdir -p StepMania
Copy-Item -Recurse -Force -Path Announcers -Destination StepMania
Copy-Item -Recurse -Force -Path BackgroundEffects -Destination StepMania
Copy-Item -Recurse -Force -Path BackgroundTransitions -Destination StepMania
Copy-Item -Recurse -Force -Path BGAnimations -Destination StepMania
Copy-Item -Recurse -Force -Path Characters -Destination StepMania
Copy-Item -Recurse -Force -Path Courses -Destination StepMania
Copy-Item -Recurse -Force -Path Data -Destination StepMania
Copy-Item -Recurse -Force -Path Docs -Destination StepMania
Copy-Item -Recurse -Force -Path Manual -Destination StepMania
Copy-Item -Recurse -Force -Path NoteSkins -Destination StepMania
Copy-Item -Recurse -Force -Path Program -Destination StepMania
Copy-Item -Recurse -Force -Path Scripts -Destination StepMania
Copy-Item -Recurse -Force -Path Songs -Destination StepMania
Copy-Item -Recurse -Force -Path Themes -Destination StepMania
Move-Item -Path StepMania -Destination ../
cd ..
"" | Out-File -FilePath StepMania/portable.ini
_msg "Create archive as a SM5-Build"
$datestamp = (Get-Date).ToString("yyyyMMdd")
7z a SM5-Build-$datestamp-win64.zip StepMania
echo "DATESTAMP=$datestamp" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
Remove-Item -Recurse -Force sm
Remove-Item -Recurse -Force StepMania

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
cmake -DCMAKE_BUILD_TYPE=Release -G "Visual Studio 17 2022" -A x64 ..
ls
msbuild StepMania.sln /p:Platform="x64" /p:Configuration="Release"
ls ..
cd ..

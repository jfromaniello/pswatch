Multipurpose powershell file and folder watcher.

This powershell cmdlet continuously monitors a directory tree and write to the output the path of the file that has changed.

This allows you to create an script that for instance, run a suite of unit tests when an specific file has changed using powershell pipelining.

Usage
=====

	Import-Module pswatch
	watch "Myfolder\Other" | {
		Write-Host "$_.Path has changed!"
		RunUnitTests.exe $_.Path
	}

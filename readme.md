This powershell cmdlet continuously monitors a directory tree and write to the output the path of the file that has changed.

This allows you to create an script that for instance, run a suite of unit tests when an specific file has changed using powershell pipelining.

Installation
============

Download the psm1 file in My documents\WindowsPowershell\Modules\pswatch or simply run this one line installation script:

	iex ((new-object net.webclient).DownloadString("http://bit.ly/Install-PsWatch"))

Usage
=====

A simple example will be:

	Import-Module pswatch

	watch "Myfolder\Other" | %{
		Write-Host "$_.Path has changed!"
		RunUnitTests.exe $_.Path
	}

You can filter by using powershell pipelining as follows:

	watch | Get-Item | Where-Object { $_.Extension -eq ".js" } | %{
		do the magic...
	}

Options
=======

The wacth cmdlet has the following parameters:

  * location: the directory to watch. Optional, default to current directory.
  * includeSubdirectories: default to true.
  * includeChanged: default to true.
  * includeRenamed: default to true.
  * includeCreated: default to true.
  * includeDeleted: default to false.
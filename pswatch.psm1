<#
.Synopsis
    Continuously monitors a directory tree and write to the output the path of the file that has changed.
.Description 
    This powershell cmdlet continuously monitors a directory tree and write to the output the path of the file that has changed.
	This allows you to create an script that for instance, run a suite of unit tests when an specific file has changed using powershell pipelining.
	
.Parameter $location
    The directory to watch. Optional, default to current directory.
.Parameter $includeSubdirectories
.Parameter $includeChanged
.Parameter $includeRenamed
.Parameter $includeCreated
.Parameter $includeDeleted

.Link
    https://github.com/jfromaniello/pswatch/
.Example
    Import-Module pswatch

	watch "Myfolder\Other" | %{
		Write-Host "$_.Path has changed!"
		RunUnitTests.exe $_.Path
	}

    Description
    -----------
    A simple example.
	
.Example
	watch | Get-Item | Where-Object { $_.Extension -eq ".js" } | %{
		do the magic...
	}

	Description
	-----------
	You can filter by using powershell pipelining.
	
#>
function watch{
	param ([string]$location = "",
		   [switch]$includeSubdirectories = $true,
		   [switch]$includeChanged = $true,
		   [switch]$includeRenamed = $true,
		   [switch]$includeCreated = $true,
		   [switch]$includeDeleted = $false)
		   
	if($location -eq ""){
		$location = get-location
	}
	
	$watcher = New-Object System.IO.FileSystemWatcher
	$watcher.Path = $location
	$watcher.IncludeSubdirectories = $includeSubdirectories
	$watcher.EnableRaisingEvents = $false
	$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite -bor [System.IO.NotifyFilters]::FileName
	
	$conditions = 0
	if($includeChanged){
		$conditions = [System.IO.WatcherChangeTypes]::Changed 
	}

	if($includeRenamed){
		$conditions = $conditions -bOr [System.IO.WatcherChangeTypes]::Renamed
	}

	if($includeCreated){
		$conditions = $conditions -bOr [System.IO.WatcherChangeTypes]::Created 
	}

	if($includeDeleted){
		$conditions = $conditions -bOr [System.IO.WatcherChangeTypes]::Deleted
	}
	
	while($TRUE){
		$result = $watcher.WaitForChanged($conditions, 1000);
		if($result.TimedOut){
			continue;
		}
		$filepath = [System.IO.Path]::Combine($location, $result.Name)
		New-Object Object |
          Add-Member NoteProperty Path $filepath -passThru | 
          Add-Member NoteProperty Operation $result.ChangeType.ToString() -passThru | 
          write-output
	}
}
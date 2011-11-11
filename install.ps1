$modulespath = ($env:psmodulepath -split ";")[0]
$pswatchpath = "$modulespath\pswatch"

Write-Host "Creating module directory"
New-Item -Type Container -Force -path $pswatchpath | out-null

Write-Host "Downloading and installing"
(new-object net.webclient).DownloadString("https://raw.github.com/jfromaniello/pswatch/master/pswatch.psm1") | Out-File "$pswatchpath\pswatch.psm1" 

Write-Host "Installed!"
Write-Host 'Use "Import-Module pswatch" and then "watch"'

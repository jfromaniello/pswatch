$modulespath = ($env:psmodulepath -split ";")[0]
$pswatchpath = "$modulespath\pswatch"
New-Item -Type Container -Force -path $pswatchpath

(new-object net.webclient).DownloadString("https://raw.github.com/jfromaniello/pswatch/master/pswatch.psm1") | Out-File "$pswatchpath\pswatch.psm1" 
$modulespath = ($env:psmodulepath -split ";")[0]
$pswatchpath = "$modulespath\pswatch\"
New-Item -Type Container -Force -path $pswatchpath
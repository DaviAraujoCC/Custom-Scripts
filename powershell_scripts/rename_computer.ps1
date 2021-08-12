$sector = 'Sector'
$computer = $env:COMPUTERNAME

echo $computer | ForEach-Object {
    $code = $_.split("-")[1]
    $name = $_.split("-")[0]
}

if ($nome -like "DESKTOP") {

    $newname="$($sector)-$($code)"

    Rename-Computer -NewName $newname
    
}
if ($nome -like "LAPTOP") {

    $novonome="$($sector)-$($code)"

    Rename-Computer -NewName $newname
    
}
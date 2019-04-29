$oldPath = $Env:path;
$paths = $oldPath.split(';');

$phpFolderPath = "C:\wamp\bin\php\";
$actualVersion = "";

$paths | ForEach-Object {
    if ($_.StartsWith($phpFolderPath)) {
        $actualVersion = $_;
    }
}

Write-Host "Actual version: $($actualVersion.Replace($phpFolderPath, ''))";

$phpVersions = Get-ChildItem -Path $phpFolderPath -Name -Directory;
foreach ($phpVersion in $phpVersions) {
    Write-Host "$($phpVersions.IndexOf($phpVersion)). $($phpVersion)";
}

$newVersion = Read-Host -Prompt "Choose a PHP-CLI version [0-$($phpVersions.Length - 1)]";
$Env:path = $oldPath.Replace($actualVersion, $phpFolderPath + $phpVersions[$newVersion]);
Write-Host "PHP-CLI version changed successfully";
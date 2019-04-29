#Requires -RunAsAdministrator

$oldPath = (Get-ItemProperty -Path ‘Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment’ -Name PATH).path;
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
$newPath = $oldPath.Replace($actualVersion, $phpFolderPath + $phpVersions[$newVersion]);
Set-ItemProperty -Path ‘Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment’ -Name PATH -Value $newPath

Write-Host "PHP-CLI version changed successfully";
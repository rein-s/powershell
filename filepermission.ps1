# Pad naar de hoofdfolder waar je de scripts wilt bekijken
$folderPath = "C:\temp\ps\"

# Functie om de toegangsrechten voor een bestand weer te geven
function Get-FilePermissions {
    param (
        [string]$FilePath
    )
    $acl = Get-Acl -Path $FilePath
    $accessRules = $acl.Access | Select-Object IdentityReference, FileSystemRights
    return $accessRules
}

# Functie om recursief door mappen te lopen en scripts te verwerken
function Get-ScriptPermissions {
    param (
        [string]$FolderPath
    )

    $scriptFiles = Get-ChildItem -Path $FolderPath -Filter "*.ps1" -File -Recurse

    foreach ($file in $scriptFiles) {
        Write-Output ("Script: {0}" -f $file.FullName)
        Get-FilePermissions $file.FullName
        Write-Output ("-" * 60)
    }
}

# Voer de functie uit voor de opgegeven hoofdfolder
Get-ScriptPermissions $folderPath

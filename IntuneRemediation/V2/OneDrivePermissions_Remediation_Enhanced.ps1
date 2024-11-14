#==================
#CHANGE ONEDRIVEFOLDERNAME TO THE "ONEDRIVE FOLDER" NAME
#==================

$onedriveFolderName = "ONEDRIVEFOLDERNAME"

$excludedUsers = @('Public', 'ADMINISTRATOR', 'Default', 'defaultuser0')

$users = Get-ChildItem -Path "C:\Users\" | Where-Object { $_.Name -notin $excludedUsers }

foreach ($user in $users) {
    $folderPath = Join-Path $user.FullName $onedriveFolderName

    if (Test-Path $folderPath) {
        $acl = Get-Acl $folderPath
        if ($acl.Access.IdentityReference.Value -contains 'BUILTIN\ADMINISTRATORS') {
            # Remove inheritance and remove BUILTIN\ADMINISTRATORS from ACL
            icacls $folderPath /inheritance:d | Out-Null #>>C:\log
            icacls $folderPath /remove BUILTIN\ADMINISTRATORS | Out-Null
        }
    }
}
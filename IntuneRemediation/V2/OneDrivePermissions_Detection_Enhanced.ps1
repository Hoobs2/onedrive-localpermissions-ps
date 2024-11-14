#==================
#CHANGE **ONEDRIVEFOLDERNAME** TO THE ONEDRIVE - FOLDER NAME
#==================

$onedriveFolderName = "**ONEDRIVEFOLDERNAME**"

$excludedUsers = @('Public', 'ADMINISTRATOR', 'Default', 'defaultuser0')

$users = Get-ChildItem -Path "C:\Users\" | Where-Object { $_.Name -notin $excludedUsers }

foreach ($user in $users) {
    $folderPath = Join-Path $user.FullName $onedriveFolderName

    if (Test-Path $folderPath) {
        $acl = Get-Acl $folderPath
        if ($acl.Access.IdentityReference.Value -contains 'BUILTIN\ADMINISTRATORS') {
            Exit 1
        } else {
            Exit 0
        }
    }
}

# If no user has the specified OneDrive folder or no user folders at all, exit with 0
Exit 0
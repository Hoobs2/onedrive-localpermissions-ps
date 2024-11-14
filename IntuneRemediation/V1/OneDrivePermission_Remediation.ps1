#==================
#CHANGE **ONEDRIVEFOLDERNAME** TO THE ONEDRIVE - FOLDER NAME
#==================

$onedriveFolderName = "ONEDRIVEFOLDERNAME"

$users = Get-ChildItem ("C:\Users\") -Exclude 'Public', 'ADMINISTRATOR', 'Default', 'defaultuser0'

if ($null -ne $users) {
    foreach ($user in $users) {
        $folderPath = "$user\$onedriveFolderName"
        if ((!(Test-Path $folderPath)) -or (!((Get-ACL $folderPath).Access.IdentityReference.Value -Contains "BUILTIN\ADMINISTRATORS"))) {
            continue
        }
        else {
           
            icacls $folderPath /inheritance:d | Out-Null
            
            icacls $folderPath /remove BUILTIN\ADMINISTRATORS | Out-Null
        }
    }
}


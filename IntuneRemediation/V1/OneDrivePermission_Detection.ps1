#==================
#CHANGE ONEDRIVEFOLDERNAME TO THE ONEDRIVE - FOLDER NAME
#==================

$onedriveFolderName = "ONEDRIVEFOLDERNAME"

# Get a list of user directories in C:\Users, excluding certain system and admin accounts
$users = Get-ChildItem ("C:\Users\") -Exclude 'Public', 'ADMINISTRATOR', 'Default', 'defaultuser0'

# Check if the $users variable is not null
if ($null -ne $users) {
    # Iterate through each user directory
    foreach ($user in $users) {
        # Construct the path to the OneDrive folder for the current user
        $folderPath = "$user\$onedriveFolderName"

        # Check if the OneDrive folder path exists
        if (!(Test-Path $folderPath)) {
            # If the folder does not exist, continue to the next user
            continue
        }
        else {
            # Check if the Administrators group has permissions on the folder
            if ((Get-ACL $folderPath).Access.IdentityReference.Value -Contains "BUILTIN\ADMINISTRATORS") {
                # If Administrators have permissions, exit with code 1
                Exit 1
            } else{
                # If Administrators do not have permissions, exit with code 0
                Exit 0
            }
        }  
    }
}
else {
    # If $users is null, continue (though this line will never be reached due to the structure of the script)
    continue
}


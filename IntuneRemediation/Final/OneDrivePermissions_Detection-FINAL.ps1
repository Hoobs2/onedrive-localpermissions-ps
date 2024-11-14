#==================
# Script to check if the OneDrive folder for any user has permissions for the Administrators group
# CHANGE ONEDRIVEFOLDERNAME TO THE "ONEDRIVE - FOLDER" NAME
#==================

# Define the OneDrive folder name
$onedriveFolderName = "ONEDRIVEFOLDERNAME"

# Define the list of users to exclude from the check
$excludedUsers = @('Public', 'ADMINISTRATOR', 'Default', 'defaultuser0')

# Get a list of user directories in C:\Users, excluding certain system and admin accounts
$users = Get-ChildItem -Path "C:\Users\" | Where-Object { $_.Name -notin $excludedUsers }

# Iterate through each user directory
foreach ($user in $users) {
    # Construct the path to the OneDrive folder for the current user
    $folderPath = Join-Path $user.FullName $onedriveFolderName

    # Check if the OneDrive folder path exists
    if (Test-Path $folderPath) {
        # Get the Access Control List (ACL) for the folder
        $acl = Get-Acl $folderPath

        # Check if the Administrators group has permissions on the folder
        if ($acl.Access | Where-Object { $_.IdentityReference -eq 'BUILTIN\Administrators' }) {
            # If Administrators have permissions, exit with code 1
            Exit 1
        }
    }
}

# If no user has the specified OneDrive folder or no user folders at all, exit with 0
Exit 0
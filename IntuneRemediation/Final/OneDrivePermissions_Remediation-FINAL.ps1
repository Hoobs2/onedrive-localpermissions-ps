#==================
# Script to remove BUILTIN\Administrators permissions from OneDrive folders for users
# CHANGE ONEDRIVEFOLDERNAME TO THE ONEDRIVE FOLDER NAME
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
            # Remove inheritance and remove BUILTIN\Administrators from ACL
            icacls $folderPath /inheritance:d | Out-Null
            icacls $folderPath /remove 'BUILTIN\Administrators' | Out-Null
        }
    }
}

# Log completion
#Write-Host "Remediation script completed."
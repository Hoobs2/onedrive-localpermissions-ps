# onedrive-permissions-ps

Intune Remediation Script. Detects if the perissions on the OneDrive folder contain the "BUILTIN\ADMINISTRATORS" group, and if true, runs the remediation script(Handled by Intune). The Remediation Script will change the permissions and iharitance of the OneDrive Folder, stopping local admins from having access.

The Detection or Remediation can be changed to suit individual needs and deployment situations, it was originally created to be deployed as an Intune Remediation, necessitating the creation of separate detection and remediation scripts.

====
tldr: Remove local Admin permissions from local OneDrive Folder Structure.
====

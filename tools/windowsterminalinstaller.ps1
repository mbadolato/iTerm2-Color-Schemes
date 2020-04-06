$terminalProfile = "${HOME}\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json"

# Load existing profile
$configData = Get-Content -Path $terminalProfile | ConvertFrom-Json

# Get a list of scheme names to avoid duplicates
$installedNames = $configData.schemes | ForEach-Object { $_.name }

# Get color files into an array of schemes
$toInstall = Get-ChildItem -Path "${PSScriptRoot}\..\windowsterminal"  -Filter '*.json' | ForEach-Object { Get-Content $_ | ConvertFrom-Json }

# Filter out any schemes with conflicting names
if ($null -ne $installedNames) {
  $toInstall = $toInstall | Where-Object { !$installedNames.Contains($_.name) }
}

# Create a new list to store schemes
$newSchemes = New-Object Collections.Generic.List[Object]

# Get currently installed schemes
$configData.schemes | ForEach-Object { $newSchemes.Add($_) }

# Add new schemes to install
$toInstall | ForEach-Object { $newSchemes.Add($_) }

# Assign back to profile object
$configData.schemes = $newSchemes

# Write back to profile
$configData | ConvertTo-Json -Depth 32 | Set-Content -Path $terminalProfile

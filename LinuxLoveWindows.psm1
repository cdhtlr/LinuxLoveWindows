# Module: LinuxLoveWindows
# This module provides functions to import and initialize Linux (WSL) commands for use in Windows PowerShell.
# - Initialize-Linux: Loads Linux commands from a file and imports them into the session.
# - Import-Linux: Extracts available Linux functions from WSL, saves them to a file, and initializes them in PowerShell.

function Initialize-Linux {
    $file = "imported_linux_commands.txt"
    if (Test-Path $file) {
        $commands = Get-Content $file
        if ($commands.Count -gt 0) { Invoke-Expression "Import-WslCommand $(($commands | ForEach-Object { '"{0}"' -f $_ }) -join ', ')" }
    }
}

function Import-Linux {
    param(
        [switch]$all
    )

    $file = "imported_linux_commands.txt"
	$wslDistro = wsl -l | Select-String '\(' | ForEach-Object { ($_ -split '\s{2,}')[0]}
    $toImport = @()

    if ($wslDistro.length -gt 0){
		Write-Host "(1/3) Collecting a list of Linux commands from WSL distro: $wslDistro."
		# Note: You may edit this command if it does not work for your Linux distribution.
		wsl bash -c "compgen -A function -back | sort | uniq | grep -E '^[a-zA-Z0-9_]+$'" | Out-File -Encoding UTF8 $file
		$commands = [System.IO.File]::ReadAllLines($file) | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }

		Write-Host "(2/3) Sorting the list of commands."
		if (($all -or $env:LINUX_CMD -eq "all")) {
			$toImport = $commands
		} else {
			$toImport = $commands | Where-Object { -not (Get-Command $_ -ErrorAction SilentlyContinue) }
		}

		Write-Host "(3/3) Attempting to load the sorted command into the current session."
		if ($toImport.Count -gt 0) {
			$existing = @()
			if (Test-Path $file) { $existing = Get-Content $file }
			if (-not ($toImport -eq $existing)) {
				$toImport | Out-File -Encoding UTF8 $file
				Initialize-Linux
				Write-Host "Linux commands imported successfully."
			} else {
				Write-Host "No new Linux commands to import ($file unchanged)."
			}
		} else {
			Write-Host "No new Linux commands to import."
		}
	} else {
		Write-Host "No default distro found."
	}
}

Initialize-Linux

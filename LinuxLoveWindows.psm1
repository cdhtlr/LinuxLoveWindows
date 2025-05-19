# Module: LinuxLoveWindows
# This module provides functions to import and initialize Linux (WSL) commands for use in Windows PowerShell.
# - Initialize-Linux: Loads Linux commands from a file and imports them into the session.
# - Import-Linux: Extracts available Linux functions from WSL, saves them to a file, and initializes them in PowerShell.

function Initialize-Linux {
    if (Test-Path "imported_linux_commands.txt") {
        Get-Content "imported_linux_commands.txt" | ForEach-Object {
            if ($_ -ne "") { Import-WslCommand $_ }
        }
    }
}

function Import-Linux {
    # Note: You may edit this command if it does not work for your Linux distribution.
    wsl bash -c "compgen -A function -back | sort | uniq | grep -E '^[[:alnum:]]+$' | grep -v '^[A-Z]'" | Out-File -Encoding UTF8 "imported_linux_commands.txt"; echo "Linux commands imported successfully."; Initialize-Linux
}

Initialize-Linux

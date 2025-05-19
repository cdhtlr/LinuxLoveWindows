@{
    # Script module or binary module file associated with this manifest.
    RootModule        = '.\LinuxLoveWindows.psm1'

    # Version number of this module.
    ModuleVersion     = '1.0.0'

    # Supported PSEditions
    CompatiblePSEditions = 'Core'

    # ID used to uniquely identify this module
    GUID              = 'b1e7e2e2-1234-4cde-9abc-123456789abc'

    # Author of this module
    Author            = 'Sidik Hadi Kurniadi'

    # Description of the functionality provided by this module
    Description       = 'PowerShell module to save and load commands from WSL.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '6.0'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules = @('WslInterop')

    # Functions to export from this module
    FunctionsToExport = @('Initialize-Linux','Import-Linux')

    # Cmdlets to export from this module
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module
    AliasesToExport   = @()
}

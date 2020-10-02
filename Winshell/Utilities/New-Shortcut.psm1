<#
    .Synopsis
    Create a new LNK file on Windows.
#>
function New-Shortcut {

    param(
        [Parameter(Mandatory)]
        [string]
        $shortcutFile,

        [Parameter(Mandatory)]
        [string]
        $targetPath,

        [Parameter(Mandatory = $false)]
        [string]
        $description,

        [Parameter(Mandatory = $false)]
        [string]
        $iconLocation,

        [Parameter(Mandatory = $false)]
        [string]
        $workingDirectory
    )

    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutFile)
    $shortcut.TargetPath = $targetPath
    $shortcut.Description = $description
    $shortcut.IconLocation = if ($iconLocation) { $iconLocation } else { $targetPath }
    $shortcut.WorkingDirectory = if ($workingDirectory) { $workingDirectory } else { Split-Path $targetPath }
    $shortcut.Save()

}
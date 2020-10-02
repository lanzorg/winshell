<#
    .Synopsis
    Expand the whole files from the archive on Windows.
#>
function Expand-All {

    param(
        [Parameter(Mandatory)]
        [string]
        $archive,

        [Parameter(Mandatory = $false)]
        [string]
        $destination,

        [Parameter(Mandatory = $false)]
        [SecureString]
        $password
    )

    Import-Module '.\Winshell\Utilities\New-TempDirectory.psm1'

    # Download the latest 7-Zip release.
    $content = (New-Object System.Net.WebClient).DownloadString('https://www.7-zip.org/download.html')
    $pattern = 'Download 7-Zip ([\d.]+)'
    $version = ([Regex]::Matches($content, $pattern).Groups[1].Value).Replace('.', '')
    $address = "https://7-zip.org/a/7z$version-x64.msi"
    $package = [System.IO.Path]::Combine($env:TEMP, [System.IO.Path]::GetFileName($address))
    (New-Object System.Net.WebClient).DownloadFile($address, $package)

    # Extract the content of the MSI package.
    $extractionDir = New-TempDirectory
    Start-Process -FilePath 'msiexec.exe' -ArgumentList "/a $package /qn TARGETDIR=$extractionDir" -NoNewWindow -Wait

    # Create a new destination directory if needed.
    if (-not $destination) { $destination = New-TempDirectory }

    # Expand the whole files from the archive
    $program = [System.IO.Directory]::GetFiles($extractionDir, '7z.exe', [System.IO.SearchOption]::AllDirectories)[0];
    $arguments = if ($password) { "x `"$archive`" -o`"$destination`" -p`"$password`" -y -bso0 -bsp0" } else { "x `"$archive`" -o`"$destination`" -y -bso0 -bsp0" }
    Start-Process -FilePath `"$program`" -ArgumentList $arguments -NoNewWindow -Wait

}
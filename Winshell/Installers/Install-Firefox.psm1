<#
    .Synopsis
    Install the latest Firefox release on Windows.
#>
function Get-Firefox {

    enum Bitness {
        X64
        X86
    }
    
    enum Channel {
        Stable
        Beta
        Developer
        Extended
        Nightly
    }

    param(
        [Bitness] $bitness,
        [Channel] $channel
    )
    
    switch ($bitness) {
        ([Bitness]::X64) {
            $os = 'win64'
        }
        ([Bitness]::X86) {
            $os = 'win'
        }
        default {
            if ([System.Environment]::Is64BitOperatingSystem) { "win64" } else { "win" }
        }
    }

    switch ($channel) {
        ([Channel]::Stable) {
            $product = 'firefox-msi-latest-ssl'
        }
        ([Channel]::Beta) {
            $product = 'firefox-beta-msi-latest-ssl'
        }
        ([Channel]::Developer) {
            $product = 'firefox-devedition-msi-latest-ssl'
        }
        ([Channel]::Extended) {
            $product = 'firefox-esr-msi-latest-ssl'
        }
        ([Channel]::Nightly) {
            $product = 'firefox-nightly-msi-latest-ssl'
        }
        default {
            $product = 'firefox-msi-latest-ssl'
        }
    }
    
    $address = "https://download.mozilla.org/?product=$product&os=$os&lang=en-US"
    $program = [System.IO.Path]::Combine($env:TEMP, 'FirefoxSetup.msi')

    (New-Object System.Net.WebClient).DownloadFile($address, $program)
    Start-Process -FilePath 'msiexec.exe' -ArgumentList "/i `"$program`" /qn DESKTOP_SHORTCUT=false INSTALL_MAINTENANCE_SERVICE=false" -NoNewWindow -Wait

}
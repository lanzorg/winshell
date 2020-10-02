<#
    .Synopsis
    Create new directory and return its full path.
#>
function New-TempDirectory {

    [System.IO.Directory]::CreateDirectory([System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.Guid]::NewGuid().ToString())).FullName

}
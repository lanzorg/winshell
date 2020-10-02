<table>
  <tr>
    <td width="9999px" align="center">
      <p>
        <br>
        <img height="200" src="https://www.flaticon.com/svg/static/icons/svg/427/427242.svg" alt="logo">
      </p>
      <h1>winshell</h1>
      <p>Powershell functions I use occasionally.</p>
    </td>
  </tr>
</table>

## Generate manifest

```powershell
$settings = @{
    Path = 'Winshell.psd1'
    Guid = (New-Guid)
    Description = 'Powershell functions I use occasionally.'
    ModuleVersion = '0.1.0.0'
    PowerShellVersion = '5.1'
    NestedModules = (Get-ChildItem -Path .\Winshell\**\*.psm1 | Resolve-Path -Relative)
    FunctionsToExport = @('*')
}

New-ModuleManifest @settings
```
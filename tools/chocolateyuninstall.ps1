$ErrorActionPreference = 'Stop'; # stop on all errors

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'ChocoWebswing*'  #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  ZipFileName   = 'webswing-2.5.12.zip'
}

$uninstalled = $false

function Uninstall-ChocolateyZipPackageFix {
  param(
    [parameter(Mandatory=$true, Position=0)][string] $packageName,
    [parameter(Mandatory=$true, Position=1)][string] $zipFileName,
    [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
  )

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  $packagelibPath=$env:chocolateyPackageFolder
  $zipContentFile=(join-path $packagelibPath $zipFileName) + "Install.txt"

  # The Zip Content File may have previously existed under a different
  # name.  If *Install.txt doesn't exist, check for the old name
  if(-Not (Test-Path -Path $zipContentFile)) {
    $zipContentFile=(Join-Path $packagelibPath -ChildPath $zipFileName) + ".txt"
  }

  if ((Test-Path -path $zipContentFile)) {
    $zipContentFile
    $zipContents=get-content $zipContentFile
    foreach ($fileInZip in $zipContents) {
      if ($fileInZip -ne $null -and $fileInZip.Trim() -ne '') {
        Remove-Item -Path "$fileInZip" -ErrorAction SilentlyContinue -Recurse -Force
      }
    }
  }

}

Uninstall-ChocolateyZipPackageFix @packageArgs

$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://bitbucket.org/meszarv/webswing/downloads/webswing-2.5.12.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "${env:ProgramFiles(x86)}\Webswing"
  url           = $url
  softwareName  = 'Webswing*'
  checksum      = 'B21BA24C536A330C5551CF1EC52828ADE33ADC70E7058E6D19089304A1F6C17E'
  checksumType  = 'sha256'
  silentArgs   = ''
}

Install-ChocolateyZipPackage @packageArgs

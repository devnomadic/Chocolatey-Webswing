$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://bitbucket.org/meszarv/webswing/downloads/webswing-2.5.10.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "${env:ProgramFiles(x86)}\Webswing"
  url           = $url
  softwareName  = 'Webswing*'
  checksum      = 'F32ABBBE36AFAD2D92879E5812DC55A5515BEFF5920BA620BA98C7268E3C5E4D'
  checksumType  = 'sha256'
  silentArgs   = ''
}

Install-ChocolateyZipPackage @packageArgs

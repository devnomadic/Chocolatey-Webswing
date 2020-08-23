param(
    [Parameter(Mandatory = $false)]
    [string]$PackageName = 'webswing'
)

if (!(choco --version))
{
    Write-Host "Choco not installed - Installing..."
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}


$WorkingFiles = gci -Recurse
$Nupkg = $WorkingFiles | ? {($_.Extension -eq '.nupkg') -and ($_.Name -match "$PackageName")}
Write-Host $Nupkg.FullName

Describe 'Chocolatey Packages Install' {
    It "Install: $PackageName" -TestCases @{Nupkg = $Nupkg; PackageName = $PackageName} {
        $PkgInstall = $null
        $PkgInstall = choco install "$($Nupkg.FullName)" -y
        Write-Host $PkgInstall
        $PkgInstall | ?{$_ -match "The install of $PackageName was successful"} | Should -Not -Be $null
    }
}

Describe 'Chocolatey Package is listed' {
    It "Listed" -TestCases @{PackageName = $PackageName} {
        $PkgList = $null
        $PkgList = choco list --local-only
        $PkgList | ?{$_ -match $PackageName} | Should -Not -Be $null
    }
}

Describe 'Chocolatey Package Contents exist' {
    It "$PackageName" -TestCases @{PackageName = $PackageName} {
        $PkgContents = $null
        $PkgContents = gci -Path "${env:ProgramFiles(x86)}\$PackageName" -Recurse
        $PkgContents | Should -Not -Be $null
    }
}

Describe 'Chocolatey Package Uninstall' {
    It "Uninstall: $PackageName" -TestCases @{PackageName = $PackageName} {
        $PkgUninstall = $null
        $PkgUninstall = choco uninstall $PackageName -y
        $PkgUninstall | ?{$_ -match "$PackageName has been successfully uninstalled"} | Should -Not -Be $null
    }
}
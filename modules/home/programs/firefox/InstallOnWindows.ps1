[CmdletBinding()]
param (
    [Parameter()]
    [switch]
    $NoCopy
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$utf8 = New-Object System.Text.Utf8Encoding @($true, $true)

$script:ParrotCount = 0;
$script:ParrotSteps = 5;

function Get-ParrotCount
{
  $script:ParrotCount += 1;
  if (0 -eq ($script:ParrotCount % $script:ParrotSteps))
  {
    [int]$i = $script:ParrotCount / $script:ParrotSteps
    Get-Parrot "auto-count $i"
  }
}

function Get-Parrot($value)
{
  "user_pref(""_user.js.parrot"", ""$value"");"
}

function Get-LinesWithParrots([string[]]$lines)
{
  foreach ($line in $lines)
  {
    Get-ParrotCount
    $line
  }
}

function Get-Text([io.FileInfo]$info)
{
  Get-Parrot "START $($info.Name)"
  "/* $($info.FullName) */"
  $lines =  Get-LinesWithParrots ([Io.File]::ReadAllLines($info.FullName))
  ($lines -join ([System.Environment]::NewLine)).Trim()
  Get-Parrot "END $($info.Name)"
  ""
}

$root = Resolve-Path $PSScriptRoot
$mergedFile = "$root/_merged.js"
$lines = @()
foreach ($name in @(".export/user.js"))
{
  $lines += Get-Text "$root/$name"
}

$lines += Get-Parrot "all done 👍"

$text = ($lines -join ([System.Environment]::NewLine)).Trim()
[Io.File]::WriteAllText($mergedFile, $text, $utf8)

$script:PossibleBrowsers = @(
  "${ENV:AppData}\Mozilla\Firefox\Profiles",
  "${ENV:AppData}\librewolf\Profiles",
  "${ENV:AppData}\.librewolf\Profiles",
)

function Get-ProfileFolders
{
  for ($browser in $script:PossibleBrowsers)
  {
    if (Test-Path $browser)
    {
      $profiles_root = Resolve-Path $browser
      Get-ChildItem -Path $profiles_root -Directory
    }
  }
}

foreach ($profile in Get-ProfileFolders)
{
  $target = Join-Path $profile.FullName "user.js"
  $target
  if (!$NoCopy)
  {
    Copy-Item -Path $mergedFile -Destination $target
  }
}
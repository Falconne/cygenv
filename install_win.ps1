# Default config
$site = "ftp://ucmirror.canterbury.ac.nz/pub/cygwin/"
$cygdir = "c:\cygwin"

# Elevate script if needed
# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the Administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

# Check to see if we are currently running "as Administrator"
if (!$myWindowsPrincipal.IsInRole($adminRole))
{
   # Relaunch as administrator

   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";

   # Specify the current script path and name as a parameter
   $newProcess.Arguments = "-ExecutionPolicy Unrestricted " + $script:MyInvocation.MyCommand.Path

   Write-Host $newProcess.Arguments

   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";

   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess);

   # Exit from the current, unelevated, process
   exit
}

# Start actual script

function finish($code)
{
    Write-Host "Press any key to finish..."
    $HOST.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | OUT-NULL
    $HOST.UI.RawUI.Flushinputbuffer()
    exit $code
}

function writeHeading($msg)
{
    Write-Host $msg -ForegroundColor Yellow
}

function writeProgress($msg)
{
    Write-Host $msg -ForegroundColor DarkYellow
}

$scriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
# Cygwin home directory
$username = $Env:USERNAME
$cyghome = Join-Path $cygdir "home\$username"

function makeLocalHardLink($file)
{
    $localFile = Join-Path $cyghome $file
    $localFileBak = $localFile + ".cebak"
    if (Test-Path $localFile)
    {
        if (Test-Path $localFileBak)
        {
            writeProgress "$file backup exists, skipping"
            return
        }

        $fileContent = @(Get-Content $localFile)
        if ($fileContent)
        {
            $topLine = $fileContent[0]
            if ($topLine -like "*cygenv*")
            {
                writeProgress "$file aready linked"
                return
            }
        }

        Move-Item $localFile $localFileBak
    }

    $cygenvFile = Join-Path $scriptDir $file
    cmd.exe /c mklink /h $localFile $cygenvFile
}

$setupDir = Join-Path $cygdir "setup"
$setupProg = Join-Path $setupDir "setup-x86.exe"

$upgrading = Test-Path $cygdir

if ($upgrading)
{
    writeHeading "Upgrade started"
}
else
{
    writeHeading "Fresh install started"
}

if (!(Test-Path $setupDir)) { md $setupDir }
writeProgress "Fetching latest Cygwin installer"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile("http://cygwin.com/setup-x86.exe", $setupProg)

pushd .
chdir $setupDir
$args = "-q -R $cygdir -n -g -o -s $site "
$args += "--packages openssh,bash,mintty,curl"
Start-Process -NoNewWindow -Wait $setupProg $args
popd

writeHeading "Creating shortcuts"
$wshShell = New-Object -comObject WScript.Shell
$lnkArgs = "--hold never -i /Cygwin-Terminal.ico -"

$desktop =  $wshShell.SpecialFolders.Item("AllUsersDesktop")
if (!(Test-Path $desktop)) { $desktop = "$Home\Desktop" }
$lnkFile = Join-Path $desktop "Cygwin Terminal.lnk"
if (Test-Path $lnkFile)
{
    writeProgress "Desktop shortcut exists"
    $shortcut = $wshShell.CreateShortcut($lnkFile)
    if ($shortcut.Arguments -ne $lnkArgs)
    {
        writeProgress "Arguments need updating"
        $shortcut.Arguments = $lnkArgs
        $shortcut.Save()
    }
}
else
{
    $shortcut = $wshShell.CreateShortcut($lnkFile)
    $shortcut.TargetPath = Join-Path $cygdir "bin\mintty.exe"
    $shortcut.Arguments = $lnkArgs
    $shortcut.Save()
}

$startMenu =  $wshShell.SpecialFolders.Item("AllUsersStartMenu")
if (!(Test-Path $startMenu)) { $startMenu = "$Home\Start Menu" }
$startMenuDir = Join-Path $startMenu "Programs\Cygwin"
$startMenuLnk = Join-Path $startMenuDir "Cygwin Terminal.lnk"
if (Test-Path $startMenuLnk)
{
    writeProgress "Start Menu shortcut exists"
    $shortcut = $wshShell.CreateShortcut($startMenuLnk)
    if ($shortcut.Arguments -ne $lnkArgs)
    {
        writeProgress "Arguments need updating"
        $shortcut.Arguments = $lnkArgs
        $shortcut.Save()
    }
}
else
{
    Copy-Item $lnkFile $startMenuLnk
}

if (!(Test-Path $cyghome))
{
    $Host.UI.WriteErrorLine("Cygwin home not found in $cyghome. Refer to 'Manual Configuration' instructions in Readme.")
    finish 1
}

writeProgress "Synchronising config files"
makeLocalHardLink ".bashrc"

$localCEDir = Join-Path $cyghome "cygenv-files"
if (!(Test-Path $localCEDir))
{
    $repoCEDir = Join-Path $scriptDir "cygenv-files"
    cmd.exe /c mklink /d $localCEDir $repoCEDir
}

$minttyrc = Join-Path $cyghome ".minttyrc"
if (!(Test-Path $minttyrc))
{
    $minttyrcRepo = Join-Path $scriptDir ".minttyrc"
    writeProgress "Copying default mintty config"
    Copy-Item $minttyrcRepo $minttyrc
}

my $localGitConfig = Join-Path $cyghome ".gitconfig"
if (!(Test-Path $localGitConfig))
{
    $homedirs = @()
    $profileGitConfig = Join-Path $Env:USERPROFILE ".gitconfig"
}

writeHeading("All done.")
finish 0

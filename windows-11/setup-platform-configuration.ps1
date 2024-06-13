$username = $env:UserName
$appdata = $env:AppData

function Run-With-Admin-Privileges {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        # Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`"  `"$($MyInvocation.MyCommand.UnboundArguments)`""
        $currentScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
        Start-Process -FilePath PowerShell.exe -ArgumentList "-File", "$PSCommandPath" -Verb RunAs -WorkingDirectory $currentScriptDirectory
        Exit
    }
}
function Create-SymbolLink-To-Config-Files {
    param (
        [string]$sourceConfigPath,
        [string]$destinationConfigPath,
        [string]$verboseMessage
    )
    Write-Host "$verboseMessage"
    if (-not (Test-Path $sourceConfigPath)) 
    {
        Write-Error "The source path '$sourceConfigPath' does not exist."
    } 
    $absoluteSourceConfigPath = Resolve-Path -Path $sourceConfigPath
    New-Item -ItemType SymbolicLink -Path $destinationConfigPath -Target $absoluteSourceConfigPath -Force
    Write-Host "$verboseMessage... DONE"
}

function Create-HardLink-To-Config-Files {
    param (
        [string]$sourceConfigPath,
        [string]$destinationConfigPath,
        [string]$verboseMessage
    )
    Write-Host "$verboseMessage"
    if (-not (Test-Path $sourceConfigPath)) 
    {
        Write-Error "The source path '$sourceConfigPath' does not exist."
    } 
    $absoluteSourceConfigPath = Resolve-Path -Path $sourceConfigPath
    New-Item -ItemType HardLink -Path $destinationConfigPath -Target $absoluteSourceConfigPath -Force
    Write-Host "$verboseMessage... DONE"
}

Create-SymbolLink-To-Config-Files -sourceConfigPath ".\vs-2022-vim-settings" `
                                -destinationConfigPath "C:\Users\$username\.vsvimrc" `
                                -verboseMessage "Setting up VsVim for Visual Studio"
Create-SymbolLink-To-Config-Files -sourceConfigPath ".\vs-2022-settings.vssettings" `
                                -destinationConfigPath "C:\Users\$username\AppData\Local\Microsoft\VisualStudio\17.0_8cb8c352\Settings\CurrentSettings.vssettings" `
                                -verboseMessage "Setting up settings for Visual Studio 2022"
Create-HardLink-To-Config-Files -sourceConfigPath ".\xyplorer-settings.ini" `
                                -destinationConfigPath "$appdata\XYplorer\XYplorer.ini" `
                                -verboseMessage "Setting up XYplorer configuration"
Create-SymbolLink-To-Config-Files -sourceConfigPath ".\vs-code-settings.json" `
                                -destinationConfigPath "$appdata\Code\User\settings.json" `
                                -verboseMessage "Setting up VS Code configuration"
Create-HardLink-To-Config-Files -sourceConfigPath ".\autohotkey-settings.ahk" `
                                -destinationConfigPath "C:\Users\$username\autohotkey-settings.ahk" `
                                -verboseMessage "Setting up AutoHotKey configuration"
Create-SymbolLink-To-Config-Files -sourceConfigPath ".\power-toys-keyboard-mappings.json" `
                                -destinationConfigPath "$appdata\..\Local\Microsoft\PowerToys\Keyboard Manager\default.json" `
                                -verboseMessage "Setting up Power Toys Keyboard configuration"



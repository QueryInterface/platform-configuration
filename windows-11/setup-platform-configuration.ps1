$username = $env:UserName
$appdata = $env:AppData

function Create-Hardlink-To-Config-Files {
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
    New-Item -ItemType HardLink -Path $destinationConfigPath -Target $sourceConfigPath -Force
    Write-Host "$verboseMessage... DONE"
}

Create-Hardlink-To-Config-Files -sourceConfigPath ".\.vsvimrc" `
                                -destinationConfigPath "C:\Users\$username\.vsvimrc" `
                                -verboseMessage "Setting up VsVim for Visual Studio"
Create-Hardlink-To-Config-Files -sourceConfigPath "XYplorer.ini" `
                                -destinationConfigPath "$appdata\XYplorer\XYplorer.ini" `
                                -verboseMessage "Setting up XYplorer configuration"
Create-Hardlink-To-Config-Files -sourceConfigPath "settings.json" `
                                -destinationConfigPath "$appdata\Code\User\settings.json" `
                                -verboseMessage "Setting up VS Code configuration"


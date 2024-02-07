$proxy = Read-Host "Do you want to use the corporate proxy for Git? (y/n)"
if ($proxy -eq "y") {
    git config --global http.https://github.com.proxy http://proxy-ir.intel.com:912
    git config --global http.https://lfs.github.com.proxy http://proxy-ir.intel.com:912
    Write-Host "Corporate proxy has been set for Git."
} elseif ($proxy -eq "n") {
    git config --global --unset http.https://github.com.proxy
    git config --global --unset http.https://lfs.github.com.proxy
    Write-Host "Corporate proxy has been unset for Git."
} else {
    Write-Host "Invalid input. Please enter 'y' or 'n'."
}
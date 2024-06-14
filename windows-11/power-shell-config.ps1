Set-Alias -Name ll -Value dir
Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

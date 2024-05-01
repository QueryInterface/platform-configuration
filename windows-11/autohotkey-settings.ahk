; ==================================================
; Shortcuts for specific applications
RunOrBringToFront(path, process_name)
{
	if WinExist("ahk_exe " process_name)
    {
		WinActivate("ahk_exe " process_name)
    }
	else
    {
		full_path := path process_name
		Run(full_path)
    }
	WinWait("ahk_exe " process_name)
	WinActivate("ahk_exe " process_name)
	WinWaitActive("ahk_exe " process_name)
}

!1::RunOrBringToFront("C:\Program Files (x86)\XYplorer\", "xyplorer.exe")
!2::RunOrBringToFront("C:\Program Files (x86)\Microsoft\Edge\Application\", "msedge.exe")
!3::RunOrBringToFront("C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\", "devenv.exe")
!4::RunOrBringToFront("C:\Users\svolkov\AppData\Local\Programs\Microsoft VS Code\", "Code.exe")
!5::RunOrBringToFront("C:\Users\svolkov\AppData\Local\Obsidian\", "Obsidian.exe")
!t::RunOrBringToFront("C:\Program Files\PowerShell\7\", "pwsh.exe")

; ==================================================
; Shortcut for opening file in VS Code
OpenCurrentSelectionInProgram(program_path) 
{
    selection := _GetCurrentSelection()
    full_path := program_path ' ' selection
    Run(full_path)
    return

    _GetCurrentSelection() 
    {
        Send("^c")
        ClipWait(0.1)
        folder_path := A_Clipboard
        return folder_path
    }
}

!.::OpenCurrentSelectionInProgram("C:\Users\svolkov\AppData\Local\Programs\Microsoft VS Code\Code.exe")
!w::Send("^{Backspace}")

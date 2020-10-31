#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; CursorColorPicker
; Author: Nico Covert
; Version: 1.2

if A_IsCompiled
	Menu, Tray, Icon, %A_ScriptFullPath%, -159

Menu, Tray, Tip, CursorColorPicker

#+c::
BreakLoop=0;
Hotkey, LButton, copyColor, On
Loop,
{
	if (BreakLoop=1)
		break
	MouseGetPos, mouseX, mouseY
	PixelGetColor, color, %mouseX%, %mouseY%, Slow RGB
	colorHex := StrReplace(color, "0x", "#")
	ToolTip, %colorHex%
}
ToolTip
HotKey, LButton, Off
return

copyColor:
Clipboard:=colorHex
Menu, Tray, Tip, Last color: %colorHex%
BreakLoop=1
return
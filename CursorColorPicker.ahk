#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; CursorColorPicker
; Author: Nico Covert - nicovert
; Version: 1.5

if A_IsCompiled
	Menu, Tray, Icon, %A_ScriptFullPath%, -159

Menu, Tray, Tip, CursorColorPicker

global HotkeyString = "#+c"
global BreakLoop=0
global colorHex=""

; Check for ini
if (FileExist("options.ini") != "") { ;Found ini
	IniRead, HotkeyString, options.ini, SavedHotkey, hotkeystring
}
else { ;No ini, create
	IniWrite, %HotkeyString%, options.ini, SavedHotkey, hotkeystring
}

Hotkey, %HotkeyString%, KeyPressed
Menu, Tray, Tip, CursorColorPicker - %HotkeyString%

KeyPressed() {
	BreakLoop=0
	Hotkey, LButton, copyColor, On
	Hotkey, Escape, cancelCopy, On
	Loop, {
		if (BreakLoop=1)
			break
		MouseGetPos, mouseX, mouseY
		PixelGetColor, color, %mouseX%, %mouseY%, Slow RGB
		colorHex := StrReplace(color, "0x", "#")
		ToolTip, %colorHex%
	}
	ToolTip
	HotKey, LButton, Off
	HotKey, Escape, Off
	return
}

copyColor() {
	Clipboard:=colorHex
	Menu, Tray, Tip, Last color: %colorHex%
	BreakLoop=1
	return
}

cancelCopy() {
	BreakLoop=1
	return
}

; Options GUI
; GUI, OptionsGUI:New, MinSize250x150, Options - CursorColorPicker
; GUI, OptionsGUI:Add, Text,, Enter a hotkey:
; GUI, OptionsGUI:Add, Edit, Limit10 R1 W80 vInputHotkey
; GUI, OptionsGUI:Add, Button, w80 gSetHotkey, Save
; GUI, OptionsGUI:Add, Text, x+10 y10, Ctrl = ^`nShift = +`nAlt = !`nWin = #
; GUI, OptionsGUI:Show, w160 h80 Center
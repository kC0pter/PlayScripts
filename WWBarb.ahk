;========================================================================
;
; ParagonSpender v1.0.1
;
; spends Paragon with 3 possible Paragon Setups
;
; Created by DaLeberkasPepi
;   https://github.com/DaLeberkasPepi
;
; Last Update: 2018-03-04 12:00 GMT+1
;
;========================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#IfWinActive, ahk_class D3 Main Window Class
#SingleInstance force
SetDefaultMouseSpeed, 5
CoordMode, Pixel, Client
CoordMode, Mouse, Client

OnExit("ExitFunc")

global D3ScreenResolution
,NativeDiabloHeight := 1440
,NativeDiabloWidth := 3440
,#ctrls := 3
,Ping
,HotKeyCombo1
,HotKeyCombo2
,HotKeyCombo3

IfNotExist, Hotkeys.ini
	FileAppend,
(
[Settings]
Ping=100
[Hotkeys]
1=Numpad7
2=Numpad8
3=Numpad9
), Hotkeys.ini

IniRead, Ping, Hotkeys.ini, Settings, Ping
Loop % #ctrls 
{
	GUI, Add, Text, xm y+10, Hotkey for #%A_Index% HotKeyCombo Setup:
	
	IniRead, savedHK%A_Index%, Hotkeys.ini, Hotkeys, %A_Index%, %A_Space%	;Check for saved hotkeys in INI file.
	
	;IniRead, ParagonMain%A_Index%, Hotkeys.ini, Settings, ParagonMain%A_Index%, %A_Space%
	;IniRead, ParagonVitality%A_Index%, Hotkeys.ini, Settings, ParagonVitality%A_Index%, %A_Space%
	;IniRead, ParagonMovement%A_Index%, Hotkeys.ini, Settings, ParagonMovement%A_Index%, %A_Space%
	;IniRead, ParagonRessource%A_Index%, Hotkeys.ini, Settings, ParagonRessource%A_Index%, %A_Space%
	
	If savedHK%A_Index%                                      				;Activate saved hotkeys if found.
		Hotkey,% savedHK%A_Index%, Label%A_Index%                			;Remove tilde (~) and Win (#) modifiers...
	
	StringReplace, noMods, savedHK%A_Index%, ~                 				;They are incompatible with hotkey controls (cannot be shown).
	StringReplace, noMods, noMods, #,,UseErrorLevel           	   			;Add hotkey controls and show saved hotkeys.
	GUI, Add, Hotkey, x+5 vHK%A_Index% gGuiLabel, %noMods%        			;Add checkboxes to allow the Windows key (#) as a modifier...
	GUI, Add, CheckBox, x+5 vCB%A_Index% Checked%ErrorLevel%, Win	|		;Check the box if Win modifier is used.
	
	;GUI, Add, Text, x+5, Main:
	;GUI, Add, Edit, x+5 w33 Limit4 gSubmit vParagonMain%A_Index%, % ParagonMain%A_Index%
	;GUI, Add, Text, x+5, Vit:
	;GUI, Add, Edit, x+5 w33 Limit4 gSubmit vParagonVitality%A_Index%, % ParagonVitality%A_Index%
	;GUI, Add, Text, x+5, Mov:
	;GUI, Add, Edit, x+5 w33 Limit4 Number gSubmit vParagonMovement%A_Index%, % ParagonMovement%A_Index%
	;GUI, Add, Text, x+5, Res:
	;GUI, Add, Edit, x+5 w33 Limit4 Number gSubmit vParagonRessource%A_Index%, % ParagonRessource%A_Index%
}   
GUI, Add, Text, xm, Ping [ms]:
GUI, Add, Edit, x+5 w33 Limit3 Number gSubmit vPing, %Ping%

HotKeyCombo1=0
HotKeyCombo2=0
HotKeyCombo3=0

Return

~F1::
	GUI, Show , ,ParagonSpender v1.0.1 Hotkeys
Return

GuiClose:
	GUI, Hide
	IfWinExist, ahk_class D3 Main Window Class
		WinActivate, ahk_class D3 Main Window Class
Return

Submit:
	GUIControlGet, Ping
	IniWrite, %Ping%, Hotkeys.ini, Settings, Ping
	Loop % #ctrls 
	{
		;GUIControlGet, ParagonMain%A_Index%
		;GUIControlGet, ParagonVitality%A_Index%
		;GUIControlGet, ParagonMovement%A_Index%
		;GUIControlGet, ParagonRessource%A_Index%
		
		;IniWrite, % ParagonMain%A_Index%, Hotkeys.ini, Settings, ParagonMain%A_Index%
		;IniWrite, % ParagonVitality%A_Index%, Hotkeys.ini, Settings, ParagonVitality%A_Index%
		;IniWrite, % ParagonMovement%A_Index%, Hotkeys.ini, Settings, ParagonMovement%A_Index%
		;IniWrite, % ParagonRessource%A_Index%, Hotkeys.ini, Settings, ParagonRessource%A_Index%
	}
Return

~ESC::Reload
Return


Label1:		;Hotkey for Skill Combination 1
	IfWinNotActive, ParagonSpender Hotkeys
	{
		if (HotKeyCombo1 == 0)
		{
			HotKeyCombo1=1
			SetTimer, HotKeySet1, 19000
			SetTimer, HotKeySet2, 100
			SetTimer, HotKeySet3, 3000
		}
		else
		{
			HotKeyCombo1=0
			SetTimer, HotKeySet1, Off
			SetTimer, HotKeySet2, Off
			SetTimer, HotKeySet3, Off
		}
		
	}
Return

Label2:		;Hotkey for #2 Paragon Setup
	IfWinNotActive, ParagonSpender Hotkeys
	{
	}
Return

Label3:		;Hotkey for #3 Paragon Setup
	IfWinNotActive, ParagonSpender Hotkeys
	{
	}
Return

HotKeySet1: ;Wrath of the Beserker
	
	WinActivate, ahk_class D3 Main Window Class
	WinWaitActive, ahk_class D3 Main Window Class
	MouseGetPos x, y
	SendInput, {Space down}
	MouseClick, Left, %x%, %y%
	SendInput, {Space up}
Return

HotKeySet2: ;IP + WarCry + Falter
	
	WinActivate, ahk_class D3 Main Window Class
	WinWaitActive, ahk_class D3 Main Window Class
	SendInput, 2
	SendInput, 3
	SendInput, 4
Return

HotKeySet3: ;Sprint
	
	WinActivate, ahk_class D3 Main Window Class
	WinWaitActive, ahk_class D3 Main Window Class
	SendInput, 1
Return

ExitFunc()
{
	if (HotKeyCombo1 != 0)
		{
			SetTimer, HotKeySet1, Off
			SetTimer, HotKeySet2, Off
			SetTimer, HotKeySet3, Off
		}
}

GuiLabel:
	If %A_GuiControl% in +,^,!,+^,+!,^!,+^!    ;If the hotkey contains only modifiers, return to wait for a key.
		return
	If InStr(%A_GuiControl%,"vk07")            ;vk07 = MenuMaskKey (see below)
		GuiControl,,%A_GuiControl%, % lastHK      ;Reshow the hotkey, because MenuMaskKey clears it.
	Else
		validateHK(A_GuiControl)
return

validateHK(GuiControl) 
{
	global lastHK
	Gui, Submit, NoHide
	lastHK := %GuiControl%                     ;Backup the hotkey, in case it needs to be reshown.
	num := SubStr(GuiControl,3)                ;Get the index number of the hotkey control.
	If (HK%num% != "") 						   ;If the hotkey is not blank...
	{                       
		StringReplace, HK%num%, HK%num%, SC15D, AppsKey      ;Use friendlier names,
		StringReplace, HK%num%, HK%num%, SC154, PrintScreen  ;  instead of these scan codes.
		If CB%num%                                ;  If the 'Win' box is checked, then add its modifier (#).
			HK%num% := "#" HK%num%
		If !RegExMatch(HK%num%,"[#!\^\+]")        ;  If the new hotkey has no modifiers, add the (~) modifier.
			HK%num% := "~" HK%num%                   ;    This prevents any key from being blocked.
		checkDuplicateHK(num)
	}
	If (savedHK%num% || HK%num%)               ;Unless both are empty,
		setHK(num, savedHK%num%, HK%num%)         ;  update INI/GUI
}

checkDuplicateHK(num)
{
	global #ctrls
	Loop,% #ctrls
	If (HK%num% = savedHK%A_Index%) 
	{
		dup := A_Index
		Loop,6 
		{
			GuiControl,% "Disable" b:=!b, HK%dup%   ;Flash the original hotkey to alert the user.
			Sleep,200
		}
		GuiControl,,HK%num%,% HK%num% :=""       ;Delete the hotkey and clear the control.
		break
	}
}

setHK(num,INI,GUI) 
{
	If INI                           ;If previous hotkey exists,
		Hotkey, %INI%, Label%num%, Off  ;  disable it.
	If GUI                           ;If new hotkey exists,
		Hotkey, %GUI%, Label%num%, On   ;  enable it.
	IniWrite,% GUI ? GUI:null, Hotkeys.ini, Hotkeys, %num%
	savedHK%num%  := HK%num%
}

#MenuMaskKey vk07                 ;Requires AHK_L 38+
#If ctrl := HotkeyCtrlHasFocus()
	*AppsKey::                       ;Add support for these special keys,
	*BackSpace::                     ;  which the hotkey control does not normally allow.
	*Delete::
	*Enter::
	*Escape::
	*Pause::
	*PrintScreen::
	*Space::
	*Tab::
	modifier := ""
	If GetKeyState("Shift","P")
		modifier .= "+"
	If GetKeyState("Ctrl","P")
		modifier .= "^"
	If GetKeyState("Alt","P")
		modifier .= "!"
	Gui, Submit, NoHide             ;If BackSpace is the first key press, Gui has never been submitted.
	If (A_ThisHotkey == "*BackSpace" && %ctrl% && !modifier)   ;If the control has text but no modifiers held,
		GuiControl,,%ctrl%                                       ;  allow BackSpace to clear that text.
	Else                                                     ;Otherwise,
		GuiControl,,%ctrl%, % modifier SubStr(A_ThisHotkey,2)  ;  show the hotkey.
	validateHK(ctrl)
	return
#If

HotkeyCtrlHasFocus() 
{
	GuiControlGet, ctrl, Focus       ;ClassNN
	If InStr(ctrl,"hotkey") 
	{
		GuiControlGet, ctrl, FocusV     ;Associated variable
	Return, ctrl
	}
}
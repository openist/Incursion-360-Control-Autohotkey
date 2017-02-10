#Persistent  ; Keep this script running until the user explicitly exits it.
#InstallKeybdHook
SetTimer, WatchAxis, 5

;; fullscreen  and deborderize incursion
IfWinExist, Incursion: Halls of the Goblin King
{
	WinActivate Incursion: Halls of the Goblin King
		WinWaitActive, Incursion: Halls of the Goblin King
		WinSet, Style, -0x800000, Incursion: Halls of the Goblin King
		WinSet, AlwaysOnTop, Off, Incursion: Halls of the Goblin King
		WinSet, Style, -0xC00000, Incursion: Halls of the Goblin King
		WinMove, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%
}
; If you want to unconditionally use a specific joystick number, change
; the following value from 0 to the number of the joystick (1-16).
; A value of 0 causes the joystick number to be auto-detected:
global JoystickNumber = 0

; END OF CONFIG SECTION. Do not make changes below this point unless
; you wish to alter the basic functionality of the script.

; Auto-detect the joystick number if called for:
if JoystickNumber <= 0
{
    Loop 16  ; Query each joystick number to find out which ones exist.
    {
        GetKeyState, JoyName, %A_Index%JoyName
        if JoyName <>
        {
            JoystickNumber = %A_Index%
            break
        }
    }
    if JoystickNumber <= 0
    {
        MsgBox The system does not appear to have any joysticks.
        ExitApp
    }
}

; this is the data necessary to track and render the action menu
global actionMenuData := []
global actionMenuContext := 0
global actionMenuLength := 31
actionMenuData[1,1] := 207
actionMenuData[2,1] := 223
actionMenuData[3,1] := 239
actionMenuData[4,1] := 255
actionMenuData[5,1] := 271
actionMenuData[6,1] := 287
actionMenuData[7,1] := 303
actionMenuData[8,1] := 319
actionMenuData[9,1] := 335
actionMenuData[10,1] := 351
actionMenuData[11,1] := 367
actionMenuData[12,1] := 383
actionMenuData[13,1] := 399
actionMenuData[14,1] := 415
actionMenuData[15,1] := 431
actionMenuData[16,1] := 447
actionMenuData[17,1] := 463
actionMenuData[18,1] := 479
actionMenuData[19,1] := 495
actionMenuData[20,1] := 511
actionMenuData[21,1] := 527
actionMenuData[22,1] := 543
actionMenuData[23,1] := 559
actionMenuData[24,1] := 575
actionMenuData[25,1] := 591
actionMenuData[26,1] := 607
actionMenuData[27,1] := 623
actionMenuData[28,1] := 639
actionMenuData[29,1] := 655
actionMenuData[30,1] := 671
actionMenuData[31,1] := 687
actionMenuData[32,1] := 703
actionMenuData[1,2] := "="
actionMenuData[2,2] := "."
actionMenuData[3,2] := ","
actionMenuData[4,2] := "-"
actionMenuData[5,2] := "<"
actionMenuData[6,2] := ">"
actionMenuData[7,2] := "a"
actionMenuData[8,2] := "b"
actionMenuData[9,2] := "c"
actionMenuData[10,2] := "d"
actionMenuData[11,2] := "e"
actionMenuData[12,2] := "f"
actionMenuData[13,2] := "g"
actionMenuData[14,2] := "h"
actionMenuData[15,2] := "i"
actionMenuData[16,2] := "j"
actionMenuData[17,2] := "k"
actionMenuData[18,2] := "l"
actionMenuData[19,2] := "m"
actionMenuData[20,2] := "n"
actionMenuData[21,2] := "o"
actionMenuData[22,2] := "p"
actionMenuData[23,2] := "q"
actionMenuData[24,2] := "r"
actionMenuData[25,2] := "s"
actionMenuData[26,2] := "t"
actionMenuData[27,2] := "u"
actionMenuData[28,2] := "v"
actionMenuData[29,2] := "w"
actionMenuData[30,2] := "x"
actionMenuData[31,2] := "y"
actionMenuData[32,2] := "z"


; this is the data necessary to track and render the character menu
global charMenuData := []
global charMenuContext := 0
global charMenuLength := 12
charMenuData[1,1] := 1
charMenuData[1,2] := 1023
charMenuData[1,3] := 292
charMenuData[1,4] := "p"
charMenuData[2,1] := 600
charMenuData[2,2] := 1023
charMenuData[2,3] := 205
charMenuData[2,4] := "w"
charMenuData[3,1] := 1
charMenuData[3,2] := 1039
charMenuData[3,3] := 215
charMenuData[3,4] := "g"
charMenuData[4,1] := 215
charMenuData[4,2] := 1039
charMenuData[4,3] := 240
charMenuData[4,4] := "l"
charMenuData[5,1] := 456
charMenuData[5,2] := 1039
charMenuData[5,3] := 240
charMenuData[5,4] := "s"
charMenuData[6,1] := 713
charMenuData[6,2] := 1039
charMenuData[6,3] := 200
charMenuData[6,4] := "m"
charMenuData[7,1] := 919
charMenuData[7,2] := 1039
charMenuData[7,3] := 220
charMenuData[7,4] := "c"
charMenuData[8,1] := 1126
charMenuData[8,2] := 1039
charMenuData[8,3] := 150
charMenuData[8,4] := "q"
charMenuData[9,1] := 1
charMenuData[9,2] := 1055
charMenuData[9,3] := 214
charMenuData[9,4] := "g"
charMenuData[10,1] := 215
charMenuData[10,2] := 1055
charMenuData[10,3] := 260
charMenuData[10,4] := "f"
charMenuData[11,1] := 535
charMenuData[11,2] := 1055
charMenuData[11,3] := 150
charMenuData[11,4] := "j"
charMenuData[12,1] := 696
charMenuData[12,2] := 1055
charMenuData[12,3] := 265
charMenuData[12,4] := "r"
charMenuData[13,1] := 964
charMenuData[13,2] := 1055
charMenuData[13,3] := 244
charMenuData[13,4] := "d"

; these global variables control the various special modes that basically alter what the default controls do based on context
global inventoryMode := 0
global actionMenuMode := 0
global charMenuMode := 0
global shiftmode := 0
global lookmode := 0
global mapmode := 0

Hotkey, %JoystickNumber%Joy1, myjoy1
Hotkey, %JoystickNumber%Joy2, myjoy2
Hotkey, %JoystickNumber%Joy3, myjoy3
Hotkey, %JoystickNumber%Joy4, myjoy4
Hotkey, %JoystickNumber%Joy5, myjoy5
Hotkey, %JoystickNumber%Joy6, myjoy6
Hotkey, %JoystickNumber%Joy7, myjoy7
Hotkey, %JoystickNumber%Joy8, myjoy8
Hotkey, %JoystickNumber%Joy9, myjoy9
Hotkey, %JoystickNumber%Joy10, myjoy10
Hotkey, %JoystickNumber%Joy11, myjoy11

return

; helper function for creating the menus
CreateBox(Color)
{
	Gui 81:color, %Color%
	Gui 81:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 82:color, %Color%
	Gui 82:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 83:color, %Color%
	Gui 83:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 84:color, %Color%
	Gui 84:+ToolWindow -SysMenu -Caption +AlwaysOnTop
}

; helper function for creating the menus
Box(XCor, YCor, Width, Height, Thickness, Offset)
{
	If InStr(Offset, "In")
	{
		StringTrimLeft, offset, offset, 2
		If not Offset
			Offset = 0
		Side = -1
	} Else {
		StringTrimLeft, offset, offset, 3
		If not Offset
			Offset = 0
		Side = 1
	}
	x := XCor - (Side + 1) / 2 * Thickness - Side * Offset
	y := YCor - (Side + 1) / 2 * Thickness - Side * Offset
	h := Height + Side * Thickness + Side * Offset * 2
	w := Thickness
	Gui 81:Show, x%x% y%y% w%w% h%h% NA
	x += Thickness
	w := Width + Side * Thickness + Side * Offset * 2
	h := Thickness
	Gui 82:Show, x%x% y%y% w%w% h%h% NA
	x := x + w - Thickness
	y += Thickness
	h := Height + Side * Thickness + Side * Offset * 2
	w := Thickness
	Gui 83:Show, x%x% y%y% w%w% h%h% NA
	x := XCor - (Side + 1) / 2 * Thickness - Side * Offset
	y += h - Thickness
	w := Width + Side * Thickness + Side * Offset * 2
	h := Thickness
	Gui 84:Show, x%x% y%y% w%w% h%h% NA
}

; helper function for removing the menus
RemoveBox()
{
	Gui 81:destroy
	Gui 82:destroy
	Gui 83:destroy
	Gui 84:destroy

}

; inititilize the action menu
initActionMenu()
{
	curPosition = % actionMenuData[actionMenuContext,1]
	;MsgBox %curPosition%
	CreateBox("FF0000")
	Box(962, curPosition, 428, 16, 1, "out")
	actionMenuContext = 1
}

; inititilize the character menu
initCharMenu()
{
	curPosition1 = % charMenuData[charMenuContext,1]
	curPosition2 = % charMenuData[charMenuContext,2]
	curPosition3 = % charMenuData[charMenuContext,3]
	;MsgBox %curPosition%
	CreateBox("FF0000")
	Box(curPosition1, curPosition2, curPosition3, 16, 1, "out")
	charMenuContext = 1
}

charMenuRight()
{
	RemoveBox()
	;; if we are at the end of the menu go to the top
	if(charMenuContext > charMenuLength){
		charMenuContext = 1
	} else {
		charMenuContext += 1
	}
	;MsgBox, %actionMenuContext%
	curPosition1 = % charMenuData[charMenuContext,1]
	curPosition2 = % charMenuData[charMenuContext,2]
	curPosition3 = % charMenuData[charMenuContext,3]
	;MsgBox %curPosition%
	CreateBox("FF0000")
	Box(curPosition1, curPosition2, curPosition3, 16, 1, "out")
	Sleep, 100
}

charMenuLeft()
{
	RemoveBox()
	;; if we are at the end of the menu go to the top
	if(charMenuContext = 1){
		charMenuContext = 32
	} else {
		charMenuContext -= 1
	}
	;MsgBox, %actionMenuContext%
	curPosition1 = % charMenuData[charMenuContext,1]
	curPosition2 = % charMenuData[charMenuContext,2]
	curPosition3 = % charMenuData[charMenuContext,3]
	;MsgBox %curPosition%
	CreateBox("FF0000")
	Box(curPosition1, curPosition2, curPosition3, 16, 1, "out")
	Sleep, 100
}

actionMenuDown()
{
	RemoveBox()
	;; if we are at the end of the menu go to the top
	if(actionMenuContext > actionMenuLength){
		actionMenuContext = 1
	} else {
		actionMenuContext += 1
	}
	;MsgBox, %actionMenuContext%
	curPosition = % actionMenuData[actionMenuContext,1]
	;MsgBox %curPosition%
	CreateBox("FF0000")
	Box(962, curPosition, 428, 16, 1, "out")
	Sleep, 100
}

actionMenuUp()
{
	RemoveBox()
	;; if we are at the end of the menu go to the top
	if(actionMenuContext = 1){
		actionMenuContext = 32
	} else {
		actionMenuContext -= 1
	}
	;MsgBox, %actionMenuContext%
	curPosition = % actionMenuData[actionMenuContext,1]
	;MsgBox %curPosition%
	CreateBox("FF0000")
	Box(962, curPosition, 428, 16, 1, "out")
	Sleep, 100
}

actionMenuExecute()
{
	RemoveBox()
	curAction = % actionMenuData[actionMenuContext,2]
	;MsgBox %curAction%
	Send {Escape}
	Sleep, 100
	Send {%curAction%)
	actionMenuMode = 0
}

charMenuExecute()
{
	RemoveBox()
	curAction = % charMenuData[charMenuContext,4]
	;MsgBox %curAction%
	;Send {%curAction%)
	sendinput, %curAction%
    keywait, 2Joy1
	charMenuMode = 0
}

menuClose()
{
	RemoveBox()
}



;; This is the main function that watches for analog control changes
;;------------------------------------------------------------------------
WatchAxis:
GetKeyState, 2JoyX, %JoystickNumber%JoyX  ; Get position of X axis.
GetKeyState, 2JoyY, %JoystickNumber%JoyY  ; Get position of Y axis.
GetKeyState, 2JoyU, %JoystickNumber%JoyU  ; Get position of Y axis.
GetKeyState, 2JoyV, %JoystickNumber%JoyV  ; Get position of Y axis.
GetKeyState, 2JoyR, %JoystickNumber%JoyR  ; Get position of Y axis.
GetKeyState, 2JoyZ, %JoystickNumber%JoyZ  ; Get position of Y axis.
GetKeyState, 2JoyPOV, %JoystickNumber%JoyPOV  ; Get position of Y axis.
KeyToHoldDownPrev = %KeyToHoldDown%  ; Prev now holds the key that was down before (if any).


if 2JoyZ > 20                                    ; left trigger
    shiftmode = 1
else
	shiftmode = 0

if (2JoyX > 70) {                                ; left stick right 
	if(shiftmode = 1){
		KeyToHoldDown = Numpad3
	} else if (charMenuMode = 1){
		charMenuRight()
	} else {
		KeyToHoldDown = Right
	}
} else if (2JoyX < 30) {                         ; left stick left
	if(shiftmode = 1){
		KeyToHoldDown = Numpad7
	} else if (charMenuMode = 1){
		charMenuLeft()
	} else {
		KeyToHoldDown = Left
	}
} else if (2JoyY > 70) {                         ; left stick down
	if(shiftmode = 1){
		KeyToHoldDown = Numpad1
	} else if (actionMenuMode = 1){
		actionMenuDown()
	} else {
		KeyToHoldDown = Down
	}
} else if (2JoyY < 30) {                         ; left stick up
	if(shiftmode = 1){
		KeyToHoldDown = Numpad9
	} else if (actionMenuMode = 1){
		actionMenuUp()
	} else {
		KeyToHoldDown = Up
	}
} else if (2JoyV > 70) {                         ; right stick right
	if (shiftmode = 1) {
		Send {Alt down}{Right}{Alt up}
	    Sleep, 100
	} else {
		KeyToHoldDown = Numpad6
	}
} else if (2JoyV < 30) {                         ; right stick left
	if (shiftmode = 1) {
		Send {Alt down}{Left}{Alt up}
	    Sleep, 100
	} else {
		KeyToHoldDown = Numpad4
	}
} else if (2JoyU > 70) {                         ; right stick down 
	if(mapmode = 1){
		KeyToHoldDown = -
	} else if (shiftmode = 1) {
		Send {Alt down}{Down}{Alt up}
	    Sleep, 100
	} else {
		KeyToHoldDown = Numpad2
	}
} else if (2JoyU < 30) {                         ; right stick up
	if(mapmode = 1){
		KeyToHoldDown = +
	} else if (shiftmode = 1){
		Send {Alt down}{Up}{Alt up}
	    Sleep, 100
	} else{
		KeyToHoldDown = Numpad8
	}
} else if (2JoyR > 40) {                         ; Right trigger
    KeyToHoldDown = f
} else if (2JoyPOV > -1 and 2JoyPOV < 8999) {    ; hat up
	if(shiftmode = 1){
		KeyToHoldDown = PgUp
	} else {
		KeyToHoldDown = F8
	}
} else if (2JoyPOV > 8999 and 2JoyPOV < 17999) { ; hat right
	 if (inventoryMode = 1){
		KeyToHoldDown = Tab
	} else if(shiftmode = 1){
		KeyToHoldDown = F3
	} else {
		KeyToHoldDown = q
	}
} else if (2JoyPOV > 17999 and 2JoyPOV < 26999) { ; hat down
	if(shiftmode = 1){
		KeyToHoldDown = PgDn
	} else if (inventoryMode = 1){
		KeyToHoldDown = d
	} else {
		KeyToHoldDown = q
	}
} else if (2JoyPOV > 26999) {                     ; hat left
	if(shiftmode = 1){
		KeyToHoldDown = y
	} else if (inventoryMode = 1){
		KeyToHoldDown = Tab
	} else {
		KeyToHoldDown = u
	}
} else {
    KeyToHoldDown =
}

Rightvar = Numpad6
Leftvar = Numpad4
Upvar = Numpad8
Downvar = Numpad2

; here we test to see if this is the right stick being pressed, if it is we enable key repeating for fast movment, otherwise we enable a single keypress
if(KeyToHoldDown = Rightvar or KeyToHoldDown = Leftvar or KeyToHoldDown = Upvar or KeyToHoldDown = Downvar){
	if KeyToHoldDown = %KeyToHoldDownPrev%  ; The correct key is already down (or no key is needed).
    {
		if KeyToHoldDown
			SetKeyDelay 100
			Send, {%KeyToHoldDown% down}  ; Auto-repeat the keystroke.
		return
	}
} else {
	if KeyToHoldDown = %KeyToHoldDownPrev%  ; The correct key is already down (or no key is needed).
		return  ; Do nothing.
}




; Otherwise, release the previous key and press down the new key:
SetKeyDelay -1  ; Avoid delays between keystrokes.
if KeyToHoldDownPrev   ; There is a previous key to release.
    Send, {%KeyToHoldDownPrev% up}  ; Release it.
if KeyToHoldDown   ; There is a key to press down.
    Send, {%KeyToHoldDown% down}  ; Press it down.
return

; main non analog button remaping
; ------------------------------------------------------------------------------

myjoy1:                 ; A
	if(lookmode = 1){ ; if we are in lookmode we will send examine by default
		Send {x}
		lookmode += 1
	} else if(lookmode = 2){ ; if we have stepped into examine mode then a should do nothing, forcing the user to escape using b
		; do nothing
	} else if(shiftmode = 1){
		Send {y}
	} else if(mapmode = 1){ 
		Send {r}
	    mapmode = 0
	} else if(actionMenuMode = 1){ 
		actionMenuExecute()
	    actionMenuMode = 0
	} else if(charMenuMode = 1){ 
		charMenuExecute()
	    charMenuMode = 0
		menuClose()
	} else if(inventoryMode = 1){ 
		Send {x}
	    inventoryMode += 1
    } else {
		Send {Enter}
	}
Return
	
myjoy2:                  ; B
	if(lookmode > 0){   ; if lookmode is engadges we step the variable that represents the depth of the dialog back
		lookmode -= 1
		Send {Escape} 
	} else if (shiftmode = 1) {
	    Send {n} 
	}else if (inventoryMode > 0) {
		inventoryMode -= 1
	    Send {Escape} 
	}else if (charMenuMode = 1) {
		charMenuMode = 0
	    Send {Escape} 
		menuClose()
	}else if (actionMenuMode = 1) {
		actionMenuMode = 0
	    Send {Escape} 
		menuClose()
	} else {
		Send {Escape} 
	}
	mapmode = 0
	actionMenuMode = 0
Return

myjoy3:     ; X
	if(shiftmode = 1){
		Send {m}
	} else {
		Send {Space}
	}
Return


myjoy4:
	if (inventoryMode = 1) {
		Send {s}
	} else {
		Send {?}
		actionMenuMode = 1
		actionMenuContext = 1
		initActionMenu()
	}
Return

myjoy5:
	Send {m}         ; LShoulder
Return

myjoy6:                 ; RShoulder
	Send {l}
	lookmode = 1
Return

myjoy7:         ; Back
	if(shiftmode = 1){
		Send {l}
		Send {o}
		mapmode = 1
	} else {
		Send {i}
	    inventoryMode = 1
	}
Return

myjoy8:         ; Start
	Send {d}
	charMenuMode = 1
	charMenuContext = 1
	initCharMenu()
Return

myjoy9:         ; LStick
	Send {.}
Return

myjoy10:       ; RStick
	Send {,}
Return

myjoy11:                ; Xbox
	if(shiftmode = 1){
		Send {?} 
	} else {
		Send {v} 
	}
Return

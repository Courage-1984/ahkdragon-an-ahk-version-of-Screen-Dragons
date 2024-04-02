Picture := "C:\Users\" . A_UserName . "\Documents\ahkdragon_temp_default.png"
Opacity := "255"
global X, Y
X := 0
Y := 0
FileInstall, default.png, % "C:\Users\" . A_UserName . "\Documents\ahkdragon_temp_default.png"

AlwaysOnTop := false

OnMessage(0x201, "WM_LBUTTONDOWN")
WM_LBUTTONDOWN()
{
 PostMessage, 0xA1, 2
 WinGetPos, XPos, YPos,,,ahkdragon
 X := XPos
 Y := YPos
}

Gui, Color, 000000
Gui -Border +ToolWindow
Gui, Add , Picture, vPic, % Picture
Gui, Show,NA  X%X% Y%Y% AutoSize, ahkdragon
WinSet, TransColor, 000000 255,ahkdragon
Gui +AlwaysOnTop -Caption
return


; Modifiers

; # = Windows Key;
; ! = Alt;        
; ^ = Control;
; + = Shift;
; & = Used to combine keys (ctrl+alt = ^&!);

+WheelUp::
 Opacity := Opacity + 5
 WinSet, TransColor,000000 %Opacity%,ahkdragon
return

+WheelDown::
 Opacity := Opacity - 5
 WinSet, TransColor,000000 %Opacity%,ahkdragon
return


+q:: ; Shift+q to toggle AlwaysOnTop
AlwaysOnTop := !AlwaysOnTop
if (AlwaysOnTop)
    Gui, +AlwaysOnTop
else
    Gui, -AlwaysOnTop
return


GuiDropFiles:
 Picture := A_GuiEvent
 GuiControl,, Pic, *w%width% *h%height% %Picture%
 Gui, Show,NA  X%X% Y%Y% AutoSize, ahkdragon
return


!WheelUp::
GuiControlGet, O, Pos, Pic
OW := OW + 50
OH := OH + 50
GuiControl, MoveDraw, Pic, w%OW% h%OH%
WinMove, ahkdragon,,,, %OW%, %OH%
return

!WheelDown::
GuiControlGet, O, Pos, Pic
OW := OW - 50
OH := OH - 50
GuiControl, MoveDraw, Pic, w%OW% h%OH%
WinMove, ahkdragon,,,, %OW%, %OH%
return

GuiClose:
ExitApp
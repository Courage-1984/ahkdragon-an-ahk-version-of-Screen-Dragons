#Persistent
SetBatchLines -1

FileInstall, default.png, % "C:\Users\" . A_UserName . "\Documents\ahkdragon_temp_default.png"

Picture := "C:\Users\" . A_UserName . "\Documents\ahkdragon_temp_default.png"
Opacity := "255"
global X, Y
X := 0
Y := 0
AlwaysOnTop := false

; Get the original width and height of the image
Gui, Add, Picture, vPic, % Picture
Gui, Show, NA NoActivate, ahkdragon
GuiControlGet, width, Pos, PicW
GuiControlGet, height, Pos, PicH
Gui, Destroy

OnMessage(0x201, "WM_LBUTTONDOWN")
WM_LBUTTONDOWN() {
    PostMessage, 0xA1, 2
    WinGetPos, XPos, YPos,,, ahkdragon
    X := XPos
    Y := YPos
}

Gui, Color, 000000
Gui -Border +ToolWindow
Gui, Add, Picture, vPic, % Picture
Gui, Show, NA X%X% Y%Y% AutoSize, ahkdragon
WinSet, TransColor, 000000 255, ahkdragon
Gui +AlwaysOnTop -Caption
return

; Modifiers
; # = Windows Key;
; ! = Alt;        
; ^ = Control;
; + = Shift;
; & = Used to combine keys (ctrl+alt = ^&!);

^+WheelUp:: ; Ctrl+Shift+WheelUp to Increase Opacity
    Opacity := Opacity + 10
    WinSet, TransColor, 000000 %Opacity%, ahkdragon
return

^+WheelDown:: ; Ctrl+Shift+WheelDown to Decrease Opacity
    Opacity := Opacity - 10
    WinSet, TransColor, 000000 %Opacity%, ahkdragon
return

+t:: ; Shift+t to toggle AlwaysOnTop
    AlwaysOnTop := !AlwaysOnTop
    if (AlwaysOnTop)
        Gui, +AlwaysOnTop
    else
        Gui, -AlwaysOnTop
return

GuiDropFiles:
    Picture := A_GuiEvent
    GuiControl,, Pic, *w%width% *h%height% %Picture%
    Gui, Show, NA X%X% Y%Y% AutoSize, ahkdragon
return

!WheelUp:: ; Alt+WheelUp to Increase Image Size
    GuiControlGet, O, Pos, Pic
    NewWidth := Round(OW * 1.1)
    NewHeight := Round(OH * 1.1)
    GuiControl, MoveDraw, Pic, w%NewWidth% h%NewHeight%
    WinMove, ahkdragon, , , , %NewWidth%, %NewHeight%
return

!WheelDown:: ; Alt+WheelDown to Decrease Image Size
    GuiControlGet, O, Pos, Pic
    NewWidth := Round(OW * 0.9)
    NewHeight := Round(OH * 0.9)
    GuiControl, MoveDraw, Pic, w%NewWidth% h%NewHeight%
    WinMove, ahkdragon, , , , %NewWidth%, %NewHeight%
return

GuiClose:
    ExitApp

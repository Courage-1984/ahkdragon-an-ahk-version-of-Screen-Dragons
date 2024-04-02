#Persistent
#SingleInstance Off ; Allow multiple instances
SetBatchLines -1

instanceCounter := 0
instanceCounter++
; GuiTitle := "ahkdragon_" . instanceCounter

; Unique title for the GUI window
GuiTitle := "ahkdragon_" . A_TickCount

FileInstall, default.png, % "C:\Users\" . A_UserName . "\Documents\ahkdragon_temp_default.png"

Picture := "C:\Users\" . A_UserName . "\Documents\ahkdragon_temp_default.png"
Opacity := 255
global X, Y
; X := 0
; Y := 0
X := A_ScreenWidth // 2.5
Y := A_ScreenHeight // 7
AlwaysOnTop := false


; Get the original width and height of the image
Gui, Add, Picture, vPic, % Picture
Gui, Show, NA, % GuiTitle
WinSet, TransColor, 000000 %Opacity%, % GuiTitle
GuiControlGet, width, Pos, PicW
GuiControlGet, height, Pos, PicH

hwnd := WinExist(%GuiTitle%) ; Get the handle of the GUI window
; WinSet, Transparent, %Opacity%, ahkdragon

OnMessage(0x201, "WM_LBUTTONDOWN")
WM_LBUTTONDOWN() {
    PostMessage, 0xA1, 2
    WinGetPos, XPos, YPos,,, % GuiTitle
    X := XPos
    Y := YPos
}

Gui, Color, 000000
Gui -Border +ToolWindow

Gui, Show, NA X%X% Y%Y% AutoSize, % GuiTitle
WinSet, TransColor, 000000 %Opacity%, % GuiTitle

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
    WinSet, TransColor, 000000 %Opacity%, % GuiTitle
return

^+WheelDown:: ; Ctrl+Shift+WheelDown to Decrease Opacity
    Opacity := Opacity - 10
    WinSet, TransColor, 000000 %Opacity%, % GuiTitle
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
    Gui, Show, NA X%X% Y%Y% AutoSize, % GuiTitle
return

!WheelUp:: ; Alt+WheelUp to Increase Image Size
    GuiControlGet, O, Pos, Pic
    NewWidth := Round(OW * 1.1)
    NewHeight := Round(OH * 1.1)
    GuiControl, MoveDraw, Pic, w%NewWidth% h%NewHeight%
    WinMove, % GuiTitle, , , , %NewWidth%, %NewHeight%
return

!WheelDown:: ; Alt+WheelDown to Decrease Image Size
    GuiControlGet, O, Pos, Pic
    NewWidth := Round(OW * 0.9)
    NewHeight := Round(OH * 0.9)
    GuiControl, MoveDraw, Pic, w%NewWidth% h%NewHeight%
    WinMove, % GuiTitle, , , , %NewWidth%, %NewHeight%
return

GuiClose:
    ExitApp

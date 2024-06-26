## Consider the following ahk *(my main ahk script actually)*:

```ahk
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
X := 0
Y := 0
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
```

***

### Now for my main ahk at the start I use:

```ahk
; GuiTitle := "ahkdragon_" . instanceCounter

; Unique title for the GUI window
GuiTitle := "ahkdragon_" . A_TickCount"
```

> With this, each new instance of the ahk renders correctly and doesn't show a black background where it is supposed to be transparent.
> The problem is I can only control (change `image size` and `opacity` and `AlwaysOnTop`) the newest instance I launched and not the older ones.

### but Now when I use this at the beginning:

```ahk
GuiTitle := "ahkdragon_" . instanceCounter

; Unique title for the GUI window
; GuiTitle := "ahkdragon_" . A_TickCount"
```

> Each new instance of the ahk renders shows a black background where it is supposed to be transparent.
> But I can control changing the `opacity` of individual instances (new and old) and changing the `image size` of individual instances (new and old) (this is a bit glitchy; but kinda works?) depending on which one i clicked last.

***

**[ahkdragon2.ahk](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons/blob/main/multiple%20instance%20attempts/ahkdragon2.ahk)** is the second version... 

Play around with it and see what you can figure out...

#### also check out the next and (currently final) iteration of my attempt at trying to run multiple instance of `ahkdragon` at: "[ahkdragon3 - multiple instance issue end result](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons/blob/main/multiple%20instance%20attempts/ahkdragon3%20-%20multiple%20instance%20issue%20end%20result.md)"


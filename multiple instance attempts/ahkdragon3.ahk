#Persistent
#SingleInstance Off
SetBatchLines -1

; instanceCounter := 0
; instanceCounter++
; GuiTitle := "ahkdragon_" . instanceCounter

; Unique title for the GUI window
; GuiTitle := "ahkdragon_" . A_TickCount

FileInstall, default.png, % "C:\Users\" . A_UserName . "\Documents\ahkdragon_temp_default.png"

Picture := "C:\Users\" . A_UserName . "\Documents\ahkdragon_temp_default.png"


global guiArray := {} ; Store GUI titles and handles
global instanceCounter := 0
global Opacity := 255
global X, Y := 0, 0
global AlwaysOnTop := false


; When creating a new GUI:
instanceCounter++
GuiTitle := "ahkdragon_" . A_TickCount
guiArray[GuiTitle] := { "opacity": Opacity } ; Initialize with default opacity

; Debugging message
MsgBox, % "Created new GUI with title: " GuiTitle

; ... create GUI with GuiTitle ...

; Get the original width and height of the image
Gui, Add, Picture, vPic, % Picture
Gui, Show, NA, % GuiTitle

; After showing the GUI, store the handle:
hwnd := WinExist("A") ; Retrieve the handle of the last shown GUI window
guiArray[GuiTitle].handle := hwnd ; Store the handle in the array

; Debugging message
MsgBox, % "Stored handle " hwnd " for GUI title: " GuiTitle

; Debugging message to show current state of guiArray
for k, v in guiArray {
    MsgBox, % "Key: " k "`nHandle: " v.handle "`nOpacity: " v.opacity
}

WinSet, TransColor, 000000 %Opacity%, % GuiTitle
GuiControlGet, width, Pos, PicW
GuiControlGet, height, Pos, PicH

OnMessage(0x201, "WM_LBUTTONDOWN")
WM_LBUTTONDOWN() {
    global X
    global Y

    PostMessage, 0xA1, 2
    WinGetPos, XPos, YPos,,, % GuiTitle
    X := XPos
    Y := YPos
    ; activeGuiTitle := GetActiveGuiTitle()

    ; Gui, Show, NA X%X% Y%Y% AutoSize, % activeGuiTitle

}

Gui, Color, 000000
Gui -Border +ToolWindow

; Gui, Show, NA X%X% Y%Y% AutoSize, % GuiTitle
WinSet, TransColor, 000000 %Opacity%, % GuiTitle


; hwnd := WinExist(%GuiTitle%) ; Get the handle of the GUI window


; Gui, Color, 000000
; Gui -Border +ToolWindow


; activeGuiTitle := GetActiveGuiTitle()
; GuiData := guiArray[activeGuiTitle]
; GuiData.opacity := GuiData.opacity - 10

; Gui, Show, NA X%X% Y%Y% AutoSize, % activeGuiTitle
; WinSet, TransColor, 000000 GuiData.opacity, "ahk_id " . GuiData.handle




Gui +AlwaysOnTop -Caption
return

; Modifiers
; # = Windows Key;
; ! = Alt;        
; ^ = Control;
; + = Shift;
; & = Used to combine keys (ctrl+alt = ^&!);



^+WheelUp:: ; Ctrl+Shift+WheelUp to Increase Opacity
    activeGuiTitle := GetActiveGuiTitle()
    if (activeGuiTitle) {
        opacity := guiArray[activeGuiTitle].opacity + 10
        if (opacity > 255) {
            opacity := 255
        }
        guiArray[activeGuiTitle].opacity := opacity
        WinSet, TransColor, 000000 %opacity%, "ahk_id " . guiArray[activeGuiTitle].handle
    }
return

^+WheelDown:: ; Ctrl+Shift+WheelDown to Decrease Opacity
    activeGuiTitle := GetActiveGuiTitle()
    if (activeGuiTitle) {
        opacity := guiArray[activeGuiTitle].opacity - 10
        if (opacity < 0) {
            opacity := 0
        }
        guiArray[activeGuiTitle].opacity := opacity
        WinSet, TransColor, 000000 %opacity%, "ahk_id " . guiArray[activeGuiTitle].handle
    }
return


+t:: ; Shift+t to toggle AlwaysOnTop
    AlwaysOnTop := !AlwaysOnTop
    if (AlwaysOnTop)
        Gui, +AlwaysOnTop
    else
        Gui, -AlwaysOnTop
return


GuiDropFiles:

    activeGuiTitle := GetActiveGuiTitle()
    Picture := A_GuiEvent

    GuiControl,, Pic, *w%width% *h%height% %Picture%
    Gui, Show, NA X%X% Y%Y% AutoSize, % activeGuiTitle

    ; Picture := A_GuiEvent
    ; GuiControl,, Pic, *w%width% *h%height% %Picture%
    ; Gui, Show, NA X%X% Y%Y% AutoSize, % GuiTitle

return

!WheelUp:: ; Alt+WheelUp to Increase Image Size

    activeGuiTitle := GetActiveGuiTitle()
    ; Gui, +LastFound ; Set the last found window to the active GUI
    WinGet, id, ID, A ; Get the window ID of the active GUI
    GuiControlGet, O, Pos, Pic
    NewWidth := Round(Ow * 1.1)
    NewHeight := Round(Oh * 1.1)
    GuiControl, MoveDraw, Pic, w%NewWidth% h%NewHeight%
    WinMove, ahk_id %id%, , , , %NewWidth%, %NewHeight%


    ; GuiControlGet, O, Pos, Pic
    ; NewWidth := Round(OW * 1.1)
    ; NewHeight := Round(OH * 1.1)
    ; GuiControl, MoveDraw, Pic, w%NewWidth% h%NewHeight%
    ; WinMove, % GuiTitle, , , , %NewWidth%, %NewHeight%

return

!WheelDown:: ; Alt+WheelDown to Decrease Image Size

    activeGuiTitle := GetActiveGuiTitle()
    ; Gui, +LastFound ; Set the last found window to the active GUI
    WinGet, id, ID, A ; Get the window ID of the active GUI
    GuiControlGet, O, Pos, Pic
    NewWidth := Round(Ow * 0.9)
    NewHeight := Round(Oh * 0.9)
    GuiControl, MoveDraw, Pic, w%NewWidth% h%NewHeight%
    WinMove, ahk_id %id%, , , , %NewWidth%, %NewHeight%


    ; GuiControlGet, O, Pos, Pic
    ; NewWidth := Round(OW * 0.9)
    ; NewHeight := Round(OH * 0.9)
    ; GuiControl, MoveDraw, Pic, w%NewWidth% h%NewHeight%
    ; WinMove, % GuiTitle, , , , %NewWidth%, %NewHeight%

return



; Helper function to determine which GUI title is currently active:
GetActiveGuiTitle() {
    MouseGetPos,,, id
    MsgBox, % "Mouse is over window handle: " id  ; For debugging
    for title, data in guiArray {
        MsgBox, % "Checking title: " title "`nWith handle: " data.handle  ; For debugging
        if (data.handle = id) {
            MsgBox, % "Found matching GUI title: " title  ; Show immediate feedback
            return title
        }
    }
    MsgBox, No matching GUI title found.  ; Show immediate feedback
    return ""
}


GuiClose:
    Gui, Destroy
    ; Remove GUI from tracking array if needed
    ; guiArray.Delete(GuiTitle)
    ExitApp
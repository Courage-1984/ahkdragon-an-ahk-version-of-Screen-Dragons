### After hours and hours of trying to work it out with the aid of a GAI (multiple ones) this is what I ended with:

> If you need to run multiple instances of the same script and want to share guiArray among them, you will need an alternative method to maintain the state because each script instance runs in its own memory space and does not share variables with other instances.
> 
> One way to handle this is to use an Inter-Process Communication (IPC) method to share data between instances. However, AutoHotkey does not natively support IPC. Instead, you can write the shared data to a file or use the Windows registry as a common data store that all instances can access.
> 
> Here’s a simple example using a file to store the guiArray data:

- When you create a GUI and get its handle, write this information to a file.
- When you need to access guiArray, read the data from the file.

##### Here's how you could modify your script to use a file for storing the GUI handles:

```ahk
; Function to save guiArray to a file
SaveGuiArrayToFile() {
    global guiArray
    FileDelete, guiArray.txt  ; Make sure to start with a fresh file
    for title, data in guiArray {
        FileAppend, %title%:`t%data.handle%:`t%data.opacity%`n, guiArray.txt
    }
}

; Function to load guiArray from a file
LoadGuiArrayFromFile() {
    global guiArray
    guiArray := {}  ; Reset guiArray
    FileRead, guiData, guiArray.txt
    if (ErrorLevel == 0) {
        Loop, Parse, guiData, `n, `r
        {
            if (A_LoopField = "")
                continue
            StringSplit, guiInfo, A_LoopField, `t
            title := guiInfo1
            handle := guiInfo2
            opacity := guiInfo3
            guiArray[title] := {"handle": handle, "opacity": opacity}
        }
    }
}

; Example usage when creating a new GUI
instanceCounter++
GuiTitle := "ahkdragon_" . A_TickCount
LoadGuiArrayFromFile()  ; Load the existing guiArray data
guiArray[GuiTitle] := { "opacity": Opacity }  ; Add new GUI data
; ... create GUI with GuiTitle ...
Gui, Show, NA, % GuiTitle
hwnd := WinExist("A")
guiArray[GuiTitle].handle := hwnd
SaveGuiArrayToFile()  ; Save the updated guiArray data
```

***

### FML:

> Please note that this is a rudimentary IPC method and may not be suitable for high-frequency updates.
> 
> It also does not handle concurrent file access, which can be an issue if multiple instances try to read or write to the file simultaneously.
> 
> For a more robust IPC solution, you might consider using named pipes, TCP/IP, or other IPC mechanisms provided by external libraries or tools.
> 
> However, that would significantly increase the complexity of the script.

**and when I read that, I was just *done*, couldn't care anymore and settled with what I had...**

**[ahkdragon3.ahk](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons/blob/main/multiple%20instance%20attempts/ahkdragon3.ahk)** is the third iteration of my attemps, theres a lot of commented out code and etc. etc.

Dunno, look at it, play with it, whatevs


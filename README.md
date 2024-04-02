# ahkdragon ~ an ahk version of "Screen Dragons"

ahkdragon is an ahk (AutoHotkey) version of Screen Dragons. Inspired by "[Screen Dragons](https://www.majorgeeks.com/files/details/screen_dragons.html)"

***

### Download Windows Application [Here](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons/tree/main/ahkdragon%20windows%20application).
*Download the "`ahkdragon.exe`" file*

### Download the sources files used to build the executable [Here](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons/tree/main/ahkdragon%20source%20files).

*"`ahkdragon.ahk`" is the AutoHotkey script*

*"`ahkdragon_icon.ico`" is the icon used for the executable*

*"`default.png`" is the default image that first shows when running the executable*

*"`compile instructions.md`" is instructions to compile `ahkdragon.ahk` into an executable(`.exe`) using `Ahk2Exe`*

***

## About

**Note:** when running the executable it will only show up in your Windows taskbar, thus if you want to close it, right click the ahkdragon icon in the Windows taskbar > Exit

**Note 2:** when running the executable it will create a file in your `\Documents\` root called `ahkdragon_temp_default.png`. *Unfortunately I currently don't know of a way around this.*

**Note 3:** you are able to run multiple instances of **ahkdragon** but will only be able to use the [Shortcuts](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons?tab=readme-ov-file#shortcuts) on the latest instance. *See [multiple instance attempts](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons?tab=readme-ov-file#multiple-instance-attempts)*

### Shortcuts

- ``Image Drag`` onto the **ahkdragon** while replace the **ahkdragon** with the image you dragged on top of it.
- ``Shift+t`` to toggle AlwaysOnTop. *(Defualt when first running executable is set to AlwaysOnTop)*
- ``Alt+WheelUp`` to Increase Image Size.
- ``Alt+WheelDown`` to Decrease Image Size.
- ``Ctrl+Shift+WheelUp`` to Increase Opacity.
- ``Ctrl+Shift+WheelDown`` to Decrease Opacity.

***

## Preview


***

## Bugs

- [Shortcuts](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons?tab=readme-ov-file#shortcuts) only works on latest instance.
- Sometimes you need to repeat the ``Shift+t`` shortcut to toggle AlwaysOnTop.
- Dragging a new image ontop of **ahkdragon** to replace it: image will load at image `Dimensions` so just be carefull when using high resolution images.
- Not sure what the behavior is on different screen sizes but it should open in the center of your screen with:
```ahk
X := A_ScreenWidth // 2.5
Y := A_ScreenHeight // 7
```
otherwise just change that part in the `ahk` back to:
```ahk
X := 0
Y := 0
```

***

## multiple instance attempts

> this is me documenting and archiving my attempts at trying to implement being ableto run **ahkdragon** on multiple instances while retaining full functionality... *ejoy*

#### [Repo Location](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons/tree/main/multiple%20instance%20attempts)

1. First go read [Here: ahkdragon2 - black background but individual opacity](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons/blob/main/multiple%20instance%20attempts/ahkdragon2%20-%20black%20background%20but%20individual%20opacity.md)
2. Then visit and read [Here: ahkdragon3 - multiple instance issue end result](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons/blob/main/multiple%20instance%20attempts/ahkdragon3%20-%20multiple%20instance%20issue%20end%20result.md)

**Looking for a challenge?**

Read the above attempts and go and try figure out a solution yourself!

*good luck!*

***

### Inspired by: [Screen Dragons](https://www.majorgeeks.com/files/details/screen_dragons.html)

#### [Official Screen Dragons Site](https://screendragons.co.uk/) seems to be down, indicating:

> No Sponsors
> 
  > screendragons.co.uk currently does not have any sponsors for you.

### Download Screen Dragons 2.4.0.7 [Here](https://github.com/Courage-1984/ahkdragon-an-ahk-version-of-Screen-Dragons/tree/main/Screen%20Dragons%202.4.0.7). *(Got contents from majorgeeks)*

*"`screendragons.exe`" is the Windows executable file*

*"`SDReadme.rtf`" is the official Readme provided by "Screen Dragons" for ver `2.4.0.7`*

*"`Screen Dragons 2.4.0.7.zip`" is a `.zip` containing both `screendragons.exe` and `SDReadme.rtf`*

*"`about.md`" is a formatted markdown of the info provided by "majorgeeks" at [Screen Dragons 2.4.0.7](https://www.majorgeeks.com/files/details/screen_dragons.html)*

***


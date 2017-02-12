# Incursion-360-Control-Autohotkey


    ##############################################################################
    # Copyright 2010 Aidan McQuay
    #
    # This work is licenced under the Creative Commons BSD License License. To
    # view a copy of this licence, visit http://creativecommons.org/licenses/BSD/
    # or send a letter to Creative Commons, 171 Second Street, Suite 300,
    # San Francisco, California 94105, USA.
    ##############################################################################

![screenshots](http://img04.deviantart.net/47be/i/2012/069/2/9/incursion__roguelike__game_icon_by_math0ne-d4scw7r.png)

Play Incursion the d20/OSRD based the rougelike with a 360 Gamepad!

This is still a WIP but should be playable. 

This is my favorite roguelike and I made this so I could play extended sessions lounging on my couch on the the TV in maximum comfort. An autohotkey scruipt that remaps controls so the game is playable with a xbox controller.  This includes custom modes and even overlays for complicated menu interactions:

![screenshots](http://i.giphy.com/12LIda8Z0CpBPW.gif)

This script requires autohotkey:

https://autohotkey.com/

And grab my script from here:

https://raw.github.com/openist/Incursion-360-Control-Autohotkey/blob/master/incursion-360.ahk

I will compile a binary and upload it once I have done further play testing.  In order for this to work well some specific options need to be set in incursion:

Necessary Options:
-------------------------
* Limits and Warnings
  * Empty Hand Warning: Never

* Output Options
  * Windowed Mode Window Size: 1920x1080
  * 16x16 Font Size
  * Softer Palette Colors: NO

* Input Options
  * Allow selection jumping: NO
  * Default to Direction Selection: NO
  * Automatically Clear --more--: YES
  * Auto-open Doors: YES
  * Auto-kick Doors: YES

Setup Instructions:
* Desktop has to be set to 1920x1080
* Start incusrion and set necessary options
* Start incustion-gui.exe/.ahk

Here's the Keys:

![screenshots](https://raw.githubusercontent.com/openist/Incursion-360-Control-Autohotkey/master/incursion-360.png)

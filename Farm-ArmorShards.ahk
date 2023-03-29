#NoEnv                          ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
#Warn All, OutputDebug          ; Enable warnings to assist with detecting common errors.
SendMode Input                  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%     ; Ensures a consistent starting directory.
#KeyHistory 100
#InstallKeybdHook
#InstallMouseHook
SetKeyDelay 100                  ;Default is something silly like 10
#Persistent  ; Prevent the script from exiting automatically.


^r::
    if WinExist("Destiny 2")
        WinActivate
    Sleep 500
    SendMessage("fireteam", "Reloading.")
    Reload
    Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
    MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
    IfMsgBox, Yes, Edit
    return

#+x::
    Sleep 500
    SendMessage("fireteam", "Exiting Application.")
    ExitApp

BuyItem(x, y, qty := 9)
{
    WinGetPos , , , w, h, A
    MouseMove , %x%, %y%
    Sleep 1000
    Loop %qty% {
        MouseClick , Left, %x%, %y%, 1, 2, D
        Sleep 3100
        MouseClick , Left, %x%, %y%, 1, 2, U
    	Sleep 500
    }
    Sleep 500
}

ShardItem(x, y, qty := 9)
{
    WinGetPos , , , w, h, A
    MouseMove , %x%, %y%
    Sleep 1000

    x += Round(140 / (2560 / w))
    MouseMove , %x%, %y%
    Sleep 1000
    Loop %qty% {
        MouseMove , %x%, %y%
        Send {f down}
        Sleep 1200
        Send {f up}
        Sleep 1000
    }
    Sleep 500
}

BuyCurrency(x, y, qty := 25)
{
    WinGetPos , , , w, h, A
    MouseMove , %x%, %y%
    Sleep 1000
    Loop %qty% {
        MouseClick , Left, %x%, %y%, 5, 2
        Sleep 500
    }
    Sleep 1000
}

ExitMenus() {
    SendMessage("fireteam", "Exiting menus.")
    SendMessage("fireteam", "Spamming ESC to exit menus...")
    Loop 8 {
        Sleep 1000
        Send {Esc}
    }
    SendMessage("fireteam", "Opening settings and closing, hope this works...")
    Sleep 1000
    Send {F10}
    Sleep 3000
    Send {Esc}
    Sleep 2000
}

SendMessage(command:="fireteam", message:="Boop.") {
    
    command := "/" . command . " "
    
    OutputDebug % A_Now . " [INFO] " . A_LineNumber . " (" . A_ThisFunc . "): Hotkey '" . A_ThisHotkey . "' pressed." 
    OutputDebug % A_Now . "        " . command . message
   
    Send {Enter}
    Sleep 250
    Send %command%
    Sleep 250
    Send %message%
    Sleep 250
    Send {Enter}
    Sleep 250
}

TestChat() {
    SendMessage("fireteam", "And it's away we go{!}")
    SendMessage("fireteam", "[INFO] Last action: " . A_TimeSincePriorHotkey . " ms.")
    Sleep 1000
}

BuyGlimmer() {
    SendMessage("fireteam", "[INFO] Blindly hitting up Rahool for glimmer.")
    WinGetPos , , , w, h, A
    ; Speak to Rahool
    Send {f down}
    Sleep 1200
    Send {f up}
    Sleep 1000
    ; Buy Currency 2 - 10k Glimmer qty. 25
    ; we loop in case of lag.
    SendMessage("fireteam", "[INFO] Currency iteration " . A_Index . ".")
    Loop, 2 {
        ; Buy mats - 1 shard per 5 mats, 20 mats for 10k glimmer
        SendMessage("fireteam", "Buying material 1/4")
        BuyCurrency(Round(1700 / (2560 / w)), Round(261 / (1440 / h)), 15)
        SendMessage("fireteam", "Buying material 2/4")
        BuyCurrency(Round(1825 / (2560 / w)), Round(261 / (1440 / h)), 15)
        SendMessage("fireteam", "Buying material 3/4")
        BuyCurrency(Round(1950 / (2560 / w)), Round(261 / (1440 / h)), 15)
        SendMessage("fireteam", "Buying material 4/4")
        BuyCurrency(Round(2075 / (2560 / w)), Round(261 / (1440 / h)), 15)
        ; Buy Glimmer
        SendMessage("fireteam", "Buying glimmer 1/2")
        BuyCurrency(Round(1425 / (2560 / w)), Round(261 / (1440 / h)), 7)
        SendMessage("fireteam", "Buying glimmer 2/2")
        BuyCurrency(Round(1565 / (2560 / w)), Round(261 / (1440 / h)), 7)
    }
    Sleep 1000
}

BuyArmorSets() {
    SendMessage("fireteam", "Buying...")
    WinGetPos , , , w, h, A
    ; Open Collections tab
    Send p
    Sleep 2000
    MouseMove, Round(1340 / (2560 / w)), Round(100 / (1440 / h))
    Sleep 1000
    MouseClick , Left, % Round(1340 / (2560 / w)), % Round(100 / (1440 / h)), 10
    ; Open Armor menu
    Sleep 1000
    MouseMove, Round(1100 / (2560 / w)), Round(450 / (1440 / h))
    Sleep 1000
    MouseClick , Left, % Round(1100 / (2560 / w)), % Round(450 / (1440 / h)), 10
    ; Open Leveling tab
    Sleep 1000
    MouseMove, Round(300 / (2560 / w)), Round(1100 / (1440 / h))
    Sleep 1000
    MouseClick , Left, % Round(300 / (2560 / w)), % Round(1100 / (1440 / h)), 10
    ; Open second page
    Sleep 1000
    MouseMove, Round(2400 / (2560 / w)), Round(1100 / (1440 / h))
    Sleep 1000
    MouseClick , Left, % Round(2400 / (2560 / w)), % Round(1100 / (1440 / h)), 10
    Sleep 1000
    ; Buy Helms
    BuyItem(Round(975 / (2560 / w)), Round(1175 / (1440 / h)), 9)
    ; Buy Gloves
    BuyItem(Round(1100 / (2560 / w)), Round(1175 / (1440 / h)), 9)
    ; Buy Chests
    BuyItem(Round(1250 / (2560 / w)), Round(1175 / (1440 / h)), 9)
    ; Buy Legs
    BuyItem(Round(1375 / (2560 / w)), Round(1175 / (1440 / h)), 9)
    ; Buy Class Items
    BuyItem(Round(1525 / (2560 / w)), Round(1175 / (1440 / h)), 9)
    Sleep 1000
}

ShardArmorSets() {
    SendMessage("fireteam", "... and sharding.")
    WinGetPos , , , w, h, A
    ; Open Character Page
    Send i
    Sleep 3000
    ; Shard Helms
    ShardItem(Round(1875 / (2560 / w)), Round(350 / (1440 / h)), 9)
    ; Shard Gloves
    ShardItem(Round(1875 / (2560 / w)), Round(525 / (1440 / h)), 9)
    ; Shard Chests
    ShardItem(Round(1875 / (2560 / w)), Round(675 / (1440 / h)), 9)
    ; Shard Legs
    ShardItem(Round(1875 / (2560 / w)), Round(850 / (1440 / h)), 9)
    ; Shard Class Items
    ShardItem(Round(1875 / (2560 / w)), Round(1025 / (1440 / h)), 9)
    Sleep 1000
}

#IfWinActive ahk_exe Destiny2.exe   ;Only use the following if True!y
^2:: 
    ExitMenus()
    BuyGlimmer()
    Return
^3::
    ExitMenus()
    BuyArmorSets()
    Return
^5::  
    ExitMenus()
    ShardArmorSets()
    Return
^6::  
    TestChat()
    Return
^7::
    Loop {
        SendMessage("fireteam", "[INFO] Overall iteration " . A_Index . ".")
        ExitMenus()
        BuyGlimmer()
        Loop, 5 {
            SendMessage("fireteam", "[INFO] Armor farm iteration " . A_Index . ".")
            BuyArmorSets()
            ShardArmorSets()
        }
    }
    Return

^8::
    ExitMenus()
    Return

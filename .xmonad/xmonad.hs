import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ICCCMFocus
import XMonad.StackSet hiding (workspaces)
import XMonad.Actions.SpawnOn
import XMonad.Actions.CopyWindow
import XMonad.Actions.GridSelect
import XMonad.Prompt
import XMonad.Prompt.Man
import XMonad.Prompt.RunOrRaise
import Data.List
import Data.Monoid
import Control.Concurrent
import Data.Ratio ((%))

myModMask = mod1Mask  -- rebind Mod to Super key
myTerminal = "xterm"
myTerminalBig = "xterm -fs 20"
myBorderWidth = 2
myWorkspaces = ["1:web", "2:irc", "3:terms", "4:term", "5:code", "6:dev", "7:misc", "8:music", "9:vbox"]

myLayoutHook = onWorkspace "1:web" webLayout $ onWorkspace "2:irc" noTitleLayout $ onWorkspace "3:terms" noTitleLayout $ onWorkspace "4:term" fullLayout $ onWorkspace "9:vbox" fullLayout $ layouts
    where layouts = smartBorders $ avoidStruts $ (layoutHook defaultConfig ||| Grid ||| ThreeCol 1 (3/100) (1/2))
          webLayout = smartBorders $ avoidStruts (Tall 1 (3/100) (70/100) ||| Full)
          fullLayout = smartBorders $ noBorders Full
          noTitleLayout = smartBorders $ avoidStruts (Tall 1 (3/100) (1/2))

myManageHook = (composeAll . concat $
    [[isFullscreen              --> doFullFloat
    , className =? "Xmessage"   --> doCenterFloat
    , className =? "XCalc"      --> doCenterFloat
    , className =? "Zenity"     --> doCenterFloat
    , className =? "feh"        --> doCenterFloat
    , className =? "VirtualBox" --> doShift "9:vbox"
    , className =? "banshee"    --> doShift "8:music"
    , className =? "Banshee"    --> doShift "8:music"
    , className =? "banshee-1"  --> doShift "8:music"
    , className =? "Xfce4-notifyd" --> doIgnore -- Fixes notification bubbles grabbing focus
    , title     =? "Save As..." --> doCenterFloat
    , title     =? "Save File"  --> doCenterFloat
    , title     =? "xterm_2"  --> doShift "2:irc"
    , title     =? "xterm_3"  --> doShift "3:terms"
    , title     =? "xterm_4"  --> doShift "4:term"
    , title     =? "xterm_5"  --> doShift "5:code"
    , title     =? "xterm_8"  --> doShift "8:music"
    ]]) <+> myFloats <+> manageDocks <+> manageHook defaultConfig

myFloats = composeAll . concat $
    [ [ fmap (c `isInfixOf`) className       --> doFloat | c <- myFloats ]
    , [ fmap (t `isInfixOf`) title           --> doFloat | t <- myOtherFloats ]
    ]
    where
        myFloats        = ["TopLevelShell", "Blender:Render", "gimp", "Gimp"]
        myOtherFloats   = ["Scope", "Editor", "Simulink Library Browser", "Figure ", "Blender:Render", "Chess"]

myLogHook xmproc = dynamicLogWithPP $ xmobarPP {
                     ppOutput = hPutStrLn xmproc
                   , ppTitle = xmobarColor lightTextColor ""
                   , ppCurrent = xmobarColor focusColor ""
                   , ppVisible = xmobarColor lightTextColor ""
                   , ppHiddenNoWindows = xmobarColor lightBackgroundColor ""
                   , ppUrgent = xmobarColor myUrgentColor ""
                   , ppSep = " :: "
                   , ppWsSep = " "
                   }

focusColor = "#7878E3"
textColor = "#0A34BF"
lightTextColor = "#8686D1"
backgroundColor = "#5071DE"
lightBackgroundColor = "#241D40"
myUrgentColor = "#ffc000"
myFocusedBorderColor = "#FF0000"

myKeys =
    [ ((myModMask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
    , ((controlMask, xK_Print), spawn "scrot -s")
    , ((0, xK_Print), spawn "scrot")
    , ((myModMask .|. shiftMask, xK_s), sendMessage ToggleStruts)
    , ((myModMask .|. shiftMask, xK_p), startupPrograms)
    , ((myModMask .|. shiftMask, xK_f), fullFloatFocused)
    , ((myModMask, xK_p), spawn "exe=`dmenu_path | dmenu  -i -fn \'-*-fixed-*-*-*-20-*-*-*-*-*-iso8859-15\'` && eval \"exec $exe\"")
    , ((myModMask .|. shiftMask, xK_t), spawn myTerminalBig)
    , ((myModMask .|. shiftMask, xK_b), spawn "ncmpcpp-status")
    , ((myModMask .|. shiftMask, xK_n), spawn "ncmpcpp pause")
    , ((myModMask .|. shiftMask, xK_m), spawn "ncmpcpp play")
    , ((myModMask .|. shiftMask, xK_comma), spawn "ncmpcpp prev")
    , ((myModMask .|. shiftMask, xK_period), spawn "ncmpcpp next")
    , ((myModMask .|. controlMask, xK_x), runOrRaisePrompt myXPConfig)
    , ((myModMask, xK_F1), manPrompt myXPConfig)
    , ((myModMask, xK_u), goToSelected defaultGSConfig)
    , ((myModMask, xK_s), spawnSelected defaultGSConfig ["xterm", "gvim", "firefox"])
    , ((0, 0x1008FF11), spawn "amixer set Master 2- && notify-send Volume 'Lower volume'") -- XF86XK_AudioLowerVolume
    , ((0, 0x1008FF13), spawn "amixer set Master 2+ && notify-send Volume 'Raise volume'") -- XF86XK_AudioRaiseVolume
    , ((0, 0x1008FF12), spawn "amixer set Master toggle && amixer set PCM unmute && notify-send Volume 'Toggle mute'") -- XF86XK_AudioMute
    ]

myXPConfig = defaultXPConfig {
      font = "xft: inconsolata-14"
    , position = Top
    , promptBorderWidth = 0
}

startupPrograms = do
                  spawn (myTerminal ++ " -title xterm_2")
                  spawn (myTerminal ++ " -title xterm_3")
                  spawn (myTerminal ++ " -title xterm_3")
                  spawn (myTerminal ++ " -title xterm_4")
                  spawn (myTerminal ++ " -title xterm_5")
                  spawn (myTerminal ++ " -title xterm_8")
                  spawn (myTerminal ++ " -title xterm_8")
                  spawn "gnome-gmail-notifier"
                  spawn "pidgin"
                  spawnOn "1:web" "firefox"

main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar"
  xmonad $ defaultConfig {
               terminal = myTerminal
             , manageHook = myManageHook
             , layoutHook = myLayoutHook
             , borderWidth = myBorderWidth
             , focusedBorderColor = myFocusedBorderColor
             , modMask = myModMask
             , logHook = myLogHook xmproc >> ewmhDesktopsLogHook >> setWMName "LG3D" >> takeTopFocus
             --, startupHook = setWMName "LG3D" -- Fix Java programs
             , workspaces = myWorkspaces
             } `additionalKeys` myKeys

fullFloatFocused =
    withFocused $ \f -> windows =<< appEndo `fmap` runQuery doFullFloat f

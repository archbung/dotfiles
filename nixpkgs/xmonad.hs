module Main where

import           XMonad
import           XMonad.Actions.UpdatePointer
import           XMonad.Hooks.DynamicLog
import qualified XMonad.Hooks.EwmhDesktops    as Ewmh
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName
import           XMonad.Layout.Fullscreen
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Spiral
import           XMonad.Layout.ThreeColumns
import           XMonad.Util.EZConfig


main :: IO ()
main  = xmonad =<< xmobar (Ewmh.ewmh def
  { terminal    = myTerminal
  , modMask     = mod4Mask
  , borderWidth = 2
  , normalBorderColor   = "#555753"
  , focusedBorderColor  = "#93d44f"
  , manageHook  = composeAll
        [ manageHook def
        , role =? "browser"     --> doShift "2"
        , role =? "pop-up"      --> doFloat
        , appName =? "Steam"    --> doShift "9"
        , appName =? "zenity"   --> doFloat
        , appName =? "Emacs"    --> doShift "1"
        , fullscreenManageHook
        ]
  , layoutHook  = let full = noBorders (fullscreenFull Full)
                      tall = Tall 1 (3/100) (1/2)
                      threeCol = ThreeCol 1 (3/100) (1/2)
                   in onWorkspace "9" full . smartBorders . avoidStruts $
                       tall ||| Mirror tall ||| threeCol ||| spiral (6/7) ||| full
  , logHook     = dynamicLogWithPP def >> updatePointer (0.75, 0.75) (0.75, 0.75)
  , handleEventHook = mconcat
        [ handleEventHook def
        , fullscreenEventHook
        ]
  , startupHook = setWMName "LG3D"
  }
  `additionalKeysP`
  [ ("M-p",                     spawn menu)
  , ("M-q",                     spawn "xmonad --restart")
  , ("M-S-l",                   spawn "i3lock -c 000000")
  , ("<XF86AudioMute>",         spawn "pulsemixer --toggle-mute")
  , ("<XF86AudioRaiseVolume>",  spawn "pulsemixer --change-volume +5")
  , ("<XF86AudioLowerVolume>",  spawn "pulsemixer --change-volume -5")
  , ("<XF86MonBrightnessUp>",   spawn "light -A 5")
  , ("<XF86MonBrightnessDown>", spawn "light -U 5")
  ])

    where
        role = stringProperty "WM_WINDOW_ROLE"
        menu = "rofi -show run -modi run -columns 9"
        myTerminal = "kitty"

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

main = xmonad =<< xmobar myConfig

myConfig = desktopConfig
    { terminal = "urxvt"
    , modMask = mod4Mask
    , focusedBorderColor = "#236ea3"
    , workspaces = ["1:term", "2:code", "3:web", "4:spotify", "5:tex"] ++ map show [6..9]
    } `additionalKeysP` myKeys


myKeys =
    [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
         | (key, scr)  <- zip "wer" [1,0,2] -- was [0..] *** change to match your screen order ***
         , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ]


import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig (additionalKeys, removeKeys)
import XMonad.Prompt
import XMonad.Prompt.Shell
import Graphics.X11.ExtraTypes.XF86


import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog


import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Spacing (spacing)

opConfig = defaultConfig
  { terminal            = "gnome-terminal"
  , normalBorderColor   = "grey"
  , focusedBorderColor  = "#336600"
  , modMask             = mod4Mask
  , borderWidth         = 3
  , layoutHook = opLayoutHook
  , startupHook = opStartUp
  } `additionalKeys` extraKeys

opLayoutHook = spacing 0
               $ avoidStruts
--             $ tabBarDeco shrinkText defaultTheme
               $ layoutHook defaultConfig


opStartUp = do
  -- spawn "~/.xmonad/utils/screen.sh"
  -- set keyboard layout (kbbd for per window layout management)
  spawn "kbdd"
  spawn "setxkbmap us,ua -option grp:switch,grp:ctrl_shift_toggle"
  -- set up trayer
  -- spawn "stalonetray -c ~/.xmonad/panels/stalonetrayrc"
  -- set background image (to change image just copy it with the new
  -- name 'wallpaper' in decorations folder)
  -- spawn "feh --bg-scale ~/.xmonad/decorations/wallpaper"
  -- clean config directory
  spawn "cd ~/.xmonad && rm xmonad.hi xmonad.errors xmonad.o"


extraKeys =
  [ ((mod4Mask, xK_q), spawn $ "if type xmonad; " ++
                       "then killall conky dzen2 xmobar stalonetray;" ++
                       "xmonad --recompile && xmonad --restart;" ++
                       "else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
  , ((0, xF86XK_AudioLowerVolume), spawn "amixer set 'Master' 1%-")
  , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set 'Master' 1%+")
  , ((0, xF86XK_AudioMute), spawn "amixer -D pulse set 'Master' toggle")
  , ((0, xK_Print), spawn "scrot -m -e 'mv $f ~/Pictures/'")
  , ((mod4Mask, xK_Print), spawn "scrot -u -e 'mv $f ~/Pictures/'")
  , ((mod4Mask .|. shiftMask, xK_l), spawn "slock")
  ]


main = xmonad opConfig

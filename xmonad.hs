-- import XMonad
-- import XMonad.Core
import XMonad hiding ( (|||) )
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Tabbed
import XMonad.Layout.OneBig
import XMonad.Actions.CycleWS
-- import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Actions.SpawnOn
import XMonad.Layout.CenteredMaster
-- import XMonad.Layout.Tabbed
import XMonad.Layout.Accordion
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
-- import XMonad.Layout.Master
import XMonad.Layout.Cross
import XMonad.Layout.Circle
-- http://crunchbang.org/forums/viewtopic.php?id=9965&p=2
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances -- allows fullscreen toggle, without Full layout
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.CopyWindow (copy)
import XMonad.Actions.Submap -- allows emacs-like keys
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.BoringWindows
-- import XMonad.Layout.DwmStyle
-- import XMonad.Layout.LayoutModifier
-- import XMonad.Layout.Minimize
-- import XMonad.Layout.Maximize
-- import XMonad.Layout
-- import XMonad.Layout.Gaps -- !!!!!!!!!!!!!!
import XMonad.Layout.Spacing -- !!!!!!!!!!!!!
-- import XMonad.Layout.LayoutModifier
import XMonad.Hooks.ManageHelpers
-- import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

main :: IO ()
main =
  xmonad =<< xmobar defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    , focusedBorderColor = "#0000B0"
    , normalBorderColor = "#000000"
    , borderWidth = 2
    , workspaces = myWorkspaces
    , startupHook = myStartupHook
    , layoutHook = myLayoutHook
    , manageHook =  myManageHooks
    , keys = myKeys <+> keys defaultConfig
    }

-- colors: #000000 #002800 #380000 #780000 #980000 #000038 #0000B0 #FF0000

myWorkspaces :: [String]
myWorkspaces = [ "cmd"
               , "dev"
               , "web"
               , "pdf"
               , "mail"
               , "6"
               , "7"
               , "8"
               , "9"
                 ]
myKeys c = mkKeymap c $
--myKeys = \c -> mkKeymap c $
   [ ("M-S-<Return>", spawn $ XMonad.terminal c) ,
--     ("M-S f", spawn "firefox") ,
--     ("M-S e", spawn "emacs") ,
--     ("M-S p", spawn "evince") ,
     ("M-f", sendMessage $ Toggle FULL) ,
     ("M-q", spawn "xmonad --recompile && xmonad --restart") ,
     ("M-p", spawn "dmenu_run") ,
     ("M-e", spawn "emacsclient -c") ,
     ("M-t", spawn "transset .85")
   ]
--   ++
--   zip (map (\x -> fst x++[snd x]) ((zip (repeat "M-") (['1'..'9'])))) (map (withNthWorkspace W.greedyView) [0..])
--   ++
--   zip (map (\x -> fst x++[snd x]) ((zip (repeat "M-S-") (['1'..'9'])))) (map (withNthWorkspace W.shift) [0..])


-- myManageHooks :: Query (Endo WindowSet)
myManageHooks = composeAll
 --Allows focusing other monitors without killing the fullscreen
  [ isFullscreen --> (doF W.focusDown <+> doFullFloat) ]

myStartupHook :: X ()
myStartupHook = do
  spawnOn "cmd" "xcompmgr &"
  spawnOn "cmd" "gnome-settings-daemon &"
  --spawnOn "cmd" "sudo modprobe -r pcspkr snd_pcsp"
  spawnOn "cmd" "feh --bg-scale /home/prim3/Bilder/wallpaper/miyakejima.jpg &"
  spawnOn "cmd" "xset b off"
  spawnOn "cmd" "emacs --daemon"
  spawnOn "cmd" "mpd --no-daemon --stdout --verbose &"

myLayoutHook =  smartBorders $ windowNavigation $ subTabbed $ boringWindows $ mkToggle (NOBORDERS ?? FULL ?? EOT) (spacing 5 tiled ||| spacing 15 Grid ||| noBorders Full |||  Accordion ||| Circle ||| centerMaster Grid ||| simpleCross)
  where
                tiled = Tall nmaster delta ratio
                nmaster = 1
                ratio = toRational (2/(1+sqrt 5::Double))
                delta = 0.05

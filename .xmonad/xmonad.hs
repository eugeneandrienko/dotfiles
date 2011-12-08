import XMonad
import XMonad.Actions.UpdatePointer
import XMonad.Actions.FloatKeys
import XMonad.Layout.NoBorders
import XMonad.Layout.CenteredMaster
import XMonad.Layout.Named
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import Data.List
import Data.Monoid
import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- My terminal emulator
myTerminal      = "urxvt"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
myWorkspaces    = ["term","web","doc","dev"] ++ map show [5..9]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#3f3f3f"

defaultsXP = defaultXPConfig {
    bgColor = "#3f3f3f",
    fgColor = "#dddddd",
    fgHLight = "#3f3f3f",
    bgHLight = "#dddddd",
    borderColor = "#bbbbbb",
    font = "-*-terminus-medium-*-*-*-12-*-*-*-*-*-*-u"
}

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    --launch run bar
    , ((modm,               xK_p     ), shellPrompt defaultsXP)

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

    --show trayer
    --, ((modm .|. shiftMask, xK_t     ),

    -- show scratchpad
    , ((modm,               xK_s     ), scratchpadSpawnActionTerminal "urxvt")

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Resize windows
    , ((modm              , xK_comma ), withFocused (keysResizeWindow (-10, -10) (0, 0)))
    , ((modm              , xK_period), withFocused (keysResizeWindow (10, 10) (0, 0)))
      
    -- Move windows
    , ((modm              , xK_Up    ), withFocused (keysMoveWindow (0, -10)))
    , ((modm              , xK_Down  ), withFocused (keysMoveWindow (0, 10)))
    , ((modm              , xK_Right ), withFocused (keysMoveWindow (10, 0)))
    , ((modm              , xK_Left  ), withFocused (keysMoveWindow (-10, 0)))

    -- Toggle the status bar gap
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    -- Start my dmenu
    --, ((modm              , xK_o     ), spawn "/home/drag0n/bin/goodmenu/goodmenu.sh")]

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{z,x,c}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{z,x,c}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_z, xK_x, xK_v] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------

-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = (named "center" $ centerMaster $ tiled) ||| (named "tiled" $ tiled) ||| (named "mtiled" $ Mirror $ tiled) ||| (named "full" $ Full)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 2/3
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Xmessage"       --> doFloat
    , className =? "Dialog"         --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "URxvt"          --> moveTo "term"
    , className =? "Chromium-browser"       --> moveTo "web"
    , className =? "Apvlv"          --> moveTo "doc"
    , className =? "Evince"         --> moveTo "doc"
    -- 2fullscreen flashplayer
    , title     =? "<unknown>"      --> doFullFloat
    , title     =? "exe"            --> doFullFloat
    ]
     where moveTo = doF . W.shift

------------------------------------------------------------------------
-- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
myLogHook = fadeInactiveLogHook 0xcccccccc >> updatePointer (Relative 0.5 0.5)

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
main = do
xmproc <- spawnPipe "xmobar"
xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        mouseBindings      = myMouseBindings,
        layoutHook         = avoidStruts $ smartBorders $ myLayout,
        manageHook         = manageDocks <+> myManageHook <+> scratchpadManageHook (W.RationalRect 0.2 0.7 0.6 0.3),
        handleEventHook    = myEventHook,
        logHook            = myLogHook >> dynamicLogWithPP xmobarPP
                                   { ppOutput = System.IO.hPutStrLn xmproc
                                   , ppTitle = xmobarColor "gray" "" . shorten 60
                                   , ppSep = " | "
                                   , ppCurrent = xmobarColor "black" "gray"
                                   , ppUrgent = xmobarColor "black" "red" . xmobarStrip
                                   },
        startupHook        = myStartupHook
    }


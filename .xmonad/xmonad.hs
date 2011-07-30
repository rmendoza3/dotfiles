import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Layout.PerWorkspace (onWorkspace)
import System.IO
import qualified Data.Map as M

-- Main
main = do
	xmproc <- spawnPipe "xmobar ~/.xmobarrc"
	xmonad $ defaultConfig
		{ workspaces = ["1:dev","2:web","3","4","5","6","7","8","9:mail"]
		, manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
		, layoutHook = myLayoutHook
		, logHook = dynamicLogWithPP $ xmobarPP
			{ ppOutput = hPutStrLn xmproc
			, ppSep = " :: "
			, ppTitle = xmobarColor "#429942" "" . wrap "[" "]" . shorten 40
			}
		, terminal = "urxvt"
		, focusFollowsMouse = False
		, keys = \c -> myKeys c `M.union` keys defaultConfig c
		} 


-- http://www.haskell.org/haskellwiki/Xmonad/Key_codes
myKeys (XConfig {modMask = modm}) = M.fromList $ [
	-- Media Keys
		-- 0 toggles, 5 stops.
		((controlMask, xK_KP_Insert), spawn "mpc toggle"),
		((controlMask, xK_KP_Begin), spawn "mpc stop"),

		-- 1 goes back, 3 does forward.
		-- Jump up to 4 and 6 to skip.
		-- Jump up to 7 and 9 to skip and consume.
		((controlMask, xK_KP_End), spawn "mpc seek -1%"),
		((controlMask, xK_KP_Page_Down), spawn "mpc seek +1%"),

		((controlMask, xK_KP_Left), spawn "mpc prev"),
		((controlMask, xK_KP_Right), spawn "mpc next"),

		((controlMask, xK_KP_Home), spawn "mpc consume on && mpc prev && mpc consume off"),
		((controlMask, xK_KP_Page_Up), spawn "mpc consume on && mpc next && mpc consume off"),

		-- Period mutes, 2 lowers, 8 raises.
		((controlMask, xK_KP_Delete), spawn "amixer sset Master,0 toggle"),
		((controlMask, xK_KP_Down), spawn "amixer sset Master,0 1-"),
		((controlMask, xK_KP_Up), spawn "amixer sset Master,0 1+"),

	--pianobar
		((modm, xK_KP_Add), spawn "~/.config/pianobar/scripts/love"),
		((modm, xK_KP_Subtract), spawn "~/.config/pianobar/scripts/ban"),
		((modm, xK_p), spawn "~/.config/pianobar/scripts/pause"),
		((modm, xK_n), spawn "~/.config/pianobar/scripts/next"),

	-- CtrlSpace fbrun
		((controlMask, xK_space), spawn "fbrun"),

	-- CtrlAltP start pianobar
		((controlMask .|. modm, xK_a), spawn "pianobar"),

	-- CtrlAltp start pianobar
		((controlMask .|. modm, xK_q), spawn "pkill pianobar"),

	-- CtrlAltf play fancy
		((controlMask .|. modm, xK_f), spawn "mpg123 ~/fancy.mp3"),

	-- CrtlAltr play ryans band songs
		((controlMask .|. modm, xK_r), spawn "mpg123 ~/music/The Architecture/The Architecture - Delusional Creatures.mp3"),
		((controlMask .|. modm, xK_t), spawn "mpg123 ~/music/The Architecture/The Architecture - Julie Andrews.mp3")
	]

myManageHook = composeAll
	[ className =? "Xmessage"		--> doFloat
	, className =? "Google-chrome"	--> doShift "2:web"
	, className =? "Firefox"		--> doShift "2:web"
	, className =? "Thunderbird"	--> doShift "9:mail"
	]

myLayoutHook = onWorkspace "2:web" full $ standard
	where
		standard = avoidStruts $ (tiled ||| Mirror tiled ||| Full)
		full = avoidStruts $ Full
		tiled = Tall nmaster delta ratio
		nmaster = 1
		ratio = 1/2
		delta = 3/100

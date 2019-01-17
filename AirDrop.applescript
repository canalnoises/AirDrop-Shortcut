use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

-- This script brings up the AirDrop dialog for the selected file(s) in Finder (window or desktop)
-- Isaac Nelson 17 Jan 2018
-- Vastly improved by implementing Aviral Bansal's fix for UI scripting slowness: https://stackoverflow.com/a/36370637/9278116


tell application "Finder"
	set sel to get the selection
	
	if (sel is {}) then
		log "Nothing selected! Can't proceed"
		return
	end if
	
end tell

set parentPath to (container of item 1 of sel as string)
set desktopPath to (path to desktop folder as string)

if desktopPath is equal to parentPath then tell application "Finder" to reveal sel


tell application "System Events"
	tell process "Finder"
		set shareButton to (first button whose description is "Share") of toolbar 1 of window 1
		ignoring application responses
			click shareButton
			delay 0.1
		end ignoring
	end tell
end tell

do shell script "killall System\\ Events"

tell application "System Events"
	click (menu item "AirDrop") of menu 1 of shareButton
end tell


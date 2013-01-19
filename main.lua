--[[ 
	This example diplays the latest event name and phase in the center of the screen.
]]

OUYA = require "OUYA"

output = display.newText("Press a button.",0,140, native.systemFont, 16)
output.x = 240

function HandleButton( event )
	output.text = event.name .. " : " .. event.phase
end

OUYA.bind('O', HandleButton)
OUYA.bind('U', HandleButton)
OUYA.bind('A', HandleButton)
OUYA.bind('left', HandleButton)
OUYA.bind('right', HandleButton)
OUYA.bind('up', HandleButton)
OUYA.bind('down', HandleButton)

-- Use unbind to unbind a button, only used if you don't want to use that button anymore.
-- Calling OUYA.bind again for a button will overwrite the last listener.
-- OUYA.unbind('O')

-- Use unbindAll between scenes to reset the mapping
--	OUYA.unbindAll()
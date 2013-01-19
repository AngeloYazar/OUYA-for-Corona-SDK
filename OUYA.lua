--[[
Limited mapping to the OUYA controller for Corona SDK
By Angelo Yazar

Without Enterprise, you are limited to one controller and these bindings:

-- These map to the buttons of the same name.
'O'
'U'
'A'
-- These map to the directions of the D-pad and the left stick. 
'right', 
'left', 
'up', 
'down'

The listeners will be sent an event in the usual Corona style,
and the possible phases are 'up' and 'down'.

For example:
function Jump( event )
	if event.phase == "up" then
		-- Jump or something
	end
end

OUYA.bind('O',Jump)

Please note that if you bind the 'A' button, it will stop acting like a back button.
Unbind it or return false from your listener to use the default behaviour.
]]

local OUYA = {}
local buttonListeners = {}
local buttonMap = {
	O = "center",
	U = "menu",
--	Y = "not mapped",
	A = "back",
}
local keyMap = {
	center = 'O',
	menu = 'U',
	back = 'A',
}

function OUYA.bind(buttonName, listener)
	buttonName = buttonMap[buttonName] or buttonName
	buttonListeners[buttonName] = listener
end

function OUYA.unbind(buttonName)
	OUYA.bind(buttonName, nil)
end

function OUYA.unbindAll()
	for keyName in pairs( buttonListeners ) do
		buttonListeners[keyName] = nil
	end
end

function OUYA.invokeButtonListener(keyName, phase)
	if buttonListeners[keyName] then
		return buttonListeners[keyName]{
			name = keyMap[keyName] or keyName,
			phase = phase,
		}
	end
end

local function onKeyEvent( event )
	local result = OUYA.invokeButtonListener( event.keyName, event.phase )

	if event.keyName == "back" and buttonListeners["back"] then
		return result ~= false
	end
	return false
end
Runtime:addEventListener("key", onKeyEvent)

return OUYA
--!strict
--!optimize 2

local Types = require(script.Parent.Types)

local EventListener = {}
EventListener.__index = EventListener

function EventListener.new(
	targetObject: GuiObject,
	eventName: string,
	handler: (...any) -> ()
): Types.EventListener
	assert(targetObject[eventName], "[Tailblox.EventListener]: Event '" .. eventName .. "' does not exist on the target object.")

	local connection: RBXScriptConnection
	local self = setmetatable({}, EventListener) :: Types.EventListener

	self.eventName = eventName
	self.handler = handler
	self.targetObject = targetObject

	connection = targetObject[eventName]:Connect(function(...)
		local args = ...
		task.spawn(function()
			handler(args)
		end)
	end)

	-- Disconnect function to clean up the event listener
	function self:disconnect()
		if connection.Connected then
			connection:Disconnect()
		end
	end

	return self
end

return EventListener

--!strict
--!optimize 2

local Types = require(script.Parent.Types)
local EventListener = require(script.Parent.EventListener)

local SchemeHandler = {} :: {new: (props: {[string]: any}) -> Types.Scheme}

SchemeHandler.new = function(props: {[string]: any}): Types.Scheme
	local self = {} :: Types.Scheme
	self._scheme = props
	self._runningTasks = {}
	self._boundListeners = {} -- Table to track bound event listeners

	-- Applies all properties and EventListeners in the scheme to the target object
	self.apply = function(targetObject: GuiObject): ()
		task.spawn(function()
			for k: string, v: any in pairs(self._scheme) do
				-- Skip functions that aren't EventListeners
				if typeof(v) == "function" then continue end

				-- Handle EventListeners
				if typeof(v) == "table" and v.eventName and v.handler then
					-- Check if the event is already bound
					if self._boundListeners[v.eventName] then continue end

					local success, err = pcall(function()
						local eventListener = EventListener.new(targetObject, v.eventName, v.handler)
						self._boundListeners[v.eventName] = eventListener
					end)
					if not success then
						warn("[Tailblox.SchemeHandler.new]: Failed to bind event listener: " .. v.eventName .. " - " .. tostring(err))
					end
					continue
				end

				-- Apply properties if the target object has them
				if targetObject:IsA("GuiObject") and targetObject[k] ~= nil then
					local success, err = pcall(function()
						targetObject[k] = v
					end)
					if not success then
						warn("[Tailblox.SchemeHandler.new]: Failed to apply property: " .. tostring(k) .. " - " .. tostring(err))
					end
				end
			end
		end)
	end

	-- Runs a function defined in the scheme
	self.run = function(functionName: string, optionalArguments: any?): ()
		local func = self._scheme[functionName]
		if not func then return end
		if typeof(func) == "function" then
			local taskThread = task.spawn(function()
				func(optionalArguments)
			end)
			table.insert(self._runningTasks, taskThread)
		else
			warn("[Tailblox.SchemeHandler.run]: No function named '" .. functionName .. "' in the scheme.")
		end
		return
	end

	return self
end

return SchemeHandler

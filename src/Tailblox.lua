--!nocheck

-- Types
export type Theme = {
	_scheme: {[string]: any},
	apply: (targetObject: GuiObject) -> (),
	run: (self: Theme, functionName: string, optionalArguments: any) -> (),
	_runningTasks: {[number]: thread},
}

return function(scheme: {[string]: any}): Theme

	local self = {}
	self._scheme = scheme
	self._runningTasks = {}

	function self:apply(targetObject: GuiObject) -- YOU MUST RUN THE FUNCTION WITH A COLON OTHERWISE IT WILL BREAK AT RUNTIME
		-- Applies all properties in the theme class to the target object
		task.spawn(function()
			for k, v in pairs(self._scheme) do
				if self._isPaused then return end -- If paused, stop applying

				-- Skip functions
				if typeof(v) == "function" then continue end

				-- Apply properties if the target object has them
				if targetObject:IsA("GuiObject") and targetObject[k] ~= nil then
					local success, err = pcall(function()
						targetObject[k] = v
					end)
					if not success then
						warn("[TAILBLOX]: Failed to apply property: " .. tostring(k) .. " - " .. tostring(err))
					end
				end
			end
		end)
	end

	function self:run(functionName: string, optionalArguments: any?)
		local func = self._scheme[functionName]
		if not func then return end
		if typeof(func) == "function" then
			local taskThread = task.spawn(function()
				if self._isPaused then return end
				-- Call the function, passing any optional arguments
				func(table.pack(optionalArguments) or nil)
			end)
			table.insert(self._runningTasks, taskThread)
		else
			warn("[TAILBLOX]: No function named '" .. functionName .. "' in the scheme.")
		end
	end


	return self :: Theme
end

local Tailblox = require(game:GetService("ReplicatedStorage"):WaitForChild("Tailblox"))
local Scheme, EventListener = Tailblox.Scheme, Tailblox.EventListener

-- Create a new scheme
local myscheme = Scheme.new({
	BackgroundColor3 = Color3.fromRGB(14, 14, 14),

	-- Properly define the EventListener in the scheme
	MouseButton1ClickListener = EventListener.new(script.Parent, "MouseButton1Click", function(...)
		print("MouseButton1Click fired with arguments:", ...)
	end),
})

-- Apply the scheme after a brief delay
if script.Parent:IsA("GuiObject") then
	task.wait(3)
	myscheme.apply(script.Parent)
end

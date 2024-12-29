# **Tailblox**

> **Custom Theme Styles with Theme Functions!**  
Tailblox allows you to create and apply reusable, customizable GUI themes with ease. Define theme properties, add functions, and use them seamlessly in your Roblox games.

---

## **Getting Started**  

### **Step 1: Require the Tailblox Module**  
The first step is to require the `Tailblox` module in your game. It works anywhere within your project.  

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tailblox = require(ReplicatedStorage.Tailblox)
```

---

### **Step 2: Create Your Custom Theme**  
Create a theme by passing a table to the `Tailblox` function. This table should define the theme's properties and optional functions for advanced customization.  

```lua
local myTheme = Tailblox({
    -- Theme Properties
    BackgroundColor3 = Color3.fromRGB(16, 16, 16), -- Background color
    BorderColor3 = Color3.fromRGB(255, 255, 255), -- Border color
    BorderSizePixel = 1,                          -- Border thickness
    Size = UDim2.new(0.1, 0, 0.1, 0),             -- Size of the GUI element
    AnchorPoint = Vector2.new(0.5, 0.5),          -- Anchor point for positioning
    Position = UDim2.new(0.5, 0, 0.5, 0),         -- Position on the screen

    -- Theme Functions
    myFunction = function()
        print("Hello from DarkTheme!")
    end,

    myCoolPrintFunction = function(optionalArguments)
        print(table.unpack(optionalArguments)) -- Unpack arguments for output
    end,
})
```

### **Tip:**  
You can include as many properties and functions as needed in your theme, giving you full control over customization.

---

### **Step 3: Apply Your Theme**  
Use the `:apply()` function to apply your theme to any `GuiObject` (e.g., Frames, Buttons, TextLabels). This simplifies the styling process and ensures consistency across your game’s UI.  

```lua
local myFrame = Instance.new("Frame")
myTheme:apply(myFrame)
```

---

### **Step 4: Run Theme Functions**  
Run any function defined in your theme using the `:run()` method. Pass the function name as the first argument, and optionally, provide additional arguments as the second argument.

```lua
-- Run a simple function
myTheme:run("myFunction")

-- Run a function with arguments
myTheme:run("myCoolPrintFunction", {"Hello", "World!"})
```

**Important Note:**  
Make sure the function name provided as the first argument matches exactly with the function defined in your theme.

---

## **Features**  

- **Reusable Themes:** Save time by applying the same styles to multiple `GuiObjects`.
- **Custom Functions:** Add and execute functions specific to your theme, enhancing functionality.
- **Dynamic Styling:** Quickly adjust properties like size, position, and colors from a central theme.

---

## **Support & Updates**  

Thank you for using the Tailblox module! Updates will be rolled out as new features and ideas come to mind.  

For assistance or to share feedback, feel free to contact me on Discord: **@waitforchild**.  

Happy developing! 🚀  

---

# CosyHub — Roblox UI Framework

CosyHub is a lightweight UI library for Roblox executors.

---

## Load Framework

```lua
local CosyHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/cosyzzz/CosyHub/refs/heads/main/CosyHub"))()
```

Or if the file is in the same directory:
```lua
local CosyHub = loadstring(readfile("CosyHub.lua"))()
```

---

## Create Window

```lua
local Window = CosyHub:CreateWindow({
    Title       = "My Script",
    Description = "by Dev",
    TabWidth    = 110,
    SizeUi      = UDim2.fromOffset(600, 360),
})
```

| Parameter | Type | Description |
|---|---|---|
| `Title` | string | Main title displayed on the topbar |
| `Description` | string | Red sub-title shown next to the title |
| `TabWidth` | number | Width of the left tab column (default: 120) |
| `SizeUi` | UDim2 | Overall size of the window |

---

## Create Tab

```lua
local MyTab = Window:CreateTab({
    Name = "Main",
    Icon = "rbxassetid://4483362458",
})
```

`CreateTab` returns a Tab object. Call `:AddSection()` from this object.

---

## Create Section

```lua
local Sec = MyTab:AddSection("Section Title", true)
```

| Parameter | Type | Description |
|---|---|---|
| `Title` | string | Section title |
| `OpenSection` | bool | `true` = expanded by default, `false` = collapsed |

`AddSection` returns a Section object. Use it to add elements below.

---

## Elements

### Toggle

```lua
local toggle = Sec:AddToggle({
    Title    = "Enable Feature",
    Content  = "Optional description",
    Default  = false,
    Callback = function(value)
        print("Toggle is now:", value)
    end,
})

-- Set from code:
toggle:Set(true)

-- Read value:
print(toggle.Value)
```

---

### Slider

```lua
local slider = Sec:AddSlider({
    Title     = "Speed",
    Content   = "Movement speed",
    Min       = 1,
    Max       = 100,
    Increment = 1,
    Default   = 16,
    Callback  = function(value)
        print("Slider value:", value)
    end,
})

slider:Set(50)
print(slider.Value)
```

---

### Button

```lua
Sec:AddButton({
    Title    = "Click Me",
    Content  = "Button description",
    Icon     = "rbxassetid://7734010488",
    Callback = function()
        print("Button clicked!")
    end,
})
```

---

### Input (TextBox)

```lua
local input = Sec:AddInput({
    Title    = "Player Name",
    Content  = "Enter player name",
    Default  = "",
    Callback = function(value)
        print("Input value:", value)
    end,
})

input:Set("hello")
print(input.Value)
```

---

### Dropdown

```lua
local dropdown = Sec:AddDropdown({
    Title    = "Choose Mode",
    Content  = "Select a mode",
    Multi    = false,
    Options  = {"Option A", "Option B", "Option C"},
    Default  = {"Option A"},
    Callback = function(selected)
        -- selected is always a table even if Multi=false
        print("Selected:", selected[1])
    end,
})

-- Refresh options:
dropdown:Refresh({"New A", "New B"}, {"New A"})

-- Set from code:
dropdown:Set({"Option B"})

print(dropdown.Value)
```

> If `Multi = true`, `selected` will be a table with multiple entries.

---

### ColorPicker

```lua
local picker = Sec:AddColorPicker({
    Title    = "ESP Color",
    Color    = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("Color:", color)
    end,
})

picker:Set(Color3.fromRGB(0, 255, 0))
print(picker.Color)
```

Click the color swatch to open the modal. Drag the canvas to pick saturation/value, drag the hue slider to pick the base color, or type a hex code directly.

---

### Paragraph

```lua
local para = Sec:AddParagraph({
    Title   = "Dev",
    Content = "Cosy~~",
})

-- Update from code:
para:Set({ Title = "Version", Content = "v1.0" })
```

---

### Separator

```lua
local sep = Sec:AddSeperator({
    Title = "-- Settings --",
})

sep:Set({ Title = "-- New Title --" })
```

---

### Line

```lua
Sec:AddLine()
```

---

## Notification

```lua
CosyHub:SetNotification({
    Title       = "Title",
    Description = "Sub",
    Content     = "Detailed content goes here",
    Time        = 0.4,
    Delay       = 5,
})
```

| Parameter | Type | Description |
|---|---|---|
| `Title` | string | Notification title |
| `Description` | string | Red sub-title shown next to the title |
| `Content` | string | Main body text |
| `Time` | number | Animation in/out duration (seconds) |
| `Delay` | number | Time before auto-close (seconds) |

---

## Full Example

```lua
local CosyHub = loadstring(game:HttpGet("RAW_URL_TO_CosyHub.lua"))()

local Window = CosyHub:CreateWindow({
    Title       = "My Hub",
    Description = "by Me",
    TabWidth    = 110,
    SizeUi      = UDim2.fromOffset(580, 340),
})

local Tab1 = Window:CreateTab({ Name = "Main", Icon = "rbxassetid://4483362458" })

local Sec1 = Tab1:AddSection("Features", true)

Sec1:AddToggle({
    Title    = "Fly",
    Default  = false,
    Callback = function(v)
        print("Fly:", v)
    end,
})

Sec1:AddSlider({
    Title     = "Fly Speed",
    Min       = 1,
    Max       = 200,
    Increment = 1,
    Default   = 50,
    Callback  = function(v)
        print("Speed:", v)
    end,
})

CosyHub:SetNotification({
    Title   = "Loaded",
    Content = "My Hub loaded successfully!",
    Time    = 0.4,
    Delay   = 3,
})
```

---

## Notes

- Framework automatically prevents AFK kick.
- Notifications auto-close after `Delay` seconds.
- Window has a minimize (`-`) and close (`X`) button. After minimizing, click the small icon in the corner of the screen to reopen.
- You can use both array index and key name for Config: `Config[1]` = `Config.Title`, `Config[2]` = `Config.Content`, etc.
- `CosyHub.Unloaded` is set to `true` when the user clicks close.

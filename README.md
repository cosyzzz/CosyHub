# CosyHub

A lightweight, polished Roblox UI framework with a floating SmartBar, animated windows, search, color pickers, and more.

Load it in any script with a single line:

```lua
local CosyHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/cosyzzz/CosyHub/refs/heads/main/CosyHub.lua", true))()
```

---

## Quick Start

```lua
local CosyHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/cosyzzz/CosyHub/refs/heads/main/CosyHub.lua", true))()

local Window = CosyHub:CreateWindow({
    Title       = "My Script",
    Description = "by You",
    TabWidth    = 130,
    SizeUi      = UDim2.fromOffset(580, 340),
})

local Tab     = Window:CreateTab({ Name = "Main", Icon = "rbxassetid://4483362458" })
local Section = Tab:AddSection("Features", true)

Section:AddToggle({
    Title    = "Enable Hack",
    Default  = false,
    Callback = function(value)
        print("Toggle is now:", value)
    end,
})
```

---

## API Reference

### `CosyHub:CreateWindow(config)`

Creates the main window. Returns a `Window` object.

| Key | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `""` | Text shown in the window title bar |
| `Description` | string | `""` | Sub-text beneath the title |
| `TabWidth` | number | `120` | Width of the left tab sidebar in pixels |
| `SizeUi` | UDim2 | `UDim2.fromOffset(580, 340)` | Total window size |

```lua
local Window = CosyHub:CreateWindow({
    Title       = "CosyHub | My Script",
    Description = "by Cosy~~",
    TabWidth    = 130,
    SizeUi      = UDim2.fromOffset(600, 360),
})
```

The window opens with an animated scale-in effect and can be dragged by its title bar. Press **RightShift** (configurable) to toggle the window open/closed.

---

### `Window:CreateTab(config)`

Adds a tab to the left sidebar. Returns a `Tab` object.

| Key | Type | Description |
|---|---|---|
| `Name` | string | Label shown in the sidebar |
| `Icon` | string | Asset ID for a 20×20 icon (e.g. `"rbxassetid://4483362458"`) |

```lua
local Tab = Window:CreateTab({ Name = "ESP", Icon = "rbxassetid://4483362458" })
```

---

### `Tab:AddSection(title, open)`

Adds a collapsible section inside a tab. Returns a `Section` object you use to add elements.

| Parameter | Type | Description |
|---|---|---|
| `title` | string | Section header text |
| `open` | boolean | Whether the section starts expanded |

```lua
local Section = Tab:AddSection("Player Settings", true)
```

---

### `Section:AddToggle(config)`

Adds an on/off toggle switch. Returns a toggle object with a `:Set(value)` method.

| Key | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `""` | Label next to the toggle |
| `Content` | string | `""` | Optional small subtitle text |
| `Default` | boolean | `false` | Starting state |
| `Callback` | function | — | Called with `(value: boolean)` whenever toggled |

```lua
local myToggle = Section:AddToggle({
    Title    = "Show ESP",
    Content  = "Draws boxes on players",
    Default  = false,
    Callback = function(v)
        espEnabled = v
    end,
})

myToggle:Set(true)
```

---

### `Section:AddSlider(config)`

Adds a draggable slider with a live value display and a text-input fallback. Returns a slider object with a `:Set(value)` method.

| Key | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `""` | Label above the slider |
| `Content` | string | `""` | Unit label shown to the right of the value (e.g. `"m"`, `"px"`) |
| `Min` | number | `0` | Minimum value |
| `Max` | number | `100` | Maximum value |
| `Increment` | number | `1` | Snap step |
| `Default` | number | `50` | Starting value |
| `Callback` | function | — | Called with `(value: number)` on release |

```lua
local distSlider = Section:AddSlider({
    Title     = "Max Distance",
    Content   = "m",
    Min       = 50,
    Max       = 1000,
    Increment = 10,
    Default   = 250,
    Callback  = function(v)
        MAX_DIST = v
    end,
})

distSlider:Set(500)
```

---

### `Section:AddButton(config)`

Adds a clickable button with a ripple effect. Returns a button object.

| Key | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `""` | Button label |
| `Content` | string | `""` | Optional subtitle |
| `Icon` | string | `""` | Asset ID for a small left-side icon |
| `Callback` | function | — | Called on click |

```lua
Section:AddButton({
    Title    = "Teleport to Spawn",
    Content  = "Instant",
    Icon     = "rbxassetid://7734010488",
    Callback = function()
        teleportPlayer()
    end,
})
```

---

### `Section:AddInput(config)`

Adds a single-line text input box. Returns an input object with a `:Set(value)` method.

| Key | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `""` | Label |
| `Content` | string | `""` | Optional subtitle |
| `Default` | string | `""` | Starting text |
| `Callback` | function | — | Called with `(text: string)` when focus is lost |

```lua
local nameInput = Section:AddInput({
    Title    = "Config Name",
    Default  = "default",
    Callback = function(v)
        configName = v
    end,
})
```

---

### `Section:AddDropdown(config)`

Adds a dropdown selector. Supports single and multi-select modes. Returns a dropdown object with `:Set()`, `:AddOption()`, `:Clear()`, and `:Refresh()` methods.

| Key | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `""` | Label |
| `Content` | string | `""` | Optional subtitle |
| `Multi` | boolean | `false` | Allow multiple selections |
| `Options` | table | `{}` | Array of option strings |
| `Default` | table | `{}` | Array of initially-selected option strings |
| `Callback` | function | — | Called with `(selected)` — a string (single) or table (multi) |

```lua
local modeDD = Section:AddDropdown({
    Title    = "Line Origin",
    Multi    = false,
    Options  = { "Off", "Center", "Top", "Bottom" },
    Default  = { "Center" },
    Callback = function(sel)
        local choice = type(sel) == "table" and sel[1] or sel
        lineMode = tonumber(choice) or 1
    end,
})

modeDD:Set({ "Top" })
modeDD:Refresh({ "Off", "Center", "Top" }, { "Center" })
```

---

### `Section:AddColorPicker(config)`

Adds a color swatch that opens a floating modal with an HSV canvas, hue slider, and hex input. Returns a color picker object with a `:Set(Color3)` method.

| Key | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `""` | Label next to the swatch |
| `Color` | Color3 | `Color3.new(1,1,1)` | Starting color |
| `Callback` | function | — | Called live with `(color: Color3)` as the user drags |

```lua
local espColorPicker = Section:AddColorPicker({
    Title    = "ESP Color",
    Color    = Color3.fromRGB(0, 255, 255),
    Callback = function(c)
        espColor = c
    end,
})

espColorPicker:Set(Color3.fromRGB(255, 100, 100))
```

---

### `Section:AddHotkey(config)`

Adds a keybind picker. Click the badge to start listening, then press any key to bind it. Returns a hotkey object with a `:Set(KeyCode)` method.

| Key | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `""` | Label |
| `Default` | KeyCode | `Enum.KeyCode.Unknown` | Starting key |
| `Callback` | function | — | Called with `(keyCode: EnumItem)` when a new key is picked |

```lua
local dashHotkeyPicker = Section:AddHotkey({
    Title    = "Dash Hotkey",
    Default  = Enum.KeyCode.V,
    Callback = function(kc)
        dashKey = kc
    end,
})
```

Modifier keys (Shift, Ctrl, Alt, CapsLock, Tab) are ignored by the picker.

---

### `Section:AddParagraph(config)`

Adds a static read-only text block.

| Key | Type | Description |
|---|---|---|
| `Title` | string | Bold heading |
| `Content` | string | Body text beneath the heading |

```lua
Section:AddParagraph({
    Title   = "Version",
    Content = "v6.0",
})
```

---

### `Section:AddLine()`

Inserts a thin horizontal divider line.

```lua
Section:AddLine()
```

---

### `Section:AddSeperator(config)`

Inserts a labeled separator row.

| Key | Type | Description |
|---|---|---|
| `Title` | string | Label shown in the center of the separator |

```lua
Section:AddSeperator({ Title = "Advanced" })
```

---

### `CosyHub:SetNotification(config)`

Shows a slide-in notification card in the bottom-right corner.

| Key | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `""` | Bold heading |
| `Description` | string | `""` | Secondary text (shown in accent color) |
| `Content` | string | `""` | Body text |
| `Time` | number | `0.5` | Slide animation duration in seconds |
| `Delay` | number | `5` | How long the notification stays before fading |

```lua
CosyHub:SetNotification({
    Title       = "Script Loaded",
    Description = "CosyHub Evade",
    Content     = "All systems ready.",
    Time        = 0.4,
    Delay       = 4,
})
```

---

## Global Bridges (`_G`)

CosyHub exposes several `_G` values so outside scripts can talk to the UI:

| Global | Type | Description |
|---|---|---|
| `_G._CosyLineBox` | table | Internal reference to the SmartBar line-origin box. Used by the ESP to compute line start positions. |
| `_G._CosyToggleSettings` | function | Jumps to / back from the hidden Settings tab. |
| `_G._CosyKeepOnScreen` | function `(bool)` | Enables or disables the keep-window-on-screen constraint. |
| `_G._CosySetToggleKey` | function `(KeyCode)` | Changes the keyboard shortcut that opens/closes the window. |
| `_G._CosyUnlockMouse` | function `(bool)` | Unlocks the mouse cursor while the window is open (useful for games that lock the camera). |

---

## SmartBar

The floating bar at the top of the screen shows your avatar, display name, and a logo button. Clicking the logo toggles the main window. Minimising the window triggers a **shatter → re-absorb → fly-in** particle animation.

---

## Built-in Features

- **Search bar** — type in the top search box to instantly find any toggle, slider, or button across all tabs. Results show the feature name and its tab/section path. Clicking a result jumps to the tab and highlights the element with a pulse animation.
- **Drag** — grab the title bar to move the window anywhere on screen.
- **Settings tab** — hidden from the sidebar; accessible via the ⚙ button in the title bar. Contains toggle-key binding, keep-on-screen, mouse-unlock, and window-reset controls.
- **Color picker modal** — full HSV canvas + hue slider + hex input, with smooth open/close animation.

---

## License

MIT — use freely, credit appreciated.

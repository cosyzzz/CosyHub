local Players      = game:GetService("Players")
local Player       = Players.LocalPlayer
local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local UIS               = UserInputService
local VirtualUser       = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Custom = {}
Custom.ColorRGB = Color3.fromRGB(150, 150, 155)

function Custom:Create(Name, Properties, Parent)
    local inst = Instance.new(Name)
    for i, v in pairs(Properties) do
        inst[i] = v
    end
    if Parent then inst.Parent = Parent end
    return inst
end

function Custom:EnabledAFK()
    Player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

Custom:EnabledAFK()

local function OpenClose()
    
    local LOGO_ID = "rbxassetid://3926305904"

    local SmartGui = Custom:Create("ScreenGui", {
        Name           = "CosySmartBar",
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder   = 999,
        ResetOnSpawn   = false,
        IgnoreGuiInset = true,
    }, RunService:IsStudio() and Player.PlayerGui
       or (gethui and gethui())
       or (cloneref and cloneref(game:GetService("CoreGui")))
       or game:GetService("CoreGui"))

    local C = {
        bg     = Color3.fromRGB(10, 10, 16),
        white  = Color3.fromRGB(255,255,255),
        gray   = Color3.fromRGB(140,140,160),
        red    = Color3.fromRGB(160, 160, 160),
    }

    local function tw(inst, props, t, style, dir)
        TweenService:Create(inst,
            TweenInfo.new(t or 0.4,
                style or Enum.EasingStyle.Quint,
                dir   or Enum.EasingDirection.Out),
            props):Play()
    end

    local BAR_W, BAR_H = 168, 46

    local Bar = Custom:Create("Frame", {
        Name                   = "Bar",
        AnchorPoint            = Vector2.new(0.5, 0),
        Position               = UDim2.new(0.5, 0, 0, -BAR_H - 10),
        Size                   = UDim2.new(0, BAR_W, 0, BAR_H),
        BackgroundColor3       = C.bg,
        BackgroundTransparency = 0.08,
        BorderSizePixel        = 0,
        ClipsDescendants       = false,
        Visible                = false,
    }, SmartGui)
    Custom:Create("UICorner",  { CornerRadius = UDim.new(0, 26) }, Bar)
    Custom:Create("UIStroke",  { Color = Color3.fromRGB(50,50,65), Thickness = 1.2, Transparency = 0.3 }, Bar)

    local AvFrame = Custom:Create("Frame", {
        AnchorPoint      = Vector2.new(0, 0.5),
        Position         = UDim2.new(0, 8, 0.5, 0),
        Size             = UDim2.new(0, 32, 0, 32),
        BackgroundColor3 = Color3.fromRGB(22, 22, 28),
        BorderSizePixel  = 0, ZIndex = 3,
    }, Bar)
    Custom:Create("UICorner", { CornerRadius = UDim.new(1, 0) }, AvFrame)
    Custom:Create("UIStroke", { Color = Color3.fromRGB(160, 160, 160), Thickness = 1.5, Transparency = 0.35 }, AvFrame)

    local AvImg = Custom:Create("ImageLabel", {
        AnchorPoint            = Vector2.new(0.5, 0.5),
        Position               = UDim2.new(0.5, 0, 0.5, 0),
        Size                   = UDim2.new(1, -4, 1, -4),
        BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 4,
    }, AvFrame)
    Custom:Create("UICorner", { CornerRadius = UDim.new(1, 0) }, AvImg)

    Custom:Create("TextLabel", {
        AnchorPoint            = Vector2.new(0, 0.5),
        Position               = UDim2.new(0, 46, 0.5, -8),
        Size                   = UDim2.new(0, 82, 0, 15),
        BackgroundTransparency = 1,
        Font                   = Enum.Font.GothamBold,
        Text                   = Player.DisplayName,
        TextColor3             = C.white, TextSize = 11,
        TextXAlignment         = Enum.TextXAlignment.Left,
        TextTruncate           = Enum.TextTruncate.AtEnd, ZIndex = 4,
    }, Bar)
    Custom:Create("TextLabel", {
        AnchorPoint            = Vector2.new(0, 0.5),
        Position               = UDim2.new(0, 46, 0.5, 8),
        Size                   = UDim2.new(0, 82, 0, 12),
        BackgroundTransparency = 1,
        Font                   = Enum.Font.Gotham,
        Text                   = "@"..Player.Name,
        TextColor3             = C.gray, TextSize = 9,
        TextXAlignment         = Enum.TextXAlignment.Left,
        TextTruncate           = Enum.TextTruncate.AtEnd, ZIndex = 4,
    }, Bar)

    local LogoBtn = Custom:Create("Frame", {
        AnchorPoint      = Vector2.new(1, 0.5),
        Position         = UDim2.new(1, -7, 0.5, 0),
        Size             = UDim2.new(0, 34, 0, 34),
        BackgroundColor3 = Color3.fromRGB(20, 20, 26),
        BorderSizePixel  = 0, ZIndex = 4,
    }, Bar)
    Custom:Create("UICorner", { CornerRadius = UDim.new(1, 0) }, LogoBtn)
    local LogoStroke = Custom:Create("UIStroke", {
        Color = Color3.fromRGB(75, 75, 95), Thickness = 1.5, Transparency = 0.3,
    }, LogoBtn)

    local LogoIcon = Custom:Create("ImageLabel", {
        AnchorPoint            = Vector2.new(0.5, 0.5),
        Position               = UDim2.new(0.5, 0, 0.5, 0),
        Size                   = UDim2.new(0, 20, 0, 20),
        BackgroundTransparency = 1,
        Image                  = LOGO_ID,
        ImageColor3            = Color3.fromRGB(220, 220, 235),
        ZIndex                 = 5,
    }, LogoBtn)

    local LogoInteract = Custom:Create("TextButton", {
        BackgroundTransparency = 1, Text = "",
        Size                   = UDim2.new(1, 0, 1, 0), ZIndex = 6,
    }, LogoBtn)

    local _drag, _ds, _dp = false, nil, nil
    Bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            _drag = true; _ds = i.Position; _dp = Bar.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then _drag = false end
            end)
        end
    end)
    Bar.InputChanged:Connect(function(i)
        if _drag and (i.UserInputType == Enum.UserInputType.MouseMovement
                   or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - _ds
            Bar.Position = UDim2.new(_dp.X.Scale, _dp.X.Offset+d.X, _dp.Y.Scale, _dp.Y.Offset+d.Y)
        end
    end)

    task.spawn(function()
        local ok, thumb = pcall(function()
            return Players:GetUserThumbnailAsync(Player.UserId,
                Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        end)
        if ok then AvImg.Image = thumb end
    end)

    LogoInteract.MouseEnter:Connect(function()
        tw(LogoBtn,    { BackgroundColor3 = Color3.fromRGB(28,28,36), BackgroundTransparency = 0 }, 0.18)
        tw(LogoStroke, { Color = Color3.fromRGB(160, 160, 160), Transparency = 0.15 }, 0.18)
        tw(LogoIcon,   { ImageColor3 = C.white, Size = UDim2.new(0,28,0,28) }, 0.18, Enum.EasingStyle.Back)
    end)
    LogoInteract.MouseLeave:Connect(function()
        tw(LogoBtn,    { BackgroundColor3 = Color3.fromRGB(20,20,26), BackgroundTransparency = 0 }, 0.22)
        tw(LogoStroke, { Color = Color3.fromRGB(75,75,95), Transparency = 0.3 }, 0.22)
        tw(LogoIcon,   { ImageColor3 = Color3.fromRGB(220,220,235), Size = UDim2.new(0,24,0,24) }, 0.2)
    end)
    LogoInteract.MouseButton1Down:Connect(function()
        tw(LogoIcon, { Size = UDim2.new(0,20,0,20) }, 0.1)
    end)
    LogoInteract.MouseButton1Up:Connect(function()
        tw(LogoIcon, { Size = UDim2.new(0,26,0,26) }, 0.2, Enum.EasingStyle.Back)
    end)

    local LBOX_W = 48
    local LBOX_H = 22
    local LineBox = Custom:Create("Frame", {
        Name                   = "LineBox",
        AnchorPoint            = Vector2.new(0.5, 0),
        Position               = UDim2.new(0.5, 0, 0, BAR_H - 6),
        Size                   = UDim2.new(0, LBOX_W, 0, LBOX_H),
        BackgroundColor3       = Color3.fromRGB(10, 10, 16),
        BackgroundTransparency = 0.08,
        BorderSizePixel        = 0,
        ClipsDescendants       = false,
        ZIndex                 = 1,
    }, Bar)
    Custom:Create("UICorner", { CornerRadius = UDim.new(0, 10) }, LineBox)
    
    Custom:Create("Frame", {
        Size             = UDim2.new(1, 0, 0, 10),
        Position         = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(10, 10, 16),
        BorderSizePixel  = 0, ZIndex = 2,
    }, LineBox)
    Custom:Create("UIStroke", {
        Color = Color3.fromRGB(50,50,65), Thickness = 1.2, Transparency = 0.3,
    }, LineBox)

    local _dot = Custom:Create("Frame", {
        AnchorPoint      = Vector2.new(0.5, 1),
        Position         = UDim2.new(0.5, 0, 1, -4),
        Size             = UDim2.new(0, 6, 0, 6),
        BackgroundColor3 = Color3.fromRGB(160, 160, 160),
        BorderSizePixel  = 0, ZIndex = 3,
    }, LineBox)
    Custom:Create("UICorner", { CornerRadius = UDim.new(1,0) }, _dot)

    local _lboxShown = false

    local function showLineBox()
        if _lboxShown then return end
        _lboxShown = true
        LineBox.Position = UDim2.new(0.5, 0, 0, BAR_H - 6)
        LineBox.BackgroundTransparency = 0.08
        LineBox.Visible = true
        tw(LineBox, { Position = UDim2.new(0.5, 0, 0, BAR_H - 2) }, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end

    local function hideLineBox()
        if not _lboxShown then return end
        _lboxShown = false
        tw(LineBox, { Position = UDim2.new(0.5, 0, 0, BAR_H - 6) }, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.delay(0.38, function()
            if not _lboxShown then LineBox.Visible = false end
        end)
    end

    local _dotPixel = Vector2.new(0, 0)
    local _dotValid = false
    RunService.RenderStepped:Connect(function()
        if not LineBox.Visible then _dotValid = false; return end
        local _cam = workspace.CurrentCamera
        if not _cam then _dotValid = false; return end
        local vp = _cam.ViewportSize
        
        local barPos = Bar.Position
        local barCX  = vp.X * barPos.X.Scale + barPos.X.Offset
        local barTopY = vp.Y * barPos.Y.Scale + barPos.Y.Offset
        
        local lboxPos = LineBox.Position
        local lboxTopY = barTopY + lboxPos.Y.Offset  
        
        _dotPixel = Vector2.new(
            barCX,
            lboxTopY + LBOX_H - 7
        )
        _dotValid = true
    end)

    _G._CosyLineBox = {
        frame     = LineBox,
        showFn    = showLineBox,
        hideFn    = hideLineBox,
        barH      = BAR_H,
        lboxH     = LBOX_H,
        getDot    = function()
            if _dotValid then return _dotPixel end
            return nil
        end,
    }

    local _barShown = false

    local function showBar()
        if _barShown then return end
        _barShown = true
        Bar.Position               = UDim2.new(0.5, 0, 0, -BAR_H - 10)
        Bar.BackgroundTransparency = 0.08
        Bar.Visible                = true
        tw(Bar, { Position = UDim2.new(0.5, 0, 0, 10) },
            0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end

    local function hideBar()
        if not _barShown then return end
        _barShown = false
        tw(Bar, { Position = UDim2.new(0.5, 0, 0, -BAR_H - 10) },
            0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.delay(0.38, function()
            if not _barShown then Bar.Visible = false end
        end)
    end

    showBar()

    return {
        Visible   = false,
        _bar      = Bar,
        _showBar  = showBar,
        _hideBar  = hideBar,
        Activated = LogoInteract.Activated,
    }
end

local Open_Close = OpenClose()
local function MakeDraggable(topbar, object)
    local dragging, dragStart, startPos = false, nil, nil

    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = input.Position
            startPos  = object.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    topbar.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                      or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            object.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function CircleClick(Button, X, Y)
    task.spawn(function()
        Button.ClipsDescendants = true
        local Circle = Instance.new("ImageLabel")
        Circle.Image              = "rbxassetid://106471194043211"
        Circle.ImageColor3        = Color3.fromRGB(80,80,80)
        Circle.ImageTransparency  = 0.9
        Circle.BackgroundColor3   = Color3.fromRGB(255,255,255)
        Circle.BackgroundTransparency = 1
        Circle.ZIndex  = 10
        Circle.Name    = "Circle"
        Circle.Parent  = Button

        local nx = X - Button.AbsolutePosition.X
        local ny = Y - Button.AbsolutePosition.Y
        Circle.Position = UDim2.new(0, nx, 0, ny)

        local sz  = math.max(Button.AbsoluteSize.X, Button.AbsoluteSize.Y) * 1.5
        local ti  = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tw  = TweenService:Create(Circle, ti, {
            Size     = UDim2.new(0,sz,0,sz),
            Position = UDim2.new(0.5,-sz/2,0.5,-sz/2)
        })
        tw:Play()
        tw.Completed:Connect(function()
            for _ = 1, 10 do
                Circle.ImageTransparency = Circle.ImageTransparency + 0.01
                task.wait(0.05)
            end
            Circle:Destroy()
        end)
    end)
end

local CosyHub = {}
CosyHub.Unloaded = false

function CosyHub:SetNotification(Config)
    local Title   = Config[1] or Config.Title or ""
    local Desc    = Config[2] or Config.Description or ""
    local Content = Config[3] or Config.Content or ""
    local Time    = Config[5] or Config.Time or 0.5
    local Delay   = Config[6] or Config.Delay or 5

    local Gui = Custom:Create("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, RunService:IsStudio() and Player.PlayerGui
       or (gethui and gethui())
       or (cloneref and cloneref(game:GetService("CoreGui")))
       or game:GetService("CoreGui"))

    local Layout = Custom:Create("Frame", {
        AnchorPoint = Vector2.new(1,1),
        BackgroundColor3 = Color3.fromRGB(30, 30, 33),
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        Position = UDim2.new(1,-30,1,-30),
        Size     = UDim2.new(0,320,1,0),
        Name     = "Layout"
    }, Gui)

    local Count = 0
    Layout.ChildRemoved:Connect(function()
        Count = 0
        for _, v in ipairs(Layout:GetChildren()) do
            local newPos = UDim2.new(0,0,1,-((v.Size.Y.Offset+12)*Count))
            TweenService:Create(v, TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position=newPos}):Play()
            Count = Count + 1
        end
    end)

    local _cnt = 0
    for _, v in ipairs(Layout:GetChildren()) do
        _cnt = -(v.Position.Y.Offset) + v.Size.Y.Offset + 12
    end

    local NFrame = Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderSizePixel  = 0,
        Size   = UDim2.new(1,0,0,150),
        Name   = "NFrame",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0,1),
        Position    = UDim2.new(0,0,1,-_cnt)
    }, Layout)

    local NReal = Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderSizePixel  = 0,
        Position = UDim2.new(0,400,0,0),
        Size     = UDim2.new(1,0,1,0),
        Name     = "NReal"
    }, NFrame)

    Custom:Create("UICorner", { CornerRadius = UDim.new(0,8) }, NReal)

    local Top = Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        Size = UDim2.new(1,0,0,36),
        Name = "Top"
    }, NReal)
    Custom:Create("UICorner", { CornerRadius = UDim.new(0,5) }, Top)

    local TL = Custom:Create("TextLabel", {
        Font  = Enum.Font.GothamBold,
        Text  = Title,
        TextColor3 = Color3.fromRGB(255,255,255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        Size     = UDim2.new(1,0,1,0),
        Position = UDim2.new(0,10,0,0),
    }, Top)
    Custom:Create("UIStroke", { Color=Color3.fromRGB(255,255,255), Thickness=0.3 }, TL)

    local DL = Custom:Create("TextLabel", {
        Font  = Enum.Font.GothamBold,
        Text  = Desc,
        TextColor3 = Custom.ColorRGB,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        Size     = UDim2.new(1,0,1,0),
        Position = UDim2.new(0,TL.TextBounds.X+15,0,0),
    }, Top)
    Custom:Create("UIStroke", { Color=Custom.ColorRGB, Thickness=0.4 }, DL)

    local CloseBtn = Custom:Create("TextButton", {
        Font  = Enum.Font.SourceSans,
        Text  = "X",
        TextColor3 = Color3.fromRGB(255,255,255),
        TextSize = 18,
        AnchorPoint = Vector2.new(1,0.5),
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        Position = UDim2.new(1,-5,0.5,0),
        Size = UDim2.new(0,25,0,25),
    }, Top)

    local ContentLabel = Custom:Create("TextLabel", {
        Font  = Enum.Font.GothamBold,
        Text  = Content,
        TextColor3 = Color3.fromRGB(150,150,150),
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        Position = UDim2.new(0,10,0,27),
        Size     = UDim2.new(1,-20,0,13),
    }, NReal)

    ContentLabel.Size = UDim2.new(1,-20,0,13+(13*(ContentLabel.TextBounds.X//ContentLabel.AbsoluteSize.X)))
    ContentLabel.TextWrapped = true

    if ContentLabel.AbsoluteSize.Y < 27 then
        NFrame.Size = UDim2.new(1,0,0,65)
    else
        NFrame.Size = UDim2.new(1,0,0,ContentLabel.AbsoluteSize.Y+40)
    end

    local Waited  = false
    local Notif   = {}
    function Notif:Close()
        if Waited then return end
        Waited = true
        local tw = TweenService:Create(NReal, TweenInfo.new(tonumber(Time),Enum.EasingStyle.Back,Enum.EasingDirection.InOut), {Position=UDim2.new(0,400,0,0)})
        tw:Play()
        task.wait(tonumber(Time)/1.2)
        NFrame:Destroy()
        Waited = false
    end

    CloseBtn.Activated:Connect(function() Notif:Close() end)
    TweenService:Create(NReal, TweenInfo.new(tonumber(Time),Enum.EasingStyle.Back,Enum.EasingDirection.InOut), {Position=UDim2.new(0,0,0,0)}):Play()
    task.wait(tonumber(Delay))
    Notif:Close()
    return Notif
end

function CosyHub:CreateWindow(Config)
    local Title    = Config[1] or Config.Title or ""
    local Desc     = Config[2] or Config.Description or ""
    local TabWidth = Config[3] or Config["Tab Width"] or 120
    local SizeUi   = Config[4] or Config.SizeUi or UDim2.fromOffset(750, 440)

    local Gui = Custom:Create("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Name = "CosyHubMain",
    }, RunService:IsStudio() and Player.PlayerGui
       or (gethui and gethui())
       or (cloneref and cloneref(game:GetService("CoreGui")))
       or game:GetService("CoreGui"))

    local ShadowHolder = Custom:Create("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size     = UDim2.new(0,455,0,350),
        ZIndex   = 0,
        Name     = "ShadowHolder",
        Position = UDim2.new(0, Gui.AbsoluteSize.X//2-455//2, 0, Gui.AbsoluteSize.Y//2-350//2)
    }, Gui)

    local Shadow = Custom:Create("ImageLabel", {
        Image             = "",
        ImageColor3       = Color3.fromRGB(13, 13, 15),
        ImageTransparency = 0.5,
        ScaleType         = Enum.ScaleType.Slice,
        SliceCenter       = Rect.new(49,49,450,450),
        AnchorPoint       = Vector2.new(0.5,0.5),
        BackgroundTransparency = 1,
        BorderSizePixel   = 0,
        Position = UDim2.new(0.5,0,0.5,0),
        Size     = SizeUi,
        ZIndex   = 0,
        Name     = "Shadow"
    }, ShadowHolder)

    local Main = Custom:Create("Frame", {
        AnchorPoint = Vector2.new(0.5,0.5),
        BackgroundColor3 = Color3.fromRGB(10, 10, 12),
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5,0,0.5,0),
        Size     = SizeUi,
        Name     = "Main"
    }, Shadow)
    Custom:Create("UICorner", { CornerRadius=UDim.new(0,12) }, Main)
    Custom:Create("UIStroke", { Color=Color3.fromRGB(65,65,70), Thickness=1.0, Transparency=0.15 }, Main)

    local Top = Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(14, 14, 16),
        BackgroundTransparency = 0.0,
        BorderSizePixel = 0,
        Size = UDim2.new(1,0,0,40),
        Name = "Top"
    }, Main)
    Custom:Create("UICorner", { CornerRadius=UDim.new(0,10) }, Top)
    
    Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(14, 14, 16),
        BackgroundTransparency = 0.0,
        BorderSizePixel = 0,
        Position = UDim2.new(0,0,0.5,0),
        Size = UDim2.new(1,0,0.5,0),
        Name = "TopBottomFill"
    }, Top)

    local TitleLabel = Custom:Create("TextLabel", {
        Font  = Enum.Font.GothamBold,
        Text  = Title,
        TextColor3 = Color3.fromRGB(240,240,240),
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size     = UDim2.new(1,-110,1,0),
        Position = UDim2.new(0,14,0,0),
        ZIndex = 2,
    }, Top)

    local DescLabel = Custom:Create("TextLabel", {
        Font  = Enum.Font.Gotham,
        Text  = "",
        TextColor3 = Color3.fromRGB(90,90,95),
        TextSize = 11,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size     = UDim2.new(0,0,0,0),
        Position = UDim2.new(0,0,0,0),
        ZIndex = 2,
        Visible = false,
    }, Top)

    local function makeTopBtn(icon, posX, name)
        local Bg = Custom:Create("Frame", {
            AnchorPoint = Vector2.new(1,0.5),
            BackgroundColor3 = Color3.fromRGB(40, 40, 43),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(1,posX,0.5,0),
            Size = UDim2.new(0,30,0,30),
            Name = name.."Bg",
        }, Top)
        Custom:Create("UICorner", { CornerRadius=UDim.new(0,7) }, Bg)

        local Img = Custom:Create("ImageLabel", {
            Image = (icon ~= "" and "rbxassetid://"..icon or ""),
            ImageColor3 = Color3.fromRGB(200,200,200),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,0,0.5,0),
            Size = UDim2.new(0,20,0,20),
            Name = "Img",
        }, Bg)

        local Btn = Custom:Create("TextButton", {
            Text = "",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1,0,1,0),
            Name = name,
        }, Bg)

        Btn.MouseEnter:Connect(function()
            TweenService:Create(Bg,  TweenInfo.new(0.15), {BackgroundTransparency=0.82}):Play()
            TweenService:Create(Img, TweenInfo.new(0.15), {ImageColor3=Color3.fromRGB(255,255,255)}):Play()
        end)
        Btn.MouseLeave:Connect(function()
            TweenService:Create(Bg,  TweenInfo.new(0.2), {BackgroundTransparency=1}):Play()
            TweenService:Create(Img, TweenInfo.new(0.2), {ImageColor3=Color3.fromRGB(200,200,200)}):Play()
        end)

        return Btn, Bg
    end

    local CloseBtn,   CloseBg   = makeTopBtn("10137832201", -8,   "Close")
    local MinBtn,     MinBg     = makeTopBtn("10137941941", -46,  "Min")
    local SettingsBtn, SettingsBg = makeTopBtn("", -84, "Settings")
    local ResizeBtn,  ResizeBg  = makeTopBtn("6034818372",  -122, "Resize")

    local _settingsImg = SettingsBg:FindFirstChild("Img")
    task.spawn(function()
        local req            = (syn and syn.request) or (http and http.request) or http_request or request
        local hasCustomAsset = type(getcustomasset) == "function"
        local hasFilesystem  = type(writefile)  == "function"
                            and type(makefolder) == "function"
                            and type(isfile)     == "function"
                            and type(isfolder)   == "function"

        if not (req and hasCustomAsset and hasFilesystem) then return end

        local iconUrl  = "https://raw.githubusercontent.com/cosyzzz/CosyHub/main/CosyHub_Assets/setting_icon.png"
        local iconPath = "CosyHub/setting_icon.png"

        pcall(function()
            -- 1. Đảm bảo folder tồn tại
            if not isfolder("CosyHub") then makefolder("CosyHub") end

            -- 2. Download nếu chưa có file
            if not isfile(iconPath) then
                local ok, res = pcall(req, { Url = iconUrl, Method = "GET" })
                if ok and type(res) == "table"
                   and type(res.Body) == "string"
                   and #res.Body > 0 then
                    pcall(writefile, iconPath, res.Body)
                end
            end

            -- 3. getcustomasset chỉ sau khi chắc file đã tồn tại
            if isfile(iconPath) then
                local ok, asset = pcall(getcustomasset, iconPath)
                if ok and asset and asset ~= "" and _settingsImg then
                    _settingsImg.Image = asset
                end
            end
        end)
    end)

    Custom:Create("Frame", {
        AnchorPoint = Vector2.new(0.5,0),
        BackgroundColor3 = Color3.fromRGB(40,40,44),
        BackgroundTransparency = 0.0,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5,0,0,40),
        Size     = UDim2.new(1,0,0,1),
        Name     = "DecideFrame"
    }, Main)

    local LayersTab = Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(12,12,14),
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        Position = UDim2.new(0,0,0,41),
        Size     = UDim2.new(0,TabWidth+10,1,-41),
        Name     = "LayersTab"
    }, Main)
    Custom:Create("UICorner", { CornerRadius=UDim.new(0,10) }, LayersTab)
    
    Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(12,12,14),
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5,0,0,0),
        Size     = UDim2.new(0.5,0,0,10),
        Name = "SidebarTopRight"
    }, LayersTab)
    
    Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(12,12,14),
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        Position = UDim2.new(0,0,0,0),
        Size     = UDim2.new(0.5,0,0,10),
        Name = "SidebarTopLeft"
    }, LayersTab)
    
    Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(45,45,50),
        BackgroundTransparency = 0.0,
        BorderSizePixel = 0,
        Position = UDim2.new(1,-1,0,0),
        Size     = UDim2.new(0,1,1,0),
        Name = "SidebarBorder"
    }, LayersTab)

    local SearchBoxH = 38
    local SearchOuter = Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(18,18,20),
        BackgroundTransparency = 0.6,
        BorderSizePixel = 0,
        Position = UDim2.new(0,6,0,6),
        Size     = UDim2.new(1,-12,0,SearchBoxH - 10),
        Name     = "SearchOuter",
    }, LayersTab)
    Custom:Create("UICorner", { CornerRadius=UDim.new(0,6) }, SearchOuter)
    Custom:Create("UIStroke", { Color=Color3.fromRGB(60,60,65), Thickness=1, Transparency=0.3 }, SearchOuter)

    Custom:Create("ImageLabel", {
        Image              = "rbxassetid://3926305904",
        ImageRectOffset    = Vector2.new(964, 324),
        ImageRectSize      = Vector2.new(36, 36),
        ImageColor3        = Color3.fromRGB(120,120,125),
        BackgroundTransparency = 1,
        BorderSizePixel    = 0,
        AnchorPoint        = Vector2.new(0, 0.5),
        Position           = UDim2.new(0, 7, 0.5, 0),
        Size               = UDim2.new(0, 14, 0, 14),
        Name               = "SearchIcon",
    }, SearchOuter)

    local SearchBox = Custom:Create("TextBox", {
        Font = Enum.Font.Gotham,
        Text = "",
        PlaceholderText = "Search...",
        PlaceholderColor3 = Color3.fromRGB(80,80,85),
        TextColor3 = Color3.fromRGB(210,210,210),
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0,26,0,0),
        Size     = UDim2.new(1,-32,1,0),
        Name     = "SearchBox",
    }, SearchOuter)

    local SearchResults = Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(14,14,16),
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(0,6,0,SearchBoxH),
        Size     = UDim2.new(1,-12,0,0),
        Visible  = false,
        ZIndex   = 10,
        Name     = "SearchResults",
    }, LayersTab)
    Custom:Create("UICorner", { CornerRadius=UDim.new(0,6) }, SearchResults)
    Custom:Create("UIStroke", { Color=Color3.fromRGB(60,60,65), Thickness=1, Transparency=0.3 }, SearchResults)
    local SRLayout = Custom:Create("UIListLayout", {
        Padding   = UDim.new(0,2),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, SearchResults)
    Custom:Create("UIPadding", {
        PaddingTop=UDim.new(0,4), PaddingBottom=UDim.new(0,4),
        PaddingLeft=UDim.new(0,4), PaddingRight=UDim.new(0,4),
    }, SearchResults)

    local ScrollTab = Custom:Create("ScrollingFrame", {
        CanvasSize        = UDim2.new(0,0,2.1,0),
        ScrollBarThickness = 0,
        Active            = true,
        BackgroundTransparency = 0.999,
        BorderSizePixel   = 0,
        Position          = UDim2.new(0,0,0,SearchBoxH),
        Size              = UDim2.new(1,0,1,-SearchBoxH),
        Name              = "ScrollTab"
    }, LayersTab)
    Custom:Create("UIListLayout", { Padding=UDim.new(0,0), SortOrder=Enum.SortOrder.LayoutOrder }, ScrollTab)

    local Layers = Custom:Create("Frame", {
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        Position = UDim2.new(0,TabWidth+18,0,50),
        Size     = UDim2.new(1,-(TabWidth+9+18),1,-59),
        Name     = "Layers"
    }, Main)
    Custom:Create("UICorner", { CornerRadius=UDim.new(0,2) }, Layers)

    local NameTab = Custom:Create("TextLabel", {
        Font  = Enum.Font.GothamBold,
        Text  = "",
        TextColor3 = Color3.fromRGB(255,255,255),
        TextSize = 24,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        Size = UDim2.new(1,0,0,30),
        Name = "NameTab"
    }, Layers)

    local LayersReal = Custom:Create("Frame", {
        AnchorPoint = Vector2.new(0,1),
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(0,0,1,0),
        Size     = UDim2.new(1,0,1,-33),
        Name     = "LayersReal"
    }, Layers)

    local LayersFolder = Custom:Create("Folder", { Name="LayersFolder" }, LayersReal)
    local LayersPageLayout = Custom:Create("UIPageLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Name = "LayersPageLayout",
        TweenTime = 0.5,
        EasingDirection = Enum.EasingDirection.InOut,
        EasingStyle = Enum.EasingStyle.Quad
    }, LayersFolder)

    local _isLarge   = false
    local _smallSize = SizeUi
    local _largeSize = UDim2.fromOffset(
        math.round(SizeUi.X.Offset * 1.4),
        math.round(SizeUi.Y.Offset * 1.35)
    )
    local _smallTab = TabWidth
    local _largeTab = math.round(TabWidth * 1.35)

    local function applySize(large)
        _isLarge = large
        local targetSize   = large and _largeSize or _smallSize
        local targetTab    = large and _largeTab  or _smallTab
        local targetFontSz = large and 15 or 13
        local targetTabH   = large and 36 or 30
        local ti = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        TweenService:Create(Shadow,    ti, {Size=targetSize}):Play()
        TweenService:Create(Main,      ti, {Size=targetSize}):Play()
        TweenService:Create(LayersTab, ti, {Size=UDim2.new(0,targetTab+10,1,-41)}):Play()
        TweenService:Create(Layers,    ti, {
            Position = UDim2.new(0,targetTab+10+8,0,50),
            Size     = UDim2.new(1,-(targetTab+10+17),1,-59),
        }):Play()

        for _, tf in pairs(ScrollTab:GetChildren()) do
            if tf.Name == "Tab" then
                TweenService:Create(tf,  ti, {Size=UDim2.new(1,0,0,targetTabH)}):Play()
                local lbl = tf:FindFirstChild("TabName")
                if lbl then
                    TweenService:Create(lbl, ti, {TextSize=targetFontSz}):Play()
                    
                    TweenService:Create(lbl, ti, {Size=UDim2.new(1,-40,1,0)}):Play()
                end
                local img = tf:FindFirstChild("FeatureImg")
                if img then
                    local newSz = large and 20 or 16
                    
                    TweenService:Create(img, ti, {
                        Size     = UDim2.new(0,newSz,0,newSz),
                        Position = UDim2.new(0,9,0.5,0),
                    }):Play()
                end
            end
        end

        local rImg = ResizeBg:FindFirstChild("Img")
        if rImg then TweenService:Create(rImg, ti, {Rotation=large and 45 or 0}):Play() end

    end

    ResizeBtn.Activated:Connect(function()
        CircleClick(ResizeBtn, Player:GetMouse().X, Player:GetMouse().Y)
        applySize(not _isLarge)
    end)

    local MoreBlur = Custom:Create("Frame", {
        AnchorPoint = Vector2.new(1,1),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(1,0,1,0),
        Size     = UDim2.new(1,0,1,0),
        Visible  = false,
        Name     = "MoreBlur"
    }, Layers)
    Custom:Create("UICorner", {}, MoreBlur)

    local ConnectButton = Custom:Create("TextButton", {
        Text  = "",
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        Size  = UDim2.new(1,0,1,0),
        Name  = "ConnectButton",
    }, MoreBlur)

    local DropdownSelect = Custom:Create("Frame", {
        AnchorPoint = Vector2.new(1,0.5),
        BackgroundColor3 = Color3.fromRGB(16,16,18),
        BorderSizePixel = 0,
        LayoutOrder = 1,
        Position = UDim2.new(1,172,0.5,0),
        Size     = UDim2.new(0,160,1,-16),
        Name     = "DropdownSelect",
        ClipsDescendants = true,
    }, MoreBlur)
    Custom:Create("UICorner",  { CornerRadius=UDim.new(0,3) }, DropdownSelect)
    Custom:Create("UIStroke",  { Color=Color3.fromRGB(255,255,255), Thickness=2.5, Transparency=0.8 }, DropdownSelect)

    local DropdownSelectReal = Custom:Create("Frame", {
        AnchorPoint = Vector2.new(0.5,0.5),
        BackgroundTransparency = 0.999,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5,0,0.5,0),
        Size     = UDim2.new(1,-10,1,-10),
        Name     = "DropdownSelectReal",
    }, DropdownSelect)

    local DropdownFolder = Custom:Create("Folder", { Name="DropdownFolder" }, DropdownSelectReal)
    local DropPageLayout = Custom:Create("UIPageLayout", {
        EasingDirection = Enum.EasingDirection.InOut,
        EasingStyle     = Enum.EasingStyle.Quad,
        TweenTime       = 0.01,
        SortOrder       = Enum.SortOrder.LayoutOrder,
        Name            = "DropPageLayout",
    }, DropdownFolder)

    local _activeDropdownClose = nil

    ConnectButton.Activated:Connect(function()
        if MoreBlur.Visible then
            local ti = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(MoreBlur, TweenInfo.new(0.2), {BackgroundTransparency=0.999}):Play()
            TweenService:Create(DropdownSelect, ti, {
                Size     = UDim2.new(0,160,0,0),
                Position = UDim2.new(1,172,0.5,0),
                BackgroundTransparency = 1,
            }):Play()
            if _activeDropdownClose then
                _activeDropdownClose()
                _activeDropdownClose = nil
            end
            task.wait(0.2)
            MoreBlur.Visible = false
            
            DropdownSelect.Size = UDim2.new(0,160,1,-16)
        end
    end)

    local function UpdateSize()
        local total = 0
        for _, v in pairs(ScrollTab:GetChildren()) do
            if v.Name ~= "UIListLayout" then
                total = total + 3 + v.Size.Y.Offset
            end
        end
        ScrollTab.CanvasSize = UDim2.new(0,0,0,total)
    end
    ScrollTab.ChildAdded:Connect(UpdateSize)
    ScrollTab.ChildRemoved:Connect(UpdateSize)

    ShadowHolder.Size = UDim2.new(0, SizeUi.X.Offset, 0, SizeUi.Y.Offset)
    local _fullSize = ShadowHolder.Size  

    local function animateOpen()
        ShadowHolder.Size    = UDim2.fromOffset(0, 0)
        ShadowHolder.Visible = true
        TweenService:Create(ShadowHolder,
            TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            { Size = _fullSize }
        ):Play()
    end

    local function animateClose(callback)
        TweenService:Create(ShadowHolder,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            { Size = UDim2.fromOffset(0, 0) }
        ):Play()
        task.delay(0.3, function()
            ShadowHolder.Visible = false
            ShadowHolder.Size    = _fullSize
            if callback then callback() end
        end)
    end

    local function animateMinToBar(callback)
        
        local savedPos  = ShadowHolder.Position
        local savedSize = Main.Size
        local absP = ShadowHolder.AbsolutePosition
        local absS = ShadowHolder.AbsoluteSize
        local uiCX = absP.X + absS.X * 0.5
        local uiCY = absP.Y + absS.Y * 0.5

        local Bar    = Open_Close._bar
        local barAbs = Bar and Bar.AbsolutePosition or Vector2.new(0, 0)
        local barSz  = Bar and Bar.AbsoluteSize     or Vector2.new(168, 46)
        local destCX = barAbs.X + barSz.X * 0.5
        local destCY = barAbs.Y + barSz.Y * 0.5

        local DUR_SHAKE   = 0.90   
        local DUR_SHATTER = 1.20   
        local DUR_HANG    = 0.75   
        local DUR_SNAP    = 0.65   
        local DUR_PULSE   = 0.20   
        local DUR_FLY     = 1.40   

        local bx  = savedPos.X.Offset
        local by  = savedPos.Y.Offset
        local bsx = savedPos.X.Scale
        local bsy = savedPos.Y.Scale
        local AMP  = 5      
        local STEP = 0.048  
        local shakeSteps = math.floor(DUR_SHAKE / STEP)
        for i = 1, shakeSteps do
            task.delay(STEP * (i - 1), function()
                if not ShadowHolder or not ShadowHolder.Parent then return end
                local ox = (math.random() - 0.5) * AMP * 2
                local oy = (math.random() - 0.5) * AMP
                TweenService:Create(ShadowHolder,
                    TweenInfo.new(STEP * 0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    { Position = UDim2.new(bsx, bx + ox, bsy, by + oy) }
                ):Play()
            end)
        end

        task.delay(DUR_SHAKE, function()
            ShadowHolder.Visible  = false
            ShadowHolder.Position = savedPos   

            local FRAG_N   = 40
            local TRI_SL   = 10  
            local SHAPES   = {"sq","cr","dm","tr","sq","cr","dm","tr","sq","dm","tr","cr","sq","dm","tr","cr","sq","cr","tr","sq","dm","cr","tr","sq","dm","cr","tr","dm","sq","tr","cr","dm","sq","tr","cr","sq","dm","tr","cr","dm"}
            local frags    = {}

            local function mkSLine()
                local l = Drawing.new("Line")
                l.Thickness=1; l.Transparency=1; l.Visible=false; return l
            end

            local function triPts(cx, cy, rot, sz)
                local pts = {}
                for k = 0, 2 do
                    local a = rot + (k/3)*math.pi*2
                    pts[k+1] = Vector2.new(cx + math.cos(a)*sz, cy + math.sin(a)*sz)
                end
                return pts[1], pts[2], pts[3]
            end

            local fragDefs = {}
            for i = 1, FRAG_N do
                local angle  = (i / FRAG_N) * math.pi * 2 + (math.random() - 0.5) * 0.45
                local sz     = math.random(7, 17)
                local shp    = SHAPES[i] or "sq"
                local dist   = math.random(180, 380)
                local jitter = (math.random() - 0.5) * 0.4
                fragDefs[i] = {
                    angle = angle, sz = sz, shp = shp,
                    tX = uiCX + math.cos(angle + jitter) * dist,
                    tY = uiCY + math.sin(angle + jitter) * dist + math.random(10, 45),
                }
            end

            local SEP_MIN  = 28   
            local SEP_ITER = 8    
            for _ = 1, SEP_ITER do
                for a = 1, FRAG_N do
                    for b = a + 1, FRAG_N do
                        local da = fragDefs[a]
                        local db = fragDefs[b]
                        local dx = db.tX - da.tX
                        local dy = db.tY - da.tY
                        local d2 = dx*dx + dy*dy
                        if d2 < SEP_MIN*SEP_MIN and d2 > 0 then
                            local dist2 = math.sqrt(d2)
                            local push  = (SEP_MIN - dist2) * 0.5
                            local nx    = dx / dist2
                            local ny    = dy / dist2
                            da.tX = da.tX - nx * push
                            da.tY = da.tY - ny * push
                            db.tX = db.tX + nx * push
                            db.tY = db.tY + ny * push
                        end
                    end
                end
            end

            for i = 1, FRAG_N do
                local def = fragDefs[i]
                local shp = def.shp
                local sz  = def.sz
                local tX  = def.tX
                local tY  = def.tY

                if shp == "tr" then
                    
                    local lines = {}
                    for _ = 1, 3 + TRI_SL do lines[#lines+1] = mkSLine() end
                    local rot0   = math.random() * math.pi * 2
                    local rotSpd = (math.random()-0.5) * math.pi * 5

                    table.insert(frags, {
                        shp=shp, lines=lines,
                        cx=uiCX, cy=uiCY, tX=tX, tY=tY,
                        sz=sz, rot=rot0, rotSpd=rotSpd,
                        startT=tick(),
                    })

                else
                    local GLOW_PAD = 7   

                    local rot0 = math.random(0, 359)
                    if shp == "dm" then rot0 = 45 + math.random(-12, 12) end

                    local f = Instance.new("Frame")
                    f.AnchorPoint            = Vector2.new(0.5, 0.5)
                    f.BackgroundColor3       = Color3.fromRGB(255, 255, 255)
                    f.BackgroundTransparency = 0.68
                    f.BorderSizePixel        = 0
                    f.Size                   = UDim2.fromOffset(sz + GLOW_PAD*2, sz + GLOW_PAD*2)
                    f.Position               = UDim2.fromOffset(uiCX, uiCY)
                    f.ZIndex                 = 96
                    f.Rotation               = rot0
                    f.ClipsDescendants       = false

                    if shp == "cr" then
                        Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)
                    else
                        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 3 + GLOW_PAD)
                    end

                    local inner = Instance.new("Frame")
                    inner.AnchorPoint            = Vector2.new(0.5, 0.5)
                    inner.BackgroundColor3       = Color3.fromRGB(0, 0, 0)
                    inner.BackgroundTransparency = 0.0
                    inner.BorderSizePixel        = 0
                    inner.Size                   = UDim2.fromOffset(sz, sz)
                    inner.Position               = UDim2.new(0.5, 0, 0.5, 0)
                    inner.ZIndex                 = 97

                    if shp == "cr" then
                        Instance.new("UICorner", inner).CornerRadius = UDim.new(1, 0)
                    else
                        Instance.new("UICorner", inner).CornerRadius = UDim.new(0, 3)
                    end

                    local st = Instance.new("UIStroke")
                    st.Color=Color3.fromRGB(255,255,255); st.Thickness=1.3; st.Transparency=0.2; st.Parent=inner

                    inner.Parent = f
                    f.Parent     = Gui

                    table.insert(frags, { shp=shp, f=f, inner=inner, tX=tX, tY=tY, startT=tick() })

                    TweenService:Create(f,
                        TweenInfo.new(DUR_SHATTER, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                        {
                            Position = UDim2.fromOffset(tX, tY),
                            Rotation = f.Rotation + math.random(-300, 300),
                            Size     = UDim2.fromOffset(
                                sz * (0.8 + math.random()*0.65),
                                sz * (0.8 + math.random()*0.65)
                            ),
                        }
                    ):Play()
                end
            end

            local loopStart = tick()
            local triConn
            triConn = RunService.Heartbeat:Connect(function()
                local now     = tick()
                local elapsed = now - loopStart
                local anyAlive = false

                local WHITE = Color3.fromRGB(255,255,255)

                for _, d in ipairs(frags) do
                    if d.shp ~= "tr" then continue end
                    local ls = d.lines
                    if not ls or not ls[1] then continue end

                    local cx, cy, sz, transp

                    if elapsed < DUR_SHATTER then
                        local t  = 1 - math.pow(2, -10*elapsed/DUR_SHATTER)
                        cx       = d.cx + (d.tX - d.cx)*t
                        cy       = d.cy + (d.tY - d.cy)*t
                        sz       = d.sz; transp = 0
                        anyAlive = true

                    elseif elapsed < DUR_SHATTER + DUR_HANG then
                        cx=d.tX; cy=d.tY; sz=d.sz; transp=0
                        anyAlive = true

                    elseif elapsed < DUR_SHATTER + DUR_HANG + DUR_SNAP then
                        local t  = ((elapsed-DUR_SHATTER-DUR_HANG)/DUR_SNAP)
                        t        = t*t*t*t*t
                        cx       = d.tX + (uiCX-d.tX)*t
                        cy       = d.tY + (uiCY-d.tY)*t
                        sz       = d.sz*(1-t*0.92)
                        transp   = t
                        anyAlive = true

                    else
                        for _, l in ipairs(ls) do l.Visible=false end
                        continue
                    end

                    local rot = d.rot + d.rotSpd * math.min(elapsed, DUR_SHATTER)
                    local pA, pB, pC = triPts(cx, cy, rot, math.max(sz,0.5))

                    ls[1].From=pA; ls[1].To=pB; ls[1].Color=WHITE; ls[1].Thickness=1.5; ls[1].Transparency=transp; ls[1].Visible=true
                    ls[2].From=pB; ls[2].To=pC; ls[2].Color=WHITE; ls[2].Thickness=1.5; ls[2].Transparency=transp; ls[2].Visible=true
                    ls[3].From=pC; ls[3].To=pA; ls[3].Color=WHITE; ls[3].Thickness=1.5; ls[3].Transparency=transp; ls[3].Visible=true

                    for k = 1, TRI_SL do
                        local t2  = k / (TRI_SL+1)
                        local lx1 = pA.X + (pB.X-pA.X)*t2
                        local ly1 = pA.Y + (pB.Y-pA.Y)*t2
                        local lx2 = pA.X + (pC.X-pA.X)*t2
                        local ly2 = pA.Y + (pC.Y-pA.Y)*t2
                        local sl  = ls[3+k]
                        sl.From=Vector2.new(lx1,ly1); sl.To=Vector2.new(lx2,ly2)
                        sl.Color=WHITE; sl.Thickness=1; sl.Transparency=transp; sl.Visible=true
                    end
                end

                if not anyAlive then
                    triConn:Disconnect()
                    for _, d in ipairs(frags) do
                        if d.shp=="tr" and d.lines then
                            for _, l in ipairs(d.lines) do pcall(function() l:Remove() end) end
                        end
                    end
                end
            end)

            task.delay(DUR_SHATTER + DUR_HANG, function()
                for _, d in ipairs(frags) do
                    if not d.f or not d.f.Parent then continue end
                    
                    TweenService:Create(d.f,
                        TweenInfo.new(DUR_SNAP, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
                        {
                            Position               = UDim2.fromOffset(uiCX, uiCY),
                            Size                   = UDim2.fromOffset(4, 4),
                            BackgroundTransparency = 1.0,
                            Rotation               = 0,
                        }
                    ):Play()
                    
                    if d.inner and d.inner.Parent then
                        TweenService:Create(d.inner,
                            TweenInfo.new(DUR_SNAP * 0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
                            { BackgroundTransparency = 1.0 }
                        ):Play()
                    end
                end

                task.delay(DUR_SNAP * 0.82, function()
                    for _, d in ipairs(frags) do
                        if d.shp == "tr" then
                            if d.lines then
                                for _, l in ipairs(d.lines) do pcall(function() l:Remove() end) end
                            end
                        else
                            pcall(function() d.f:Destroy() end)
                        end
                    end

                local ORB = 12
                local GL1 = 26   
                local GL2 = 48   

                local function makeRound(sz, col, transp, z)
                        local fr = Instance.new("Frame")
                        fr.AnchorPoint            = Vector2.new(0.5, 0.5)
                        fr.BackgroundColor3       = col
                        fr.BackgroundTransparency = transp
                        fr.BorderSizePixel        = 0
                        fr.Size                   = UDim2.fromOffset(sz, sz)
                        fr.Position               = UDim2.fromOffset(uiCX, uiCY)
                        fr.ZIndex                 = z
                        Instance.new("UICorner", fr).CornerRadius = UDim.new(1, 0)
                        fr.Parent = Gui
                        return fr
                    end

                    local bloom = makeRound(GL2, Color3.fromRGB(255,255,255), 0.72, 96)
                    local glow  = makeRound(GL1, Color3.fromRGB(255,255,255), 0.45, 98)
                    local core  = makeRound(ORB, Color3.fromRGB(255,255,255), 0.0,  99)

                    local tiFlashOut = TweenInfo.new(DUR_PULSE * 0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                    local tiFlashIn  = TweenInfo.new(DUR_PULSE * 0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                    TweenService:Create(bloom, tiFlashOut, {
                        Size = UDim2.fromOffset(GL2 + 35, GL2 + 35),
                        BackgroundTransparency = 0.85,
                    }):Play()
                    TweenService:Create(glow, tiFlashOut, {
                        Size = UDim2.fromOffset(GL1 + 18, GL1 + 18),
                        BackgroundTransparency = 0.55,
                    }):Play()
                    task.delay(DUR_PULSE * 0.45, function()
                        TweenService:Create(bloom, tiFlashIn, {
                            Size = UDim2.fromOffset(GL2, GL2),
                            BackgroundTransparency = 0.72,
                        }):Play()
                        TweenService:Create(glow, tiFlashIn, {
                            Size = UDim2.fromOffset(GL1, GL1),
                            BackgroundTransparency = 0.45,
                        }):Play()
                    end)

                    task.delay(DUR_PULSE, function()
                        
                        Main.Size                   = savedSize
                        Main.BackgroundTransparency = 0.08
                        Shadow.Size                 = savedSize
                        Shadow.ImageTransparency    = 0.5
                        ShadowHolder.Position       = savedPos

                        local tiFly = TweenInfo.new(DUR_FLY, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                        TweenService:Create(core,  tiFly, { Position = UDim2.fromOffset(destCX, destCY), Size = UDim2.fromOffset(4,  4)  }):Play()
                        TweenService:Create(glow,  tiFly, { Position = UDim2.fromOffset(destCX, destCY), Size = UDim2.fromOffset(7,  7)  }):Play()
                        TweenService:Create(bloom, tiFly, { Position = UDim2.fromOffset(destCX, destCY), Size = UDim2.fromOffset(12, 12) }):Play()

                        task.delay(DUR_FLY * 0.72, function()
                            local tiFade = TweenInfo.new(DUR_FLY * 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                            TweenService:Create(core,  tiFade, { BackgroundTransparency = 1 }):Play()
                            TweenService:Create(glow,  tiFade, { BackgroundTransparency = 1 }):Play()
                            TweenService:Create(bloom, tiFade, { BackgroundTransparency = 1 }):Play()
                        end)

                        task.delay(DUR_FLY, function()
                            pcall(function() core:Destroy()  end)
                            pcall(function() glow:Destroy()  end)
                            pcall(function() bloom:Destroy() end)
                            if callback then callback() end
                        end)
                    end)
                end)
            end)
        end)
    end

    animateOpen()

    MinBtn.Activated:Connect(function()
        CircleClick(MinBtn, Player:GetMouse().X, Player:GetMouse().Y)
        animateMinToBar(function()
            Open_Close._showBar()
        end)
    end)
    Open_Close.Activated:Connect(function()
        animateOpen()
    end)
    
    local function animateCloseAndDestroy()

        local function nukeAll()
            
            if isDashing then
                isDashing = false
                pcall(function() VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game) end)
                task.wait(0.05)
                pcall(function()
                    VirtualInputManager:SendKeyEvent(true,  Enum.KeyCode.G, false, game)
                    task.wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.G, false, game)
                end)
            end
            
            if wLocked then
                wLocked = false; wHoldStart = nil; wWasDown = false
                pcall(function() VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game) end)
            end
            edashEnabled   = false
            spaceEnabled   = false
            wHoldEnabled   = false
            isHoldingSpace = false
            
            if FullbrightEnabled then
                FullbrightEnabled = false
                restoreLighting()
            end
            
            for e in pairs(LabelPool) do pcall(function() removeLabel(e)    end) end
            for e in pairs(LinePool)  do pcall(function() removeLine(e)     end) end
            for e in pairs(IndPool)   do pcall(function() removeIndicator(e) end) end
            LabelPool = {}; LinePool = {}; IndPool = {}
            
            pcall(function() FpsValDraw:Remove() end)
            pcall(function() FpsTagDraw:Remove() end)
            pcall(function() MsValDraw:Remove()  end)
            pcall(function() MsTagDraw:Remove()  end)
            
            pcall(function()
                local sg = Open_Close._bar and Open_Close._bar.Parent
                if sg then sg:Destroy() end
            end)
            pcall(function() if Gui then Gui:Destroy() end end)
            CosyHub.Unloaded = true
        end

        local savedPos = ShadowHolder.Position
        local absP     = ShadowHolder.AbsolutePosition
        local absS     = ShadowHolder.AbsoluteSize
        local uiCX     = absP.X + absS.X * 0.5
        local uiCY     = absP.Y + absS.Y * 0.5
        local bx       = savedPos.X.Offset
        local by       = savedPos.Y.Offset
        local bsx      = savedPos.X.Scale
        local bsy      = savedPos.Y.Scale

        local Bar    = Open_Close._bar
        local barAbs = Bar and Bar.AbsolutePosition or Vector2.new((workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.X or 0) * 0.5 - 84, 10)
        local barSz  = Bar and Bar.AbsoluteSize     or Vector2.new(168, 46)
        local barCX  = barAbs.X + barSz.X * 0.5
        local barCY  = barAbs.Y + barSz.Y * 0.5

        local DUR_SHAKE = 0.90
        local AMP, STEP = 5, 0.048
        for i = 1, math.floor(DUR_SHAKE / STEP) do
            task.delay(STEP * (i - 1), function()
                if not ShadowHolder or not ShadowHolder.Parent then return end
                local ox = (math.random() - 0.5) * AMP * 2
                local oy = (math.random() - 0.5) * AMP
                TweenService:Create(ShadowHolder,
                    TweenInfo.new(STEP * 0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    { Position = UDim2.new(bsx, bx + ox, bsy, by + oy) }
                ):Play()
            end)
        end

        task.delay(DUR_SHAKE, function()
            ShadowHolder.Visible  = false
            ShadowHolder.Position = savedPos
            if Bar then Bar.Visible = false end

            local TRI_SL  = 10
            local GRAVITY = 400   
            local _cam2   = workspace.CurrentCamera
            local vp      = _cam2 and _cam2.ViewportSize or Vector2.new(1280, 720)
            local WHITE   = Color3.fromRGB(255, 255, 255)
            local SHAPES  = {"sq","cr","dm","tr","sq","cr","dm","tr","sq","dm","tr","cr","sq","dm","tr","cr","sq","cr","tr","sq","dm","cr","tr","sq","dm","cr","tr","dm","sq","tr","cr","dm","sq","tr","cr","sq","dm","tr","cr","dm","sq","cr","dm","tr","sq","cr","dm","tr","sq","dm","tr","cr","sq","dm","tr","cr","sq","cr","tr","sq","dm","cr","tr","sq","dm","cr","tr","dm","sq","tr","cr","dm","sq","tr","cr","sq","dm","tr","cr","dm"}
            local BAR_SHP = {"sq","cr","dm","sq","cr","tr","dm","sq","cr","dm","sq","cr","tr","dm","sq","cr","dm","sq","tr","cr","dm","sq","cr","dm","sq"}
            local frags   = {}

            local function mkSLine()
                local l = Drawing.new("Line")
                l.Thickness=1; l.Transparency=1; l.Visible=false; return l
            end
            local function triPts(cx, cy, rot, sz)
                local p = {}
                for k = 0, 2 do
                    local a = rot + (k/3)*math.pi*2
                    p[k+1] = Vector2.new(cx + math.cos(a)*sz, cy + math.sin(a)*sz)
                end
                return p[1], p[2], p[3]
            end

            local function spawnFrag(cx, cy, angle, sz, shp, spd)
                local vx = math.cos(angle) * spd
                local vy = math.sin(angle) * spd - math.random(20, 70)
                if shp == "tr" then
                    local lines = {}
                    for _ = 1, 3 + TRI_SL do lines[#lines+1] = mkSLine() end
                    table.insert(frags, {
                        shp="tr", lines=lines, dead=false,
                        x=cx, y=cy, vx=vx, vy=vy, sz=sz,
                        rot=math.random()*math.pi*2,
                        rotSpd=(math.random()-0.5)*math.pi*6,
                    })
                else
                    local rot0 = (shp=="dm") and (45+math.random(-12,12)) or math.random(0,359)
                    local PAD  = 7
                    local f    = Instance.new("Frame")
                    f.AnchorPoint=Vector2.new(0.5,0.5); f.BackgroundColor3=Color3.fromRGB(255,255,255)
                    f.BackgroundTransparency=0.68; f.BorderSizePixel=0
                    f.Size=UDim2.fromOffset(sz+PAD*2,sz+PAD*2); f.Position=UDim2.fromOffset(cx,cy)
                    f.ZIndex=96; f.Rotation=rot0; f.ClipsDescendants=false
                    Instance.new("UICorner",f).CornerRadius = (shp=="cr") and UDim.new(1,0) or UDim.new(0,3+PAD)
                    local inner = Instance.new("Frame")
                    inner.AnchorPoint=Vector2.new(0.5,0.5); inner.BackgroundColor3=Color3.fromRGB(0,0,0)
                    inner.BackgroundTransparency=0; inner.BorderSizePixel=0
                    inner.Size=UDim2.fromOffset(sz,sz); inner.Position=UDim2.new(0.5,0,0.5,0); inner.ZIndex=97
                    Instance.new("UICorner",inner).CornerRadius = (shp=="cr") and UDim.new(1,0) or UDim.new(0,3)
                    local st=Instance.new("UIStroke"); st.Color=WHITE; st.Thickness=1.3; st.Transparency=0.2; st.Parent=inner
                    inner.Parent=f; f.Parent=Gui
                    table.insert(frags, {
                        shp=shp, f=f, inner=inner, dead=false,
                        x=cx, y=cy, vx=vx, vy=vy,
                        rot=rot0, rotSpd=(math.random()-0.5)*220,
                    })
                end
            end

            for i = 1, 80 do
                local a = (i/80)*math.pi*2 + (math.random()-0.5)*0.45
                spawnFrag(uiCX, uiCY, a, math.random(7,17), SHAPES[i] or "sq", math.random(120,300))
            end
            
            for i = 1, 25 do
                local a = (i/25)*math.pi*2 + (math.random()-0.5)*0.5
                spawnFrag(barCX, barCY, a, math.random(5,12), BAR_SHP[i] or "sq", math.random(90,220))
            end

            local fallConn
            fallConn = RunService.Heartbeat:Connect(function(dt)
                local alive = 0
                for _, d in ipairs(frags) do
                    if d.dead then continue end
                    alive = alive + 1
                    d.vy = d.vy + GRAVITY * dt
                    d.x  = d.x  + d.vx * dt
                    d.y  = d.y  + d.vy * dt

                    if d.y > vp.Y + 80 then
                        d.dead = true; alive = alive - 1
                        if d.shp == "tr" then
                            for _, l in ipairs(d.lines) do l.Visible=false end
                        else
                            pcall(function() if d.f and d.f.Parent then d.f:Destroy() end end)
                        end
                        continue
                    end

                    if d.shp == "tr" then
                        d.rot = d.rot + d.rotSpd * dt
                        local pA,pB,pC = triPts(d.x, d.y, d.rot, math.max(d.sz,0.5))
                        local ls = d.lines
                        ls[1].From=pA; ls[1].To=pB; ls[1].Color=WHITE; ls[1].Thickness=1.5; ls[1].Transparency=0; ls[1].Visible=true
                        ls[2].From=pB; ls[2].To=pC; ls[2].Color=WHITE; ls[2].Thickness=1.5; ls[2].Transparency=0; ls[2].Visible=true
                        ls[3].From=pC; ls[3].To=pA; ls[3].Color=WHITE; ls[3].Thickness=1.5; ls[3].Transparency=0; ls[3].Visible=true
                        for k = 1, TRI_SL do
                            local t2  = k/(TRI_SL+1)
                            local lx1 = pA.X+(pB.X-pA.X)*t2; local ly1 = pA.Y+(pB.Y-pA.Y)*t2
                            local lx2 = pA.X+(pC.X-pA.X)*t2; local ly2 = pA.Y+(pC.Y-pA.Y)*t2
                            local sl  = ls[3+k]
                            sl.From=Vector2.new(lx1,ly1); sl.To=Vector2.new(lx2,ly2)
                            sl.Color=WHITE; sl.Thickness=1; sl.Transparency=0; sl.Visible=true
                        end
                    else
                        d.rot = d.rot + d.rotSpd * dt
                        pcall(function()
                            if d.f and d.f.Parent then
                                d.f.Position = UDim2.fromOffset(d.x, d.y)
                                d.f.Rotation = d.rot
                            end
                        end)
                    end
                end

                if alive <= 0 then
                    fallConn:Disconnect()
                    for _, d in ipairs(frags) do
                        if d.shp=="tr" and d.lines then
                            for _, l in ipairs(d.lines) do pcall(function() l:Remove() end) end
                        end
                    end
                    task.spawn(nukeAll)
                end
            end)
        end)
    end

    CloseBtn.Activated:Connect(function()
        CircleClick(CloseBtn, Player:GetMouse().X, Player:GetMouse().Y)

        local confOpened = true

        local ConfOverlay = Custom:Create("Frame", {
            BackgroundColor3    = Color3.fromRGB(0,0,0),
            BackgroundTransparency = 0.5,
            BorderSizePixel     = 0,
            Size                = UDim2.new(1,0,1,0),
            Position            = UDim2.new(0,0,0,0),
            ZIndex              = 200,
            Visible             = true,
            Name                = "ConfirmOverlay",
        }, Main)

        local OverlayClose = Custom:Create("TextButton", {
            Text="", BackgroundTransparency=1, BorderSizePixel=0,
            Size=UDim2.new(1,0,1,0), ZIndex=200,
        }, ConfOverlay)

        local ConfPanel = Custom:Create("Frame", {
            AnchorPoint         = Vector2.new(0.5,0.5),
            BackgroundColor3    = Color3.fromRGB(18,18,20),
            BackgroundTransparency = 1,           
            BorderSizePixel     = 0,
            Position            = UDim2.new(0.5,0,0.65,0),  
            Size                = UDim2.new(0,300,0,190),
            ZIndex              = 201,
            Name                = "ConfirmPanel",
        }, ConfOverlay)
        Custom:Create("UICorner", { CornerRadius=UDim.new(0,10) }, ConfPanel)
        Custom:Create("UIStroke", { Color=Color3.fromRGB(60,60,65), Thickness=1.5 }, ConfPanel)

        Custom:Create("Frame", {
            BackgroundTransparency=1, BorderSizePixel=0,
            Size=UDim2.new(1,0,0,40), ZIndex=202,
            Name="ConfTop",
        }, ConfPanel)
        Custom:Create("TextLabel", {
            Font=Enum.Font.GothamBold, Text="Close Script",
            TextColor3=Color3.fromRGB(220,220,220), TextSize=15,
            TextXAlignment=Enum.TextXAlignment.Center, TextYAlignment=Enum.TextYAlignment.Center,
            BackgroundTransparency=1, BorderSizePixel=0,
            Position=UDim2.new(0,0,0,0), Size=UDim2.new(1,0,0,40),
            ZIndex=202,
        }, ConfPanel)

        Custom:Create("Frame", {
            BackgroundColor3=Color3.fromRGB(55,55,60),
            BackgroundTransparency=0, BorderSizePixel=0,
            Position=UDim2.new(0,0,0,40), Size=UDim2.new(1,0,0,1),
            ZIndex=202,
        }, ConfPanel)

        local WarnCircle = Custom:Create("Frame", {
            AnchorPoint         = Vector2.new(0.5,0),
            BackgroundColor3    = Color3.fromRGB(200,140,0),
            BackgroundTransparency = 0.82,
            BorderSizePixel     = 0,
            Position            = UDim2.new(0.5,0,0,52),
            Size                = UDim2.new(0,46,0,46),
            ZIndex              = 202,
        }, ConfPanel)
        Custom:Create("UICorner", { CornerRadius=UDim.new(1,0) }, WarnCircle)

        Custom:Create("TextLabel", {
            Font=Enum.Font.GothamBold, Text="!",
            TextColor3=Color3.fromRGB(255,185,30), TextSize=28,
            TextXAlignment=Enum.TextXAlignment.Center, TextYAlignment=Enum.TextYAlignment.Center,
            BackgroundTransparency=1, BorderSizePixel=0,
            Position=UDim2.new(0,0,0,0), Size=UDim2.new(1,0,1,0),
            ZIndex=203,
        }, WarnCircle)

        Custom:Create("TextLabel", {
            Font=Enum.Font.Gotham, Text="Are you sure you want to close?\nAll active features will be disabled.",
            TextColor3=Color3.fromRGB(165,165,175), TextSize=13,
            TextXAlignment=Enum.TextXAlignment.Center, TextYAlignment=Enum.TextYAlignment.Center,
            BackgroundTransparency=1, BorderSizePixel=0,
            Position=UDim2.new(0,14,0,102), Size=UDim2.new(1,-28,0,40),
            ZIndex=202,
            TextWrapped=true,
        }, ConfPanel)

        local CancelBtn = Custom:Create("TextButton", {
            Font=Enum.Font.GothamBold, Text="No",
            TextColor3=Color3.fromRGB(200,200,205), TextSize=13,
            BackgroundColor3=Color3.fromRGB(35,35,42),
            BackgroundTransparency=0, BorderSizePixel=0,
            Position=UDim2.new(0,14,0,148), Size=UDim2.new(0.5,-20,0,34),
            ZIndex=202,
        }, ConfPanel)
        Custom:Create("UICorner", { CornerRadius=UDim.new(0,6) }, CancelBtn)
        Custom:Create("UIStroke", { Color=Color3.fromRGB(70,70,82), Thickness=1 }, CancelBtn)

        local OkBtn = Custom:Create("TextButton", {
            Font=Enum.Font.GothamBold, Text="Yes",
            TextColor3=Color3.fromRGB(255,255,255), TextSize=13,
            BackgroundColor3=Color3.fromRGB(160,48,48),
            BackgroundTransparency=0, BorderSizePixel=0,
            Position=UDim2.new(0.5,6,0,148), Size=UDim2.new(0.5,-20,0,34),
            ZIndex=202,
        }, ConfPanel)
        Custom:Create("UICorner", { CornerRadius=UDim.new(0,6) }, OkBtn)
        Custom:Create("UIStroke", { Color=Color3.fromRGB(200,75,75), Thickness=1 }, OkBtn)

        CancelBtn.MouseEnter:Connect(function()
            TweenService:Create(CancelBtn, TweenInfo.new(0.12), {BackgroundColor3=Color3.fromRGB(52,52,62)}):Play()
        end)
        CancelBtn.MouseLeave:Connect(function()
            TweenService:Create(CancelBtn, TweenInfo.new(0.12), {BackgroundColor3=Color3.fromRGB(35,35,42)}):Play()
        end)
        OkBtn.MouseEnter:Connect(function()
            TweenService:Create(OkBtn, TweenInfo.new(0.12), {BackgroundColor3=Color3.fromRGB(190,58,58)}):Play()
        end)
        OkBtn.MouseLeave:Connect(function()
            TweenService:Create(OkBtn, TweenInfo.new(0.12), {BackgroundColor3=Color3.fromRGB(160,48,48)}):Play()
        end)

        TweenService:Create(ConfPanel, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position            = UDim2.new(0.5,0,0.5,0),
            BackgroundTransparency = 0,
        }):Play()

        local function closeConfirm()
            if not confOpened then return end
            confOpened = false
            TweenService:Create(ConfOverlay, TweenInfo.new(0.22), {BackgroundTransparency=1}):Play()
            TweenService:Create(ConfPanel, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position            = UDim2.new(0.5,0,0.65,0),
                BackgroundTransparency = 1,
            }):Play()
            task.wait(0.22)
            ConfOverlay:Destroy()
        end

        OverlayClose.Activated:Connect(function() task.spawn(closeConfirm) end)

        CancelBtn.Activated:Connect(function() task.spawn(closeConfirm) end)

        OkBtn.Activated:Connect(function()
            if not confOpened then return end
            confOpened = false
            ConfOverlay:Destroy()
            animateCloseAndDestroy()
        end)
    end)
    
    local activateTab
    
    local _settingsTabIndex = nil
    local _lastTabIndex     = 0   
    local _uiToggleKey      = Enum.KeyCode.RightShift
    local _keepOnScreen     = true
    local _listeningKey     = false

    local function toggleSettings()
        if not _settingsTabIndex then return end
        local curOrder = LayersPageLayout.CurrentPage and LayersPageLayout.CurrentPage.LayoutOrder or 0
        if curOrder == _settingsTabIndex then
            
            activateTab(nil)
            for _, tf in pairs(ScrollTab:GetChildren()) do
                if tf.Name == "Tab" and tf.LayoutOrder == _lastTabIndex then
                    activateTab(tf)
                    break
                end
            end
            LayersPageLayout:JumpToIndex(_lastTabIndex)
            task.wait(0.05)
            
            for _, tf in pairs(ScrollTab:GetChildren()) do
                if tf.Name == "Tab" and tf.LayoutOrder == _lastTabIndex then
                    local lbl = tf:FindFirstChild("TabName")
                    if lbl then NameTab.Text = lbl.Text end
                    break
                end
            end
        else
            
            _lastTabIndex = curOrder
            activateTab(nil)
            LayersPageLayout:JumpToIndex(_settingsTabIndex)
            task.wait(0.05)
            NameTab.Text = "Settings"
        end
        TweenService:Create(SettingsBg:FindFirstChild("Img"),TweenInfo.new(0.2),
            {ImageColor3=Color3.fromRGB(200,200,200)}):Play()
    end

    _G._CosyToggleSettings = toggleSettings
    _G._CosyKeepOnScreen   = function(v) _keepOnScreen = v end
    _G._CosySetToggleKey   = function(kc) _uiToggleKey = kc end

    local _unlockMouse    = false
    local _origBehavior   = nil  
    local _origIconEnabled = true

    local _modalBtn = Instance.new("TextButton")
    _modalBtn.Name            = "CosyMouseModal"
    _modalBtn.Size            = UDim2.new(0, 0, 0, 0)
    _modalBtn.BackgroundTransparency = 1
    _modalBtn.Text            = ""
    _modalBtn.Modal           = false
    _modalBtn.ZIndex          = 999
    _modalBtn.Parent          = Gui

    local function _startMouseUnlock()
        
        if _origBehavior == nil then
            _origBehavior    = UIS.MouseBehavior
            _origIconEnabled = UIS.MouseIconEnabled
        end
        
        _modalBtn.Modal = true
        
        pcall(function() UIS.MouseIconEnabled = true end)
        
        pcall(function() RunService:UnbindFromRenderStep("CozyMouseUnlock") end)
        RunService:BindToRenderStep("CozyMouseUnlock",
            Enum.RenderPriority.Camera.Value + 1,
            function()
                pcall(function()
                    if UIS.MouseBehavior ~= Enum.MouseBehavior.Default then
                        UIS.MouseBehavior = Enum.MouseBehavior.Default
                    end
                    if not UIS.MouseIconEnabled then
                        UIS.MouseIconEnabled = true
                    end
                end)
            end
        )
    end

    local function _stopMouseUnlock()
        _modalBtn.Modal = false
        pcall(function() RunService:UnbindFromRenderStep("CozyMouseUnlock") end)
        
        if _origBehavior ~= nil then
            pcall(function() UIS.MouseBehavior   = _origBehavior end)
            pcall(function() UIS.MouseIconEnabled = _origIconEnabled end)
            _origBehavior   = nil
            _origIconEnabled = true
        end
    end

    _G._CosyUnlockMouse = function(v)
        _unlockMouse = v
        if v and ShadowHolder.Visible then
            _startMouseUnlock()
        elseif not v then
            _stopMouseUnlock()
        end
    end

    ShadowHolder:GetPropertyChangedSignal("Visible"):Connect(function()
        if not _unlockMouse then return end
        if ShadowHolder.Visible then
            _startMouseUnlock()
        else
            _stopMouseUnlock()
        end
    end)

    local _barVisConn = nil
    local function _hookSmartBar()
        local bar = Open_Close and Open_Close._bar
        if not bar or _barVisConn then return end
        _barVisConn = bar:GetPropertyChangedSignal("Visible"):Connect(function()
            if not _unlockMouse then return end
            
            if not bar.Visible and not ShadowHolder.Visible then
                _stopMouseUnlock()
            end
        end)
    end
    
    _hookSmartBar()
    task.defer(_hookSmartBar)

    SettingsBtn.Activated:Connect(function()
        CircleClick(SettingsBtn, Player:GetMouse().X, Player:GetMouse().Y)
        toggleSettings()
    end)

    UIS.InputBegan:Connect(function(inp, gp)
        if gp or _listeningKey then return end
        if inp.KeyCode == _uiToggleKey then
            if ShadowHolder.Visible then
                animateClose(function() Open_Close._showBar() end)
            else
                animateOpen()
            end
        end
    end)

    ShadowHolder:GetPropertyChangedSignal("Position"):Connect(function()
        if not _keepOnScreen then return end
        local vp = workspace.CurrentCamera.ViewportSize
        local p  = ShadowHolder.Position
        local sx = ShadowHolder.Size.X.Offset
        local sy = ShadowHolder.Size.Y.Offset
        local x  = math.clamp(p.X.Offset, 0, vp.X - sx)
        local y  = math.clamp(p.Y.Offset, 0, vp.Y - sy)
        if x ~= p.X.Offset or y ~= p.Y.Offset then
            ShadowHolder.Position = UDim2.fromOffset(x, y)
        end
    end)
    
    MakeDraggable(Top, ShadowHolder)

    local _searchIndex = {}

    activateTab = function(targetTab)
        for _, tf in pairs(ScrollTab:GetChildren()) do
            if tf.Name == "Tab" then
                TweenService:Create(tf, TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {BackgroundTransparency=0.999}):Play()
            end
        end
        if targetTab then
            TweenService:Create(targetTab, TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {BackgroundTransparency=0.72}):Play()
        end
    end

    local function pulseHighlight(frame)
        if not frame or not frame.Parent then return end
        local overlay = Instance.new("Frame")
        overlay.Name = "PulseOverlay"
        overlay.BackgroundColor3 = Color3.fromRGB(120, 180, 255)
        overlay.BackgroundTransparency = 1
        overlay.BorderSizePixel = 0
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.Position = UDim2.new(0, 0, 0, 0)
        overlay.ZIndex = (frame.ZIndex or 1) + 5
        local oc = Instance.new("UICorner")
        oc.CornerRadius = UDim.new(0, 4)
        oc.Parent = overlay
        overlay.Parent = frame
        
        TweenService:Create(overlay,
            TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { BackgroundTransparency = 0.72 }):Play()
        task.delay(0.5, function()
            TweenService:Create(overlay,
                TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                { BackgroundTransparency = 1 }):Play()
            task.delay(1.6, function()
                if overlay and overlay.Parent then overlay:Destroy() end
            end)
        end)
    end

    local function doSearch(query)
        
        for _, c in pairs(SearchResults:GetChildren()) do
            if c:IsA("Frame") or c:IsA("TextButton") then c:Destroy() end
        end

        query = string.lower(string.gsub(query, "^%s+", ""):gsub("%s+$", ""))
        if query == "" then
            SearchResults.Visible = false
            SearchResults.Size = UDim2.new(1,-12,0,0)
            return
        end

        local matches = {}
        for _, entry in ipairs(_searchIndex) do
            if string.find(string.lower(entry.title), query, 1, true) then
                table.insert(matches, entry)
                if #matches >= 6 then break end
            end
        end

        if #matches == 0 then
            
            local NR = Custom:Create("Frame", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1,0,0,28),
                LayoutOrder = 0,
                Name = "NoResult",
            }, SearchResults)
            Custom:Create("TextLabel", {
                Font = Enum.Font.Gotham,
                Text = "No results",
                TextColor3 = Color3.fromRGB(80,80,85),
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Center,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1,0,1,0),
            }, NR)
            SearchResults.Size = UDim2.new(1,-12,0,36)
            SearchResults.Visible = true
            return
        end

        for i, entry in ipairs(matches) do
            local Row = Custom:Create("TextButton", {
                Font = Enum.Font.Gotham,
                Text = "",
                BackgroundColor3 = Color3.fromRGB(26,26,28),
                BackgroundTransparency = 0.3,
                BorderSizePixel = 0,
                LayoutOrder = i,
                Size = UDim2.new(1,0,0,30),
                Name = "SRRow",
                ZIndex = 11,
            }, SearchResults)
            Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Row)

            Custom:Create("TextLabel", {
                Font = Enum.Font.GothamBold,
                Text = entry.title,
                TextColor3 = Color3.fromRGB(220,220,220),
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0,8,0,0),
                Size     = UDim2.new(1,-8,0.55,0),
                ZIndex   = 12,
            }, Row)
            
            Custom:Create("TextLabel", {
                Font = Enum.Font.Gotham,
                Text = entry.tabName .. (entry.sectionName ~= "" and (" › " .. entry.sectionName) or ""),
                TextColor3 = Color3.fromRGB(90,90,95),
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0,8,0.55,0),
                Size     = UDim2.new(1,-8,0.45,0),
                ZIndex   = 12,
            }, Row)

            Row.MouseEnter:Connect(function()
                TweenService:Create(Row, TweenInfo.new(0.12), {BackgroundTransparency=0.1}):Play()
            end)
            Row.MouseLeave:Connect(function()
                TweenService:Create(Row, TweenInfo.new(0.12), {BackgroundTransparency=0.3}):Play()
            end)

            Row.Activated:Connect(function()
                entry.jumpFn()
                
                if entry.scrollFrame and entry.targetFrame then
                    task.spawn(function()
                        task.wait(0.45) 
                        local sf  = entry.scrollFrame
                        local tf  = entry.targetFrame
                        if not sf or not sf.Parent or not tf or not tf.Parent then return end
                        
                        local targetY = tf.AbsolutePosition.Y - sf.AbsolutePosition.Y + sf.CanvasPosition.Y
                        
                        local viewH = sf.AbsoluteSize.Y
                        local elemH = tf.AbsoluteSize.Y
                        local scrollY = math.max(0, targetY - (viewH - elemH) / 2)
                        local maxScroll = math.max(0, sf.AbsoluteCanvasSize.Y - viewH)
                        scrollY = math.clamp(scrollY, 0, maxScroll)
                        TweenService:Create(sf,
                            TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            { CanvasPosition = Vector2.new(0, scrollY) }):Play()
                    end)
                end
                SearchBox.Text = ""
                SearchResults.Visible = false
                SearchResults.Size = UDim2.new(1,-12,0,0)
            end)
        end

        local rowH = 30
        local pad  = 8 + 2*(#matches-1)
        SearchResults.Size = UDim2.new(1,-12,0, pad + rowH*#matches)
        SearchResults.Visible = true
    end

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        doSearch(SearchBox.Text)
    end)
    
    SearchBox.FocusLost:Connect(function()
        task.wait(0.15)
        SearchResults.Visible = false
    end)

    local Tabs     = {}
    local CountTab = 0
    local CountDropdown = 0

    function Tabs:CreateTab(Config)
        local _Name = Config[1] or Config.Name or ""
        local Icon  = Config[2] or Config.Icon or ""
        local _tabIndex = CountTab  

        local ScrolLayers = Custom:Create("ScrollingFrame", {
            ScrollBarImageColor3 = Color3.fromRGB(80,80,80),
            ScrollBarThickness   = 0,
            Active = true,
            LayoutOrder = CountTab,
            BackgroundTransparency = 0.999,
            BorderSizePixel = 0,
            Size   = UDim2.new(1,0,1,0),
            Name   = "ScrolLayers",
        }, LayersFolder)
        Custom:Create("UIListLayout", {
            Padding   = UDim.new(0,3),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }, ScrolLayers)

        local Tab = Custom:Create("Frame", {
            BackgroundColor3 = Color3.fromRGB(80, 80, 90),
            BackgroundTransparency = CountTab==0 and 0.72 or 0.999,
            BorderSizePixel = 0,
            LayoutOrder = CountTab,
            Size = UDim2.new(1,0,0,30),
            Name = "Tab",
        }, ScrollTab)
        Custom:Create("UICorner", { CornerRadius=UDim.new(0,5) }, Tab)

        local TabButton = Custom:Create("TextButton", {
            Font  = Enum.Font.GothamBold,
            Text  = "",
            TextColor3 = Color3.fromRGB(255,255,255),
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 0.999,
            BorderSizePixel = 0,
            Size = UDim2.new(1,0,1,0),
            Name = "TabButton",
        }, Tab)

        local TabNameLabel = Custom:Create("TextLabel", {
            Font  = Enum.Font.GothamBold,
            Text  = _Name,
            TextColor3 = Color3.fromRGB(255,255,255),
            TextTransparency = 0,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundTransparency = 0.999,
            BorderSizePixel = 0,
            Size     = UDim2.new(1,-40,1,0),
            Position = UDim2.new(0,32,0,0),
            Name     = "TabName",
        }, Tab)
        
        task.defer(function()
            local textW = TabNameLabel.TextBounds.X
            local needed = textW + 32 + 12  
            if needed > Tab.AbsoluteSize.X then
                local extra = needed - Tab.AbsoluteSize.X
                
                LayersTab.Size = UDim2.new(0, LayersTab.Size.X.Offset + extra, 1, -41)
                Layers.Position = UDim2.new(0, Layers.Position.X.Offset + extra, 0, 50)
                Layers.Size = UDim2.new(1, Layers.Size.X.Offset - extra, 1, -59)
            end
        end)

        Custom:Create("ImageLabel", {
            Image  = Icon,
            BackgroundTransparency = 0.999,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0,9,0.5,0),
            Size     = UDim2.new(0,16,0,16),
            Name     = "FeatureImg",
        }, Tab)

        if CountTab == 0 then
            LayersPageLayout:JumpToIndex(0)
            NameTab.Text = _Name
        end

        TabButton.MouseEnter:Connect(function()
            if Tab.BackgroundTransparency > 0.85 then
                TweenService:Create(Tab, TweenInfo.new(0.12), {BackgroundTransparency=0.88}):Play()
            end
        end)
        TabButton.MouseLeave:Connect(function()
            if Tab.BackgroundTransparency > 0.85 then
                TweenService:Create(Tab, TweenInfo.new(0.18), {BackgroundTransparency=0.999}):Play()
            end
        end)

        TabButton.Activated:Connect(function()
            CircleClick(TabButton, Player:GetMouse().X, Player:GetMouse().Y)
            if Tab.LayoutOrder ~= LayersPageLayout.CurrentPage.LayoutOrder then
                activateTab(Tab)
                LayersPageLayout:JumpToIndex(Tab.LayoutOrder)
                task.wait(0.05)
                NameTab.Text = _Name
            end
        end)

        local Sections    = {}
        local CountSection = 0

        function Sections:AddSection(Title, OpenSection)
            Title       = Title or ""
            OpenSection = OpenSection or false
            local _sectionTitle = Title  

            local Section = Custom:Create("Frame", {
                BackgroundTransparency = 0.999,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                LayoutOrder = CountSection,
                Size = UDim2.new(1,0,0,30),
                Name = "Section"
            }, ScrolLayers)

            local SectionReal = Custom:Create("Frame", {
                AnchorPoint = Vector2.new(0.5,0),
                BackgroundColor3 = Color3.fromRGB(20, 20, 22),
                BackgroundTransparency = 0.88,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5,0,0,0),
                Size     = UDim2.new(1,1,0,30),
                Name     = "SectionReal"
            }, Section)
            Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, SectionReal)

            local SectionButton = Custom:Create("TextButton", {
                Text  = "",
                BackgroundTransparency = 0.999,
                BorderSizePixel = 0,
                Size  = UDim2.new(1,0,1,0),
                Name  = "SectionButton"
            }, SectionReal)

            local FeatureFrame = Custom:Create("Frame", {
                AnchorPoint = Vector2.new(1,0.5),
                BackgroundTransparency = 0.999,
                BorderSizePixel = 0,
                Position = UDim2.new(1,-5,0.5,0),
                Size     = UDim2.new(0,20,0,20),
                Name     = "FeatureFrame"
            }, SectionReal)

            local FeatureImg = Custom:Create("ImageLabel", {
                Image    = "rbxassetid://125609963478878",
                AnchorPoint = Vector2.new(0.5,0.5),
                BackgroundTransparency = 0.999,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5,0,0.5,0),
                Rotation = -90,
                Size     = UDim2.new(1,6,1,6),
                Name     = "FeatureImg"
            }, FeatureFrame)

            Custom:Create("TextLabel", {
                Font  = Enum.Font.GothamBold,
                Text  = Title,
                TextColor3 = Color3.fromRGB(230,230,230),
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                AnchorPoint = Vector2.new(0,0.5),
                BackgroundTransparency = 0.999,
                BorderSizePixel = 0,
                Position = UDim2.new(0,10,0.5,0),
                Size     = UDim2.new(1,-50,0,13),
                Name     = "SectionTitle"
            }, SectionReal)

            local SectionDecideFrame = Custom:Create("Frame", {
                BackgroundColor3 = Color3.fromRGB(18, 18, 20),
                BorderSizePixel  = 0,
                AnchorPoint = Vector2.new(0.5,0),
                Position = UDim2.new(0.5,0,0,33),
                Size     = UDim2.new(0,0,0,2),
                Name     = "SectionDecideFrame"
            }, Section)
            Custom:Create("UICorner", {}, SectionDecideFrame)
            Custom:Create("UIGradient", {
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(18,18,20)),
                    ColorSequenceKeypoint.new(0.5, Custom.ColorRGB),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(18,18,20)),
                }
            }, SectionDecideFrame)

            local SectionAdd = Custom:Create("Frame", {
                AnchorPoint = Vector2.new(0.5,0),
                BackgroundTransparency = 0.999,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                LayoutOrder = 1,
                Position = UDim2.new(0.5,0,0,38),
                Size     = UDim2.new(1,0,0,100),
                Name     = "SectionAdd"
            }, Section)
            Custom:Create("UICorner", { CornerRadius=UDim.new(0,2) }, SectionAdd)
            Custom:Create("UIListLayout", { Padding=UDim.new(0,3), SortOrder=Enum.SortOrder.LayoutOrder }, SectionAdd)

            local function UpdateSizeScroll()
                local off = 0
                for _, child in pairs(ScrolLayers:GetChildren()) do
                    if child.Name ~= "UIListLayout" then
                        off = off + 3 + child.Size.Y.Offset
                    end
                end
                ScrolLayers.CanvasSize = UDim2.new(0,0,0,off)
            end

            local function UpdateSizeSection()
                if OpenSection then
                    local h = 38
                    for _, v in pairs(SectionAdd:GetChildren()) do
                        if v.Name ~= "UIListLayout" and v.Name ~= "UICorner" then
                            h = h + v.Size.Y.Offset + 3
                        end
                    end
                    TweenService:Create(FeatureFrame, TweenInfo.new(0.1), {Rotation=90}):Play()
                    TweenService:Create(Section,  TweenInfo.new(0.1), {Size=UDim2.new(1,1,0,h)}):Play()
                    TweenService:Create(SectionAdd, TweenInfo.new(0.1), {Size=UDim2.new(1,0,0,h-38)}):Play()
                    TweenService:Create(SectionDecideFrame, TweenInfo.new(0.1), {Size=UDim2.new(1,0,0,2)}):Play()
                    task.wait(0.5)
                    UpdateSizeScroll()
                end
            end

            local function ToggleSection()
                CircleClick(SectionButton, Player:GetMouse().X, Player:GetMouse().Y)
                if OpenSection then
                    TweenService:Create(FeatureFrame, TweenInfo.new(0.1), {Rotation=0}):Play()
                    TweenService:Create(Section, TweenInfo.new(0.1), {Size=UDim2.new(1,1,0,30)}):Play()
                    TweenService:Create(SectionDecideFrame, TweenInfo.new(0.1), {Size=UDim2.new(0,0,0,2)}):Play()
                    OpenSection = false
                    task.wait(0.1); UpdateSizeScroll()
                else
                    OpenSection = true
                    UpdateSizeSection()
                end
            end

            SectionButton.Activated:Connect(ToggleSection)
            SectionAdd.ChildAdded:Connect(UpdateSizeSection)
            SectionAdd.ChildRemoved:Connect(UpdateSizeSection)
            UpdateSizeScroll()

            local Item      = {}
            local ItemCount = 0

            function Item:AddParagraph(Config)
                local T = Config[1] or Config.Title or ""
                local C = Config[2] or Config.Content or ""
                local SF = {}

                local P = Custom:Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(18, 18, 20),
                    BackgroundTransparency = 0.88,
                    BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                    Size = UDim2.new(1,0,0,35),
                    Name = "Paragraph",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, P)

                local PT = Custom:Create("TextLabel", {
                    Font  = Enum.Font.GothamBold,
                    Text  = T,
                    TextColor3 = Color3.fromRGB(231,231,231),
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    BackgroundTransparency = 0.999,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0,10,0,10),
                    Size     = UDim2.new(1,-16,0,13),
                    Name     = "PTitle",
                }, P)

                local PC = Custom:Create("TextLabel", {
                    Font  = Enum.Font.GothamBold,
                    Text  = C,
                    TextColor3 = Color3.fromRGB(255,255,255),
                    TextSize = 12,
                    TextTransparency = 0.6,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Bottom,
                    BackgroundTransparency = 0.999,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0,10,0,23),
                    Name     = "PContent",
                }, P)

                local function Update()
                    PC.TextWrapped = false
                    local lines = math.ceil(PC.TextBounds.X / math.max(PC.AbsoluteSize.X,1))
                    PC.Size = UDim2.new(1,-16,0,12+(12*lines))
                    P.Size  = UDim2.new(1,0,0,PC.AbsoluteSize.Y+33)
                    PC.TextWrapped = true
                    UpdateSizeSection()
                end
                Update()
                PC:GetPropertyChangedSignal("AbsoluteSize"):Connect(Update)

                function SF:Set(Config)
                    PT.Text = Config[1] or Config.Title or ""
                    PC.Text = Config[2] or Config.Content or ""
                    Update()
                end
                ItemCount += 1
                return SF
            end

            function Item:AddSeperator(Config)
                local T = Config[1] or Config.Title or ""
                local SF = {}

                local S = Custom:Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(28, 28, 30),
                    BackgroundTransparency = 0.1,
                    BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                    Size = UDim2.new(1,0,0,30),
                    Name = "Seperator",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,6) }, S)

                Custom:Create("TextLabel", {
                    Font  = Enum.Font.GothamBold,
                    Text  = T,
                    TextColor3 = Color3.fromRGB(231,231,231),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0,12,0,0),
                    Size     = UDim2.new(1,-16,1,0),
                    Name     = "Title",
                }, S)

                function SF:Set(Config)
                    S:FindFirstChild("Title").Text = Config[1] or Config.Title or ""
                end
                ItemCount += 1
                return SF
            end

            function Item:AddLine()
                local L = Custom:Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(90,90,90),
                    BackgroundTransparency = 0.2,
                    BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                    Size = UDim2.new(1,0,0,7),
                    Name = "Line",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,3) }, L)
                ItemCount += 1
                return {}
            end

            function Item:AddButton(Config)
                local T  = Config[1] or Config.Title or ""
                local C  = Config[2] or Config.Content or ""
                local Ic = Config[3] or Config.Icon or "rbxassetid://7734010488"
                local CB = Config[4] or Config.Callback or function() end
                local BF = {}

                local btnH = (C and C ~= "") and 48 or 35

                local B = Custom:Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(18, 18, 20),
                    BackgroundTransparency = 0.88,
                    BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                    Size = UDim2.new(1,0,0,btnH),
                    Name = "Button",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,5) }, B)
                Custom:Create("UIStroke", {
                    Color = Color3.fromRGB(50, 50, 55),
                    Thickness = 0.8,
                    Transparency = 0.5,
                }, B)

                local IconBg = Custom:Create("Frame", {
                    AnchorPoint = Vector2.new(1,0.5),
                    BackgroundColor3 = Color3.fromRGB(22, 22, 25),
                    BackgroundTransparency = 0.80,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1,-10,0.5,0),
                    Size = UDim2.new(0,26,0,26),
                    Name = "IconBg",
                }, B)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,6) }, IconBg)
                Custom:Create("ImageLabel", {
                    Image = Ic,
                    AnchorPoint = Vector2.new(0.5,0.5),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.5,0,0.5,0),
                    Size = UDim2.new(0,16,0,16),
                    Name = "Img",
                }, IconBg)

                local titleY = (C and C ~= "") and 10 or 0
                local titleAnchor = (C and C ~= "") and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
                Custom:Create("TextLabel", {
                    Font = Enum.Font.GothamBold,
                    Text = T,
                    TextColor3 = Color3.fromRGB(235,235,235),
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = titleAnchor,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0,12,0,titleY),
                    Size = UDim2.new(1,-50,0,btnH - titleY*2),
                    Name = "ButtonTitle",
                }, B)

                if C and C ~= "" then
                    Custom:Create("TextLabel", {
                        Font = Enum.Font.Gotham,
                        Text = C,
                        TextColor3 = Color3.fromRGB(200,200,200),
                        TextSize = 11,
                        TextTransparency = 0.45,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextWrapped = true,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0,12,0,26),
                        Size = UDim2.new(1,-50,0,16),
                        Name = "ButtonContent",
                    }, B)
                end

                local BB = Custom:Create("TextButton", {
                    Text = "",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1,0,1,0),
                    Name = "BBut",
                }, B)

                BB.MouseEnter:Connect(function()
                    TweenService:Create(B, TweenInfo.new(0.15), {BackgroundTransparency=0.80}):Play()
                end)
                BB.MouseLeave:Connect(function()
                    TweenService:Create(B, TweenInfo.new(0.15), {BackgroundTransparency=0.88}):Play()
                end)

                BB.Activated:Connect(function()
                    CircleClick(BB, Player:GetMouse().X, Player:GetMouse().Y)
                    CB()
                end)
                
                table.insert(_searchIndex, {
                    title       = T,
                    tabName     = _Name,
                    sectionName = _sectionTitle,
                    targetFrame = B,
                    scrollFrame = ScrolLayers,
                    jumpFn      = function()
                        local myTab = nil
                        for _, tf in pairs(ScrollTab:GetChildren()) do
                            if tf.Name == "Tab" and tf.LayoutOrder == _tabIndex then myTab = tf; break end
                        end
                        activateTab(myTab)
                        LayersPageLayout:JumpToIndex(_tabIndex)
                        task.wait(0.05); NameTab.Text = _Name
                        if not OpenSection then OpenSection = true; UpdateSizeSection() end
                        task.wait(0.35)
                        pulseHighlight(B)
                    end
                })
                ItemCount += 1
                return BF
            end

            function Item:AddToggle(Config)
                local T   = Config[1] or Config.Title or ""
                local C   = Config[2] or Config.Content or ""
                local Def = Config[3] or Config.Default or false
                local CB  = Config[4] or Config.Callback or function() end
                local FT  = { Value = Def }

                local hasContent = C and C ~= ""
                local togH = hasContent and 48 or 35

                local Tog = Custom:Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(18, 18, 20),
                    BackgroundTransparency = 0.88,
                    BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                    Size = UDim2.new(1,0,0,togH),
                    Name = "Toggle",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Tog)

                local titleAnchor = hasContent and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
                local titlePosY   = hasContent and 9 or 0
                local TT = Custom:Create("TextLabel", {
                    Font  = Enum.Font.GothamBold,
                    Text  = T,
                    TextSize = 13,
                    TextColor3 = Color3.fromRGB(231,231,231),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = titleAnchor,
                    BackgroundTransparency = 0.999,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0,10,0,titlePosY),
                    Size     = UDim2.new(1,-100,0,togH - titlePosY*2),
                    Name     = "TT",
                }, Tog)

                if hasContent then
                    local TC = Custom:Create("TextLabel", {
                        Font  = Enum.Font.GothamBold,
                        Text  = C,
                        TextSize = 11,
                        TextColor3 = Color3.fromRGB(255,255,255),
                        TextTransparency = 0.5,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextWrapped = true,
                        BackgroundTransparency = 0.999,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0,10,0,25),
                        Size     = UDim2.new(1,-110,0,14),
                        Name     = "TC",
                    }, Tog)
                    task.defer(function()
                        local lines = math.max(1, math.ceil(TC.TextBounds.X / math.max(TC.AbsoluteSize.X,1)))
                        if lines > 1 then
                            Tog.Size = UDim2.new(1,0,0,togH + (lines-1)*13)
                        end
                    end)
                end

                local TB = Custom:Create("TextButton", {
                    Text  = "",
                    BackgroundTransparency = 0.999,
                    BorderSizePixel = 0,
                    Size  = UDim2.new(1,0,1,0),
                    Name  = "TBtn",
                }, Tog)

                local Track = Custom:Create("Frame", {
                    AnchorPoint = Vector2.new(1,0.5),
                    BackgroundColor3 = Color3.fromRGB(22, 22, 25),
                    BackgroundTransparency = 0.85,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1,-15,0.5,0),
                    Size     = UDim2.new(0,30,0,15),
                    Name     = "Track",
                }, Tog)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Track)
                local Stroke8 = Custom:Create("UIStroke", { Color=Color3.fromRGB(255,255,255), Thickness=2, Transparency=0.9 }, Track)

                local Knob = Custom:Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(80, 80, 85),
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Size     = UDim2.new(0,14,0,14),
                    Position = UDim2.new(0,0,0.5,0),
                    Name     = "Knob",
                }, Track)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,15) }, Knob)

                local function Animate(on)
                    local tc  = on and Custom.ColorRGB or Color3.fromRGB(230,230,230)
                    local kp  = on and UDim2.new(0,15,0.5,0) or UDim2.new(0,0,0.5,0)
                    local sc  = on and Custom.ColorRGB or Color3.fromRGB(255,255,255)
                    local st  = on and 0 or 0.9
                    local fc  = on and Custom.ColorRGB or Color3.fromRGB(255,255,255)
                    local ft  = on and 0 or 0.92
                    local ti  = TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
                    TweenService:Create(TT,     ti, {TextColor3=tc}):Play()
                    TweenService:Create(Knob,   ti, {Position=kp}):Play()
                    TweenService:Create(Stroke8,ti, {Color=sc,Transparency=st}):Play()
                    TweenService:Create(Track,  ti, {BackgroundColor3=fc,BackgroundTransparency=ft}):Play()
                end

                TB.Activated:Connect(function()
                    CircleClick(TB, Player:GetMouse().X, Player:GetMouse().Y)
                    FT:Set(not FT.Value)
                end)

                table.insert(_searchIndex, {
                    title       = T,
                    tabName     = _Name,
                    sectionName = _sectionTitle,
                    targetFrame = Tog,
                    scrollFrame = ScrolLayers,
                    jumpFn      = function()
                        local myTab = nil
                        for _, tf in pairs(ScrollTab:GetChildren()) do
                            if tf.Name == "Tab" and tf.LayoutOrder == _tabIndex then myTab = tf; break end
                        end
                        activateTab(myTab)
                        LayersPageLayout:JumpToIndex(_tabIndex)
                        task.wait(0.05); NameTab.Text = _Name
                        if not OpenSection then OpenSection = true; UpdateSizeSection() end
                        task.wait(0.35)
                        pulseHighlight(Tog)
                    end
                })

                function FT:Set(v)
                    FT.Value = v
                    Animate(v)
                    task.defer(function() CB(v) end)
                end
                FT:Set(FT.Value)
                ItemCount += 1
                return FT
            end

            function Item:AddSlider(Config)
                local T   = Config[1] or Config.Title or ""
                local C   = Config[2] or Config.Content or ""   
                local Inc = Config[3] or Config.Increment or 1
                local Mn  = Config[4] or Config.Min or 0
                local Mx  = Config[5] or Config.Max or 100
                local Def = Config[6] or Config.Default or 50
                local CB  = Config[7] or Config.Callback or function() end
                local FS  = { Value = Def }

                local ROW1H = 28  
                local ROW2H = 20  
                local slH   = ROW1H + ROW2H + 8  

                local Sl = Custom:Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(18, 18, 20),
                    BackgroundTransparency = 0.88,
                    BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                    Size = UDim2.new(1,0,0,slH),
                    Name = "Slider",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Sl)

                local Row1 = Custom:Create("Frame", {
                    BackgroundTransparency = 1, BorderSizePixel = 0,
                    Position = UDim2.new(0,0,0,0),
                    Size = UDim2.new(1,0,0,ROW1H),
                    Name = "Row1",
                }, Sl)

                Custom:Create("TextLabel", {
                    Font = Enum.Font.GothamBold, Text = T,
                    TextColor3 = Color3.fromRGB(230,230,230), TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    BackgroundTransparency = 1, BorderSizePixel = 0,
                    Position = UDim2.new(0,10,0,0),
                    Size = UDim2.new(1,-90,1,0),
                    Name = "ST",
                }, Row1)

                local unitW = (C and C ~= "") and 22 or 0
                if C and C ~= "" then
                    Custom:Create("TextLabel", {
                        Font = Enum.Font.GothamBold, Text = C,
                        TextColor3 = Color3.fromRGB(140,140,140), TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Center,
                        BackgroundTransparency = 1, BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(1,0),
                        Position = UDim2.new(1,-10,0,0),
                        Size = UDim2.new(0,unitW,1,0),
                        Name = "SUnit",
                    }, Row1)
                end

                local TBox = Custom:Create("TextBox", {
                    Font = Enum.Font.GothamBold, Text = "0",
                    TextColor3 = Custom.ColorRGB, TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    AnchorPoint = Vector2.new(1,0),
                    BackgroundTransparency = 1, BorderSizePixel = 0,
                    ClearTextOnFocus = false,
                    Position = UDim2.new(1, -(10 + unitW + 4), 0, 0),
                    Size = UDim2.new(0,36,1,0),
                    Name = "TBox",
                }, Row1)

                local Row2 = Custom:Create("Frame", {
                    BackgroundTransparency = 1, BorderSizePixel = 0,
                    Position = UDim2.new(0,0,0,ROW1H),
                    Size = UDim2.new(1,0,0,ROW2H),
                    Name = "Row2",
                }, Sl)

                local SFrame = Custom:Create("Frame", {
                    AnchorPoint = Vector2.new(1,0.5),
                    BackgroundColor3 = Color3.fromRGB(30, 30, 33),
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1,-10,0.5,0),
                    Size = UDim2.new(0,120,0,5),
                    Name = "SFrame",
                }, Row2)
                Custom:Create("UICorner", { CornerRadius=UDim.new(1,0) }, SFrame)

                local SDrag = Custom:Create("Frame", {
                    AnchorPoint = Vector2.new(0,0.5),
                    BackgroundColor3 = Custom.ColorRGB,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0,0,0.5,0),
                    Size = UDim2.new(0,0,1,0),
                    Name = "SDrag",
                }, SFrame)
                Custom:Create("UICorner", { CornerRadius=UDim.new(1,0) }, SDrag)

                local SCircle = Custom:Create("Frame", {
                    AnchorPoint = Vector2.new(0.5,0.5),
                    BackgroundColor3 = Color3.fromRGB(180,180,180),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0,0,0.5,0),
                    Size = UDim2.new(0,14,0,14),
                    Name = "SCircle",
                }, SFrame)
                Custom:Create("UICorner", { CornerRadius=UDim.new(1,0) }, SCircle)

                local Dragging = false

                local function Round(n, f)
                    local r = math.floor(n/f + math.sign(n)*0.5)*f
                    if r < 0 then r = r + f end
                    return r
                end

                function FS:Set(v)
                    v = math.clamp(Round(v,Inc), Mn, Mx)
                    FS.Value = v
                    TBox.Text = tostring(v)
                    local pct = (Mx == Mn) and 0 or (v-Mn)/(Mx-Mn)
                    local ti  = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(SDrag,   ti, { Size=UDim2.new(pct,0,1,0) }):Play()
                    TweenService:Create(SCircle, ti, { Position=UDim2.new(pct,0,0.5,0) }):Play()
                end

                SFrame.InputBegan:Connect(function(i)
                    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                        Dragging = true
                        local sc = math.clamp((i.Position.X - SFrame.AbsolutePosition.X) / SFrame.AbsoluteSize.X, 0, 1)
                        FS:Set(Mn + (Mx-Mn)*sc)
                    end
                end)
                SFrame.InputEnded:Connect(function(i)
                    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                        Dragging = false; CB(FS.Value)
                    end
                end)

                local _lx = nil
                UserInputService.InputChanged:Connect(function(i)
                    if not Dragging then return end
                    local cx = i.Position.X
                    if cx == _lx then return end
                    _lx = cx
                    local sc = math.clamp((cx - SFrame.AbsolutePosition.X) / SFrame.AbsoluteSize.X, 0, 1)
                    FS:Set(Mn + (Mx-Mn)*sc)
                end)

                TBox.FocusLost:Connect(function()
                    local v = tonumber(TBox.Text)
                    if v then FS:Set(v); CB(FS.Value)
                    else TBox.Text = tostring(FS.Value) end
                end)

                FS:Set(tonumber(Def)); CB(FS.Value)
                
                table.insert(_searchIndex, {
                    title       = T,
                    tabName     = _Name,
                    sectionName = _sectionTitle,
                    targetFrame = Sl,
                    scrollFrame = ScrolLayers,
                    jumpFn      = function()
                        local myTab = nil
                        for _, tf in pairs(ScrollTab:GetChildren()) do
                            if tf.Name == "Tab" and tf.LayoutOrder == _tabIndex then myTab = tf; break end
                        end
                        activateTab(myTab)
                        LayersPageLayout:JumpToIndex(_tabIndex)
                        task.wait(0.05); NameTab.Text = _Name
                        if not OpenSection then OpenSection = true; UpdateSizeSection() end
                        task.wait(0.35)
                        pulseHighlight(Sl)
                    end
                })
                ItemCount += 1
                return FS
            end

            function Item:AddInput(Config)
                local T   = Config[1] or Config.Title or ""
                local C   = Config[2] or Config.Content or ""
                local Def = Config[3] or Config.Default or ""
                local CB  = Config[4] or Config.Callback or function() end
                local FI  = { Value = Def }

                local inpHasContent = C and C ~= ""
                local inpH = inpHasContent and 48 or 35

                local Inp = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(18,18,20), BackgroundTransparency=0.88,
                    BorderSizePixel=0, LayoutOrder=ItemCount, Size=UDim2.new(1,0,0,inpH), Name="Input",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Inp)

                local inpTitleAnchor = inpHasContent and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
                local inpTitlePosY   = inpHasContent and 9 or 0
                Custom:Create("TextLabel", {
                    Font=Enum.Font.GothamBold, Text=T,
                    TextColor3=Color3.fromRGB(230,230,230), TextSize=13,
                    TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=inpTitleAnchor,
                    BackgroundTransparency=0.999, BorderSizePixel=0,
                    Position=UDim2.new(0,10,0,inpTitlePosY), Size=UDim2.new(1,-180,0,inpH - inpTitlePosY*2),
                }, Inp)
                if inpHasContent then
                    local InpC = Custom:Create("TextLabel", {
                        Font=Enum.Font.GothamBold, Text=C,
                        TextColor3=Color3.fromRGB(255,255,255), TextSize=11, TextTransparency=0.5,
                        TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top,
                        TextWrapped=true,
                        BackgroundTransparency=0.999, BorderSizePixel=0,
                        Position=UDim2.new(0,10,0,25), Size=UDim2.new(0.45,0,0,14), Name="SC",
                    }, Inp)
                    task.defer(function()
                        local lines = math.max(1, math.ceil(InpC.TextBounds.X / math.max(InpC.AbsoluteSize.X,1)))
                        if lines > 1 then
                            Inp.Size = UDim2.new(1,0,0,inpH + (lines-1)*13)
                        end
                    end)
                end

                local ifY = inpHasContent and UDim2.new(1,-7, 0, 9) or UDim2.new(1,-7, 0.5, 0)
                local IFrame = Custom:Create("Frame", {
                    AnchorPoint=Vector2.new(1, inpHasContent and 0 or 0.5),
                    BackgroundColor3=Color3.fromRGB(30,30,30), BackgroundTransparency=0.2,
                    BorderSizePixel=0, ClipsDescendants=true,
                    Position=ifY, Size=UDim2.new(0,148,0,30),
                }, Inp)
                Custom:Create("UIStroke", { Color=Color3.fromRGB(80,80,80), Thickness=1, Transparency=0.5 }, IFrame)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, IFrame)

                local ITB = Custom:Create("TextBox", {
                    Font=Enum.Font.GothamBold,
                    PlaceholderColor3=Color3.fromRGB(120,120,120),
                    PlaceholderText="Type here...",
                    Text="", TextColor3=Color3.fromRGB(255,255,255), TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Left,
                    AnchorPoint=Vector2.new(0,0.5),
                    BackgroundTransparency=0.999, BorderSizePixel=0,
                    Position=UDim2.new(0,5,0.5,0), Size=UDim2.new(1,-10,1,-8),
                }, IFrame)

                function FI:Set(v)
                    ITB.Text = v; FI.Value = v; CB(v)
                end
                ITB.FocusLost:Connect(function() FI:Set(ITB.Text) end)
                FI:Set(Def)
                ItemCount += 1
                return FI
            end

            function Item:AddXYZInput(Config)
                local T   = Config[1] or Config.Title or ""
                local Dx  = Config[2] or Config.DefaultX or "0"
                local Dy  = Config[3] or Config.DefaultY or "0"
                local Dz  = Config[4] or Config.DefaultZ or "0"
                local CB  = Config[5] or Config.Callback or function() end
                local FXY = { X=tonumber(Dx) or 0, Y=tonumber(Dy) or 0, Z=tonumber(Dz) or 0 }

                local Row = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(18,18,20), BackgroundTransparency=0.88,
                    BorderSizePixel=0, LayoutOrder=ItemCount, Size=UDim2.new(1,0,0,54), Name="XYZInput",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Row)

                Custom:Create("TextLabel", {
                    Font=Enum.Font.GothamBold, Text=T,
                    TextColor3=Color3.fromRGB(230,230,230), TextSize=13,
                    TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top,
                    BackgroundTransparency=0.999, BorderSizePixel=0,
                    Position=UDim2.new(0,10,0,8), Size=UDim2.new(1,-16,0,14),
                }, Row)

                local labels = {"X","Y","Z"}
                local defaults = {tostring(Dx), tostring(Dy), tostring(Dz)}
                local boxes = {}
                for i, lbl in ipairs(labels) do
                    local xOffset = 10 + (i-1) * (Row.AbsoluteSize.X > 0 and (Row.AbsoluteSize.X-20)/3 or 55)
                    local slot = Custom:Create("Frame", {
                        BackgroundTransparency=1, BorderSizePixel=0,
                        Position=UDim2.new((i-1)/3, i==1 and 10 or 4, 0, 22),
                        Size=UDim2.new(1/3, i==1 and -14 or (i==3 and -14 or -8), 0, 26),
                        Name="Slot"..lbl,
                    }, Row)

                    Custom:Create("TextLabel", {
                        Font=Enum.Font.GothamBold, Text=lbl,
                        TextColor3=Color3.fromRGB(180,180,180), TextSize=10,
                        TextXAlignment=Enum.TextXAlignment.Left,
                        BackgroundTransparency=0.999, BorderSizePixel=0,
                        Position=UDim2.new(0,0,0,0), Size=UDim2.new(0,14,0,12),
                    }, slot)

                    local box = Custom:Create("TextBox", {
                        Font=Enum.Font.GothamBold,
                        Text=defaults[i],
                        PlaceholderText=lbl,
                        PlaceholderColor3=Color3.fromRGB(100,100,100),
                        TextColor3=Color3.fromRGB(255,255,255), TextSize=12,
                        TextXAlignment=Enum.TextXAlignment.Center,
                        BackgroundColor3=Color3.fromRGB(30,30,30), BackgroundTransparency=0.2,
                        BorderSizePixel=0, ClipsDescendants=true,
                        Position=UDim2.new(0,14,0,0), Size=UDim2.new(1,-14,1,0),
                    }, slot)
                    Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, box)
                    Custom:Create("UIStroke", { Color=Color3.fromRGB(80,80,80), Thickness=1, Transparency=0.5 }, box)
                    boxes[lbl] = box

                    box.FocusLost:Connect(function()
                        local n = tonumber(box.Text)
                        if n then
                            FXY[lbl] = n
                            CB(FXY.X, FXY.Y, FXY.Z)
                        else
                            box.Text = tostring(FXY[lbl])
                        end
                    end)
                end

                function FXY:Set(x, y, z)
                    FXY.X = x or FXY.X; FXY.Y = y or FXY.Y; FXY.Z = z or FXY.Z
                    boxes["X"].Text = tostring(FXY.X)
                    boxes["Y"].Text = tostring(FXY.Y)
                    boxes["Z"].Text = tostring(FXY.Z)
                    CB(FXY.X, FXY.Y, FXY.Z)
                end

                ItemCount += 1
                return FXY
            end

            function Item:AddDropdown(Config)
                local T    = Config[1] or Config.Title or ""
                local C    = Config[2] or Config.Content or ""
                local Mul  = Config[3] or Config.Multi or false
                local Opts = Config[4] or Config.Options or {}
                local Def  = Config[5] or Config.Default or {}
                local CB   = Config[6] or Config.Callback or function() end
                local FD   = { Value = Def, Options = Opts }

                local ddHasContent = C and C ~= ""
                local ddH = ddHasContent and 48 or 35

                local DD = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(18,18,20), BackgroundTransparency=0.88,
                    BorderSizePixel=0, LayoutOrder=ItemCount, Size=UDim2.new(1,0,0,ddH), Name="Dropdown",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, DD)

                local DDB = Custom:Create("TextButton", {
                    Text="", BackgroundTransparency=0.999, BorderSizePixel=0,
                    Size=UDim2.new(1,0,1,0), Name="DDB",
                }, DD)

                local ddTitleAnchor = ddHasContent and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
                local ddTitlePosY   = ddHasContent and 9 or 0
                Custom:Create("TextLabel", {
                    Font=Enum.Font.GothamBold, Text=T,
                    TextColor3=Color3.fromRGB(230,230,230), TextSize=13,
                    TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=ddTitleAnchor,
                    BackgroundTransparency=0.999, BorderSizePixel=0,
                    Position=UDim2.new(0,10,0,ddTitlePosY), Size=UDim2.new(1,-180,0,ddH - ddTitlePosY*2),
                }, DD)
                if ddHasContent then
                    local DDC = Custom:Create("TextLabel", {
                        Font=Enum.Font.GothamBold, Text=C,
                        TextColor3=Color3.fromRGB(255,255,255), TextSize=11, TextTransparency=0.5,
                        TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top,
                        TextWrapped=true,
                        BackgroundTransparency=0.999, BorderSizePixel=0,
                        Position=UDim2.new(0,10,0,25), Size=UDim2.new(1,-190,0,14),
                    }, DD)
                    task.defer(function()
                        local lines = math.max(1, math.ceil(DDC.TextBounds.X / math.max(DDC.AbsoluteSize.X,1)))
                        if lines > 1 then
                            DD.Size = UDim2.new(1,0,0,ddH + (lines-1)*13)
                        end
                    end)
                end

                local SelFrame = Custom:Create("Frame", {
                    AnchorPoint=Vector2.new(1,0.5),
                    BackgroundColor3=Color3.fromRGB(255,255,255), BackgroundTransparency=0.95,
                    BorderSizePixel=0,
                    Position=UDim2.new(1,-7,0.5,0), Size=UDim2.new(0,148,0,30),
                    Name="SelFrame", LayoutOrder=CountDropdown,
                }, DD)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, SelFrame)

                local SelTxt = Custom:Create("TextLabel", {
                    Font=Enum.Font.GothamBold, Text="",
                    TextColor3=Color3.fromRGB(255,255,255), TextSize=12, TextTransparency=0.6,
                    TextXAlignment=Enum.TextXAlignment.Left,
                    AnchorPoint=Vector2.new(0,0.5),
                    BackgroundTransparency=0.999, BorderSizePixel=0,
                    Position=UDim2.new(0,5,0.5,0), Size=UDim2.new(1,-30,1,-8),
                }, SelFrame)

                local ArrowIcon = Custom:Create("ImageLabel", {
                    Image = "rbxassetid://6034818372", 
                    ImageColor3 = Color3.fromRGB(200, 200, 200),
                    ImageTransparency = 0,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -6, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    Name = "Arrow",
                }, SelFrame)

                local ScrollSel = Custom:Create("ScrollingFrame", {
                    CanvasSize=UDim2.new(0,0,0,0),
                    ScrollBarThickness=0, Active=true,
                    LayoutOrder=CountDropdown,
                    BackgroundTransparency=0.999, BorderSizePixel=0,
                    Size=UDim2.new(1,0,1,0), Name="ScrollSel",
                }, DropdownFolder)
                Custom:Create("UIListLayout", { Padding=UDim.new(0,3), SortOrder=Enum.SortOrder.LayoutOrder }, ScrollSel)

                local SearchWrap = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(20,20,20),
                    BackgroundTransparency=0,
                    BorderSizePixel=0,
                    LayoutOrder=0,
                    Size=UDim2.new(1,0,0,26),
                    Name="SearchWrap",
                }, ScrollSel)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, SearchWrap)
                Custom:Create("UIStroke", { Color=Color3.fromRGB(70,70,70), Thickness=1, Transparency=0.3 }, SearchWrap)

                local SearchBar = Custom:Create("TextBox", {
                    Font=Enum.Font.GothamBold, PlaceholderText="Search...",
                    PlaceholderColor3=Color3.fromRGB(110,110,110),
                    Text="", TextColor3=Color3.fromRGB(230,230,230), TextSize=11,
                    BackgroundTransparency=1,
                    BorderSizePixel=0,
                    AnchorPoint=Vector2.new(0,0.5),
                    Position=UDim2.new(0,8,0.5,0),
                    Size=UDim2.new(1,-16,1,-4),
                    Name="SearchBar",
                }, SearchWrap)

                SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
                    local q = string.lower(SearchBar.Text)
                    for _, v in pairs(ScrollSel:GetChildren()) do
                        if v:IsA("Frame") and v.Name == "Option" then
                            local ot = v:FindFirstChild("OptionText")
                            if ot then v.Visible = string.find(string.lower(ot.Text), q) ~= nil end
                        end
                    end
                end)

                local DropCount = 0

                function FD:Clear()
                    for _, df in pairs(ScrollSel:GetChildren()) do
                        if df.Name == "Option" then
                            FD.Value = {}; FD.Options = {}
                            SelTxt.Text = "Select Options"
                            df:Destroy()
                        end
                    end
                end

                function FD:Set(v)
                    FD.Value = v or FD.Value
                    local ti = TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
                    for _, d in pairs(ScrollSel:GetChildren()) do
                        if d.Name == "Option" then
                            local ot    = d:FindFirstChild("OptionText")
                            local found = ot and table.find(FD.Value, ot.Text)
                            
                            TweenService:Create(d, ti, {BackgroundTransparency=found and 0.85 or 0.999}):Play()

                        end
                    end
                    local joined = table.concat(FD.Value,", ")
                    SelTxt.Text  = joined ~= "" and joined or "Select Options"
                    CB(FD.Value)
                end

                function FD:AddOption(name)
                    name = name or "Option"
                    local Opt = Custom:Create("Frame", {
                        BackgroundColor3=Color3.fromRGB(255,255,255),
                        BackgroundTransparency=0.999, BorderSizePixel=0,
                        LayoutOrder=DropCount, Size=UDim2.new(1,0,0,30), Name="Option",
                    }, ScrollSel)
                    Custom:Create("UICorner", { CornerRadius=UDim.new(0,5) }, Opt)

                    local OB = Custom:Create("TextButton", {
                        Text="", BackgroundTransparency=0.999, BorderSizePixel=0,
                        Size=UDim2.new(1,0,1,0), Name="OptionButton",
                    }, Opt)

                    local OT = Custom:Create("TextLabel", {
                        Font=Enum.Font.GothamBold, Text=name,
                        TextColor3=Color3.fromRGB(230,230,230), TextSize=13,
                        TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Center,
                        BackgroundTransparency=0.999, BorderSizePixel=0,
                        Position=UDim2.new(0,10,0,0), Size=UDim2.new(1,-36,1,0),
                        Name="OptionText",
                    }, Opt)

                    OB.MouseEnter:Connect(function()
                        if Opt.BackgroundTransparency > 0.95 then
                            TweenService:Create(Opt, TweenInfo.new(0.15), {BackgroundTransparency=0.88}):Play()
                        end
                    end)
                    OB.MouseLeave:Connect(function()
                        if table.find(FD.Value, name) then return end
                        TweenService:Create(Opt, TweenInfo.new(0.15), {BackgroundTransparency=0.999}):Play()
                    end)

                    OB.Activated:Connect(function()
                        CircleClick(OB, Player:GetMouse().X, Player:GetMouse().Y)
                        local sel = table.find(FD.Value, name) == nil
                        if Mul then
                            if sel then
                                if not table.find(FD.Value, name) then table.insert(FD.Value, name) end
                            else
                                for i, vv in ipairs(FD.Value) do
                                    if vv == name then table.remove(FD.Value,i); break end
                                end
                            end
                        else
                            FD.Value = {name}
                        end
                        FD:Set(FD.Value)
                    end)

                    local function UpdateCanvas()
                        local off = 0
                        for _, ch in ipairs(ScrollSel:GetChildren()) do
                            if ch.Name ~= "UIListLayout" and ch.Name ~= "SearchBar" then
                                off = off + 5 + ch.Size.Y.Offset
                            end
                        end
                        ScrollSel.CanvasSize = UDim2.new(0,0,0,off)
                    end
                    UpdateCanvas()
                    DropCount += 1
                end

                function FD:Refresh(list, sel)
                    list = list or {}; sel = sel or {}
                    FD:Clear()
                    for _, d in ipairs(list) do FD:AddOption(d) end
                    FD.Options = list; FD:Set(sel)
                end

                local ddIsOpen = false
                local function setArrowOpen(open)
                    ddIsOpen = open
                    local targetRot = open and 180 or 0
                    local arrowCol  = open and Custom.ColorRGB or Color3.fromRGB(200,200,200)
                    local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(ArrowIcon, ti, {
                        Rotation       = targetRot,
                        ImageColor3    = arrowCol,
                        ImageTransparency = open and 0 or 0,
                    }):Play()
                    TweenService:Create(SelFrame, ti, {
                        BackgroundTransparency = open and 0.82 or 0.95,
                    }):Play()
                end

                DDB.Activated:Connect(function()
                    if not MoreBlur.Visible then
                        MoreBlur.Visible = true
                        DropPageLayout:JumpToIndex(SelFrame.LayoutOrder)
                        
                        DropdownSelect.Size = UDim2.new(0,160,0,0)
                        DropdownSelect.Position = UDim2.new(1,172,0.5,0)
                        DropdownSelect.BackgroundTransparency = 1
                        local ti = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                        TweenService:Create(MoreBlur, TweenInfo.new(0.15), {BackgroundTransparency=0.7}):Play()
                        TweenService:Create(DropdownSelect, ti, {
                            Position = UDim2.new(1,-11,0.5,0),
                            Size     = UDim2.new(0,160,1,-16),
                            BackgroundTransparency = 0,
                        }):Play()
                        setArrowOpen(true)
                        
                        _activeDropdownClose = function()
                            setArrowOpen(false)
                        end
                    end
                end)

                FD:Refresh(FD.Options, FD.Value)
                
                table.insert(_searchIndex, {
                    title       = T,
                    tabName     = _Name,
                    sectionName = _sectionTitle,
                    targetFrame = DD,
                    scrollFrame = ScrolLayers,
                    jumpFn      = function()
                        local myTab = nil
                        for _, tf in pairs(ScrollTab:GetChildren()) do
                            if tf.Name == "Tab" and tf.LayoutOrder == _tabIndex then myTab = tf; break end
                        end
                        activateTab(myTab)
                        LayersPageLayout:JumpToIndex(_tabIndex)
                        task.wait(0.05); NameTab.Text = _Name
                        if not OpenSection then OpenSection = true; UpdateSizeSection() end
                        task.wait(0.35)
                        pulseHighlight(DD)
                    end
                })
                ItemCount += 1; CountDropdown += 1
                return FD
            end

            function Item:AddColorPicker(Config)
                local T   = Config[1] or Config.Title or ""
                local Col = Config[2] or Config.Color or Color3.fromRGB(255,255,255)
                local CB  = Config[3] or Config.Callback or function() end
                local FCP = { Color = Col }

                local CP = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(18,18,20),
                    BackgroundTransparency=0.88,
                    BorderSizePixel=0,
                    LayoutOrder=ItemCount,
                    Size=UDim2.new(1,0,0,35),
                    Name="ColorPicker",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, CP)

                Custom:Create("TextLabel", {
                    Font=Enum.Font.GothamBold, Text=T,
                    TextColor3=Color3.fromRGB(231,231,231), TextSize=13,
                    TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Center,
                    BackgroundTransparency=1, BorderSizePixel=0,
                    Position=UDim2.new(0,10,0,0), Size=UDim2.new(1,-60,1,0),
                }, CP)

                local Display = Custom:Create("Frame", {
                    AnchorPoint=Vector2.new(1,0.5),
                    BackgroundColor3=Col,
                    BorderSizePixel=0,
                    Position=UDim2.new(1,-10,0.5,0),
                    Size=UDim2.new(0,36,0,22),
                    Name="Display",
                }, CP)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Display)
                Custom:Create("UIStroke", { Color=Color3.fromRGB(100,100,100), Thickness=1 }, Display)

                local Interact = Custom:Create("TextButton", {
                    Text="", BackgroundTransparency=1, BorderSizePixel=0,
                    Size=UDim2.new(1,0,1,0), ZIndex=5,
                }, CP)

                local Overlay = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(0,0,0),
                    BackgroundTransparency=0.5,
                    BorderSizePixel=0,
                    Size=UDim2.new(1,0,1,0),
                    Position=UDim2.new(0,0,0,0),
                    ZIndex=100,
                    Visible=false,
                    Name="CPOverlay",
                }, Main)

                local OverlayClose = Custom:Create("TextButton", {
                    Text="", BackgroundTransparency=1, BorderSizePixel=0,
                    Size=UDim2.new(1,0,1,0), ZIndex=100,
                }, Overlay)

                local Panel = Custom:Create("Frame", {
                    AnchorPoint=Vector2.new(0.5,0.5),
                    BackgroundColor3=Color3.fromRGB(18,18,18),
                    BackgroundTransparency=0,
                    BorderSizePixel=0,
                    Position=UDim2.new(0.5,0,0.5,0),
                    Size=UDim2.new(0,220,0,210),
                    ZIndex=101,
                    Name="CPPanel",
                }, Overlay)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,8) }, Panel)
                Custom:Create("UIStroke", { Color=Color3.fromRGB(60,60,60), Thickness=1.5 }, Panel)

                local PanelTop = Custom:Create("Frame", {
                    BackgroundTransparency=1, BorderSizePixel=0,
                    Size=UDim2.new(1,0,0,32), ZIndex=102,
                }, Panel)
                Custom:Create("TextLabel", {
                    Font=Enum.Font.GothamBold, Text=T,
                    TextColor3=Color3.fromRGB(220,220,220), TextSize=13,
                    TextXAlignment=Enum.TextXAlignment.Center, TextYAlignment=Enum.TextYAlignment.Center,
                    BackgroundTransparency=1, BorderSizePixel=0,
                    Position=UDim2.new(0,0,0,0), Size=UDim2.new(1,0,1,0),
                    ZIndex=102,
                }, PanelTop)

                Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(55,55,55),
                    BackgroundTransparency=0, BorderSizePixel=0,
                    Position=UDim2.new(0,0,0,32), Size=UDim2.new(1,0,0,1),
                    ZIndex=102,
                }, Panel)

                local CPBg = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromHSV(0,1,1),
                    BorderSizePixel=0,
                    Position=UDim2.new(0,10,0,40),
                    Size=UDim2.new(1,-20,0,100),
                    ZIndex=102,
                }, Panel)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, CPBg)

                local WhiteGrad = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(255,255,255),
                    BorderSizePixel=0, Size=UDim2.new(1,0,1,0), ZIndex=102,
                }, CPBg)
                Custom:Create("UIGradient", {
                    Color=ColorSequence.new{
                        ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
                        ColorSequenceKeypoint.new(1,Color3.fromRGB(255,255,255)),
                    },
                    Transparency=NumberSequence.new{
                        NumberSequenceKeypoint.new(0,0),
                        NumberSequenceKeypoint.new(1,1),
                    },
                    Rotation=0,
                }, WhiteGrad)

                local BlackGrad = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(0,0,0),
                    BorderSizePixel=0, Size=UDim2.new(1,0,1,0), ZIndex=102,
                }, CPBg)
                Custom:Create("UIGradient", {
                    Color=ColorSequence.new{
                        ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),
                        ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0)),
                    },
                    Transparency=NumberSequence.new{
                        NumberSequenceKeypoint.new(0,1),
                        NumberSequenceKeypoint.new(1,0),
                    },
                    Rotation=90,
                }, BlackGrad)

                local MainBtn = Custom:Create("TextButton", {
                    Text="", BackgroundTransparency=1, BorderSizePixel=0,
                    Size=UDim2.new(1,0,1,0), ZIndex=103,
                }, CPBg)

                local MainPoint = Custom:Create("Frame", {
                    AnchorPoint=Vector2.new(0.5,0.5),
                    BackgroundColor3=Color3.fromRGB(255,255,255),
                    BorderSizePixel=0, Size=UDim2.new(0,10,0,10),
                    Position=UDim2.new(1,0,0,0), ZIndex=104,
                }, CPBg)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,99) }, MainPoint)
                Custom:Create("UIStroke", { Color=Color3.fromRGB(255,255,255), Thickness=1.5 }, MainPoint)

                local HueSlider = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(0,0,0),
                    BackgroundTransparency=1,
                    BorderSizePixel=0,
                    Position=UDim2.new(0,10,0,150),
                    Size=UDim2.new(1,-20,0,12),
                    ZIndex=102,
                }, Panel)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,3) }, HueSlider)

                local HueGradFrame = Custom:Create("Frame", {
                    Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.fromRGB(255,255,255),
                    BackgroundTransparency=0, BorderSizePixel=0, ZIndex=102,
                }, HueSlider)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,3) }, HueGradFrame)
                Custom:Create("UIGradient", {
                    Color=ColorSequence.new{
                        ColorSequenceKeypoint.new(0,   Color3.fromRGB(255,0,0)),
                        ColorSequenceKeypoint.new(0.17,Color3.fromRGB(255,255,0)),
                        ColorSequenceKeypoint.new(0.33,Color3.fromRGB(0,255,0)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,255)),
                        ColorSequenceKeypoint.new(0.67,Color3.fromRGB(0,0,255)),
                        ColorSequenceKeypoint.new(0.83,Color3.fromRGB(255,0,255)),
                        ColorSequenceKeypoint.new(1,   Color3.fromRGB(255,0,0)),
                    },
                }, HueGradFrame)

                local HueBtn = Custom:Create("TextButton", {
                    Text="", BackgroundTransparency=1, BorderSizePixel=0,
                    Size=UDim2.new(1,0,1,0), ZIndex=103,
                }, HueSlider)

                local SliderPoint = Custom:Create("Frame", {
                    AnchorPoint=Vector2.new(0.5,0.5),
                    BackgroundColor3=Color3.fromRGB(255,255,255),
                    BorderSizePixel=0, Size=UDim2.new(0,14,0,14),
                    Position=UDim2.new(0,0,0.5,0), ZIndex=104,
                }, HueSlider)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,99) }, SliderPoint)
                Custom:Create("UIStroke", { Color=Color3.fromRGB(255,255,255), Thickness=1.5 }, SliderPoint)

                local HexFrame = Custom:Create("Frame", {
                    BackgroundColor3=Color3.fromRGB(30,30,30),
                    BorderSizePixel=0,
                    Position=UDim2.new(0,10,0,172),
                    Size=UDim2.new(1,-20,0,26),
                    ZIndex=102,
                }, Panel)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, HexFrame)
                Custom:Create("UIStroke", { Color=Color3.fromRGB(70,70,70), Thickness=1 }, HexFrame)

                local HexBox = Custom:Create("TextBox", {
                    Font=Enum.Font.GothamBold,
                    PlaceholderText="#FFFFFF",
                    PlaceholderColor3=Color3.fromRGB(100,100,100),
                    Text="", TextColor3=Color3.fromRGB(255,255,255), TextSize=12,
                    BackgroundTransparency=1, BorderSizePixel=0,
                    Size=UDim2.new(1,-8,1,0),
                    Position=UDim2.new(0,4,0,0),
                    ZIndex=103,
                }, HexFrame)

                local opened       = false
                local mainDragging = false
                local hueDragging  = false
                local mouse        = Player:GetMouse()
                local h, s, v2     = Col:ToHSV()

                local function setDisplay()
                    local c = Color3.fromHSV(h,s,v2)
                    CPBg.BackgroundColor3 = Color3.fromHSV(h,1,1)
                    
                    MainPoint.Position    = UDim2.new(s, -5, 1-v2, -5)
                    MainPoint.BackgroundColor3 = c
                    
                    SliderPoint.Position  = UDim2.new(h, -7, 0.5, 0)
                    SliderPoint.BackgroundColor3 = Color3.fromHSV(h,1,1)
                    Display.BackgroundColor3 = c
                    HexBox.Text = string.format("#%02X%02X%02X", c.R*0xFF, c.G*0xFF, c.B*0xFF)
                    FCP.Color   = c
                end
                setDisplay()

                local function openModal()
                    if opened then return end
                    opened = true
                    Overlay.Visible = true
                    Overlay.BackgroundTransparency = 1
                    Panel.Size = UDim2.new(0,0,0,0)
                    Panel.Position = UDim2.new(0.5,0,0.5,0)
                    Panel.BackgroundTransparency = 1
                    TweenService:Create(Overlay, TweenInfo.new(0.2), {BackgroundTransparency=0.5}):Play()
                    TweenService:Create(Panel, TweenInfo.new(0.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {
                        Size=UDim2.new(0,220,0,210),
                        BackgroundTransparency=0,
                    }):Play()
                    
                    setDisplay()
                    task.wait(0.3)
                    setDisplay()  
                end

                local function closeModal()
                    if not opened then return end
                    opened = false
                    mainDragging = false
                    hueDragging  = false
                    TweenService:Create(Overlay, TweenInfo.new(0.22), {BackgroundTransparency=1}):Play()
                    TweenService:Create(Panel, TweenInfo.new(0.22,Enum.EasingStyle.Quad,Enum.EasingDirection.In), {
                        Position=UDim2.new(0.5,0,0.65,0),
                        BackgroundTransparency=1,
                    }):Play()
                    task.wait(0.22)
                    Overlay.Visible = false
                    Panel.Position = UDim2.new(0.5,0,0.5,0)
                    Panel.BackgroundTransparency = 0
                end

                Interact.Activated:Connect(function() task.spawn(openModal) end)
                OverlayClose.Activated:Connect(function() task.spawn(closeModal) end)

                UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1
                    or inp.UserInputType == Enum.UserInputType.Touch then
                        if mainDragging or hueDragging then
                            pcall(function() CB(Color3.fromHSV(h,s,v2)) end)
                        end
                        mainDragging = false
                        hueDragging  = false
                    end
                end)

                MainBtn.MouseButton1Down:Connect(function() if opened then mainDragging=true end end)
                HueBtn.MouseButton1Down:Connect(function()  if opened then hueDragging=true  end end)

                HexBox.FocusLost:Connect(function()
                    local ok = pcall(function()
                        local r,g,b = string.match(HexBox.Text,"^#?(%w%w)(%w%w)(%w%w)$")
                        local c = Color3.fromRGB(tonumber(r,16),tonumber(g,16),tonumber(b,16))
                        h,s,v2 = c:ToHSV()
                        setDisplay()
                        pcall(function() CB(Color3.fromHSV(h,s,v2)) end)
                    end)
                    if not ok then setDisplay() end
                end)

                local renderConn = RunService.RenderStepped:Connect(function()
                    if mainDragging then
                        local lx = math.clamp(mouse.X - CPBg.AbsolutePosition.X, 0, CPBg.AbsoluteSize.X)
                        local ly = math.clamp(mouse.Y - CPBg.AbsolutePosition.Y, 0, CPBg.AbsoluteSize.Y)
                        s  = lx / math.max(CPBg.AbsoluteSize.X, 1)
                        v2 = 1 - (ly / math.max(CPBg.AbsoluteSize.Y, 1))
                        MainPoint.Position = UDim2.new(0, lx-MainPoint.AbsoluteSize.X/2, 0, ly-MainPoint.AbsoluteSize.Y/2)
                        MainPoint.BackgroundColor3 = Color3.fromHSV(h,s,v2)
                        Display.BackgroundColor3   = Color3.fromHSV(h,s,v2)
                        HexBox.Text = string.format("#%02X%02X%02X",
                            Color3.fromHSV(h,s,v2).R*0xFF,
                            Color3.fromHSV(h,s,v2).G*0xFF,
                            Color3.fromHSV(h,s,v2).B*0xFF)
                        FCP.Color = Color3.fromHSV(h,s,v2)
                        pcall(function() CB(FCP.Color) end)
                    end
                    if hueDragging then
                        local lx = math.clamp(mouse.X - HueSlider.AbsolutePosition.X, 0, HueSlider.AbsoluteSize.X)
                        h  = lx / math.max(HueSlider.AbsoluteSize.X, 1)
                        CPBg.BackgroundColor3 = Color3.fromHSV(h,1,1)
                        SliderPoint.Position  = UDim2.new(h, -7, 0.5, 0)
                        SliderPoint.BackgroundColor3 = Color3.fromHSV(h,1,1)
                        Display.BackgroundColor3     = Color3.fromHSV(h,s,v2)
                        MainPoint.BackgroundColor3   = Color3.fromHSV(h,s,v2)
                        HexBox.Text = string.format("#%02X%02X%02X",
                            Color3.fromHSV(h,s,v2).R*0xFF,
                            Color3.fromHSV(h,s,v2).G*0xFF,
                            Color3.fromHSV(h,s,v2).B*0xFF)
                        FCP.Color = Color3.fromHSV(h,s,v2)
                        pcall(function() CB(FCP.Color) end)
                    end
                end)

                CP.Destroying:Connect(function()
                    if renderConn then renderConn:Disconnect() end
                    if Overlay and Overlay.Parent then Overlay:Destroy() end
                end)

                function FCP:Set(c)
                    FCP.Color = c
                    h,s,v2    = c:ToHSV()
                    setDisplay()
                end

                ItemCount += 1
                return FCP
            end
            
            function Item:AddHotkey(Config)
                local T   = Config[1] or Config.Title   or ""
                local Def = Config[2] or Config.Default or Enum.KeyCode.Unknown
                local CB  = Config[3] or Config.Callback or function() end
                local FH  = { Value = Def }

                local IGNORE_KEYS = {
                    [Enum.KeyCode.Unknown]       = true,
                    [Enum.KeyCode.LeftShift]     = true,
                    [Enum.KeyCode.RightShift]    = true,
                    [Enum.KeyCode.LeftControl]   = true,
                    [Enum.KeyCode.RightControl]  = true,
                    [Enum.KeyCode.LeftAlt]       = true,
                    [Enum.KeyCode.RightAlt]      = true,
                    [Enum.KeyCode.CapsLock]      = true,
                    [Enum.KeyCode.Tab]            = true,
                }

                local listening = false
                local _conn     = nil

                local HK = Custom:Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(18, 18, 20),
                    BackgroundTransparency = 0.88,
                    BorderSizePixel = 0,
                    LayoutOrder = ItemCount,
                    Size = UDim2.new(1, 0, 0, 35),
                    Name = "Hotkey",
                }, SectionAdd)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, HK)

                Custom:Create("TextLabel", {
                    Font = Enum.Font.GothamBold, Text = T,
                    TextColor3 = Color3.fromRGB(230,230,230), TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    BackgroundTransparency = 0.999, BorderSizePixel = 0,
                    Position = UDim2.new(0,10,0,0), Size = UDim2.new(1,-80,1,0),
                    Name = "HKTitle",
                }, HK)

                local Badge = Custom:Create("Frame", {
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = Color3.fromRGB(28, 28, 32),
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1,-10,0.5,0),
                    Size = UDim2.new(0,60,0,24),
                    Name = "Badge",
                }, HK)
                Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Badge)

                local BadgeTxt = Custom:Create("TextLabel", {
                    Font = Enum.Font.GothamBold,
                    Text = tostring(Def.Name or Def),
                    TextColor3 = Custom.ColorRGB,
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    BackgroundTransparency = 1, BorderSizePixel = 0,
                    Position = UDim2.new(0,0,0,0), Size = UDim2.new(1,0,1,0),
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Name = "BadgeTxt",
                }, Badge)

                local LockIcon = nil  

                local HKBtn = Custom:Create("TextButton", {
                    Text = "", BackgroundTransparency = 1, BorderSizePixel = 0,
                    Size = UDim2.new(1,0,1,0), Name = "HKBtn",
                }, HK)

                local function setListeningUI(on)
                    local ti = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
                    if on then
                        BadgeTxt.Text = "..."
                        TweenService:Create(Badge, ti, {BackgroundColor3=Color3.fromRGB(35,28,45)}):Play()
                        TweenService:Create(BadgeTxt, ti, {TextColor3=Color3.fromRGB(255,255,255)}):Play()
                    else
                        local kName = FH.Value and tostring(FH.Value.Name) or "None"
                        BadgeTxt.Text = kName
                        TweenService:Create(Badge, ti, {BackgroundColor3=Color3.fromRGB(28,28,32)}):Play()
                        TweenService:Create(BadgeTxt, ti, {TextColor3=Custom.ColorRGB}):Play()
                    end
                end

                local function stopListening()
                    listening = false
                    if _conn then _conn:Disconnect(); _conn = nil end
                    setListeningUI(false)
                end

                local function startListening()
                    if listening then stopListening(); return end
                    listening = true
                    setListeningUI(true)

                    _conn = UserInputService.InputBegan:Connect(function(inp, gp)
                        if gp then return end
                        
                        if inp.KeyCode == Enum.KeyCode.Backspace then
                            stopListening()
                            return
                        end
                        
                        if inp.KeyCode == Enum.KeyCode.Escape then
                            stopListening()
                            return
                        end
                        
                        if IGNORE_KEYS[inp.KeyCode] then return end
                        if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                        
                        FH.Value = inp.KeyCode
                        stopListening()
                        pcall(function() CB(FH.Value) end)
                    end)
                end

                HKBtn.Activated:Connect(function()
                    CircleClick(HKBtn, Player:GetMouse().X, Player:GetMouse().Y)
                    startListening()
                end)

                HKBtn.MouseEnter:Connect(function()
                    if not listening then
                        TweenService:Create(HK, TweenInfo.new(0.12), {BackgroundTransparency=0.80}):Play()
                    end
                end)
                HKBtn.MouseLeave:Connect(function()
                    TweenService:Create(HK, TweenInfo.new(0.15), {BackgroundTransparency=0.88}):Play()
                end)

                table.insert(_searchIndex, {
                    title       = T,
                    tabName     = _Name,
                    sectionName = _sectionTitle,
                    targetFrame = HK,
                    scrollFrame = ScrolLayers,
                    jumpFn      = function()
                        local myTab = nil
                        for _, tf in pairs(ScrollTab:GetChildren()) do
                            if tf.Name == "Tab" and tf.LayoutOrder == _tabIndex then myTab = tf; break end
                        end
                        activateTab(myTab)
                        LayersPageLayout:JumpToIndex(_tabIndex)
                        task.wait(0.05); NameTab.Text = _Name
                        if not OpenSection then OpenSection = true; UpdateSizeSection() end
                        task.wait(0.35)
                        pulseHighlight(HK)
                    end
                })

                function FH:Set(kc)
                    FH.Value = kc
                    local kName = kc and tostring(kc.Name) or "None"
                    BadgeTxt.Text = kName
                    pcall(function() CB(kc) end)
                end

                setListeningUI(false)
                ItemCount += 1
                return FH
            end
            
            Item._SectionAdd = SectionAdd   
            ItemCount += 1
            return Item
        end

        CountTab += 1
        return Sections
    end

    Tabs._setSettingsIndex = function(idx)
        _settingsTabIndex = idx
    end
    Tabs._ScrollTab = ScrollTab

    return Tabs
end

return CosyHub

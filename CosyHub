local CosyHub = {}
CosyHub.Unloaded = false

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser      = game:GetService("VirtualUser")
local Player           = Players.LocalPlayer

local Custom = {}
Custom.ColorRGB = Color3.fromRGB(250, 7, 7)

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

local function GetGui()
	return (RunService:IsStudio() and Player.PlayerGui)
		or (gethui and gethui())
		or (cloneref and cloneref(game:GetService("CoreGui")))
		or game:GetService("CoreGui")
end

local Open_Close = (function()
	local ScreenGui = Custom:Create("ScreenGui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, GetGui())
	local CloseBtn = Custom:Create("ImageButton", {
		BackgroundColor3 = Color3.fromRGB(0,0,0),
		BorderColor3 = Color3.fromRGB(255,0,0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.1021,0,0.0743,0),
		Size = UDim2.new(0,59,0,49),
		Image = "rbxassetid://136890595976124",
		Visible = false,
	}, ScreenGui)
	Custom:Create("UICorner", { CornerRadius = UDim.new(0,9) }, CloseBtn)
	local dragging, dragStart, startPos = false, nil, nil
	CloseBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true; dragStart = input.Position; startPos = CloseBtn.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	CloseBtn.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			CloseBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	return CloseBtn
end)()

local function MakeDraggable(topbar, object)
	local dragging, dragStart, startPos = false, nil, nil
	topbar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	topbar.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

local function CircleClick(Button, X, Y)
	task.spawn(function()
		Button.ClipsDescendants = true
		local Circle = Instance.new("ImageLabel")
		Circle.Image = "rbxassetid://106471194043211"
		Circle.ImageColor3 = Color3.fromRGB(80,80,80)
		Circle.ImageTransparency = 0.9
		Circle.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Circle.BackgroundTransparency = 1
		Circle.ZIndex = 10
		Circle.Name = "Circle"
		Circle.Parent = Button
		local nx = X - Button.AbsolutePosition.X
		local ny = Y - Button.AbsolutePosition.Y
		Circle.Position = UDim2.new(0, nx, 0, ny)
		local sz = math.max(Button.AbsoluteSize.X, Button.AbsoluteSize.Y) * 1.5
		local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local tw = TweenService:Create(Circle, ti, {
			Size = UDim2.new(0,sz,0,sz),
			Position = UDim2.new(0.5,-sz/2,0.5,-sz/2)
		})
		tw:Play()
		tw.Completed:Connect(function()
			for _ = 1, 10 do Circle.ImageTransparency = Circle.ImageTransparency + 0.01; task.wait(0.05) end
			Circle:Destroy()
		end)
	end)
end

function CosyHub:SetNotification(Config)
	local Title   = Config[1] or Config.Title or ""
	local Desc    = Config[2] or Config.Description or ""
	local Content = Config[3] or Config.Content or ""
	local Time    = Config[5] or Config.Time or 0.5
	local Delay   = Config[6] or Config.Delay or 5

	local Gui = Custom:Create("ScreenGui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, GetGui())
	local Layout = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(1,1),
		BackgroundColor3 = Color3.fromRGB(255,255,255),
		BackgroundTransparency = 0.999,
		BorderSizePixel = 0,
		Position = UDim2.new(1,-30,1,-30),
		Size = UDim2.new(0,320,1,0),
		Name = "Layout"
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
	for _, v in ipairs(Layout:GetChildren()) do _cnt = -(v.Position.Y.Offset) + v.Size.Y.Offset + 12 end
	local NFrame = Custom:Create("Frame", {
		BackgroundColor3 = Color3.fromRGB(0,0,0),
		BorderSizePixel = 0,
		Size = UDim2.new(1,0,0,150),
		Name = "NFrame",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0,1),
		Position = UDim2.new(0,0,1,-_cnt)
	}, Layout)
	local NReal = Custom:Create("Frame", {
		BackgroundColor3 = Color3.fromRGB(0,0,0),
		BorderSizePixel = 0,
		Position = UDim2.new(0,400,0,0),
		Size = UDim2.new(1,0,1,0),
		Name = "NReal"
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
		Font = Enum.Font.GothamBold, Text = Title,
		TextColor3 = Color3.fromRGB(255,255,255), TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Size = UDim2.new(1,0,1,0), Position = UDim2.new(0,10,0,0),
	}, Top)
	Custom:Create("UIStroke", { Color=Color3.fromRGB(255,255,255), Thickness=0.3 }, TL)
	local DL = Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold, Text = Desc,
		TextColor3 = Custom.ColorRGB, TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Size = UDim2.new(1,0,1,0), Position = UDim2.new(0,TL.TextBounds.X+15,0,0),
	}, Top)
	Custom:Create("UIStroke", { Color=Custom.ColorRGB, Thickness=0.4 }, DL)
	local CloseBtn = Custom:Create("TextButton", {
		Font = Enum.Font.SourceSans, Text = "X",
		TextColor3 = Color3.fromRGB(255,255,255), TextSize = 18,
		AnchorPoint = Vector2.new(1,0.5),
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Position = UDim2.new(1,-5,0.5,0), Size = UDim2.new(0,25,0,25),
	}, Top)
	local ContentLabel = Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold, Text = Content,
		TextColor3 = Color3.fromRGB(150,150,150), TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Position = UDim2.new(0,10,0,27), Size = UDim2.new(1,-20,0,13),
	}, NReal)
	ContentLabel.Size = UDim2.new(1,-20,0,13+(13*(ContentLabel.TextBounds.X//ContentLabel.AbsoluteSize.X)))
	ContentLabel.TextWrapped = true
	if ContentLabel.AbsoluteSize.Y < 27 then
		NFrame.Size = UDim2.new(1,0,0,65)
	else
		NFrame.Size = UDim2.new(1,0,0,ContentLabel.AbsoluteSize.Y+40)
	end
	local Waited = false
	local Notif = {}
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
	local SizeUi   = Config[4] or Config.SizeUi or UDim2.fromOffset(580, 340)

	local Gui = Custom:Create("ScreenGui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, GetGui())
	local ShadowHolder = Custom:Create("Frame", {
		BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.new(0,455,0,350), ZIndex = 0, Name = "ShadowHolder",
		Position = UDim2.new(0, Gui.AbsoluteSize.X//2-455//2, 0, Gui.AbsoluteSize.Y//2-350//2)
	}, Gui)
	local Shadow = Custom:Create("ImageLabel", {
		Image = "", ImageColor3 = Color3.fromRGB(15,15,15),
		ImageTransparency = 0.5, ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49,49,450,450), AnchorPoint = Vector2.new(0.5,0.5),
		BackgroundTransparency = 1, BorderSizePixel = 0,
		Position = UDim2.new(0.5,0,0.5,0), Size = SizeUi, ZIndex = 0, Name = "Shadow"
	}, ShadowHolder)
	local Main = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0.5,0.5),
		BackgroundColor3 = Color3.fromRGB(15,15,15),
		BackgroundTransparency = 0.1, BorderSizePixel = 0,
		Position = UDim2.new(0.5,0,0.5,0), Size = SizeUi, Name = "Main"
	}, Shadow)
	Custom:Create("UICorner", {}, Main)
	Custom:Create("UIStroke", { Color=Color3.fromRGB(50,50,50), Thickness=1.6 }, Main)
	local Top = Custom:Create("Frame", {
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Size = UDim2.new(1,0,0,38), Name = "Top"
	}, Main)
	Custom:Create("UICorner", {}, Top)
	local TitleLabel = Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold, Text = Title,
		TextColor3 = Color3.fromRGB(255,255,255), TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Size = UDim2.new(1,-100,1,0), Position = UDim2.new(0,10,0,0),
	}, Top)
	local DescLabel = Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold, Text = Desc,
		TextColor3 = Custom.ColorRGB, TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Size = UDim2.new(1,-(TitleLabel.TextBounds.X+104),1,0),
		Position = UDim2.new(0,TitleLabel.TextBounds.X+15,0,0),
	}, Top)
	Custom:Create("UIStroke", { Color=Custom.ColorRGB, Thickness=0.4 }, DescLabel)
	local CloseBtn = Custom:Create("TextButton", {
		Font = Enum.Font.SourceSans, Text = "X",
		TextColor3 = Color3.fromRGB(255,255,255), TextSize = 18,
		AnchorPoint = Vector2.new(1,0.5), BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Position = UDim2.new(1,-8,0.5,0), Size = UDim2.new(0,25,0,25), Name = "Close"
	}, Top)
	local MinBtn = Custom:Create("TextButton", {
		Font = Enum.Font.SourceSans, Text = "-",
		TextColor3 = Color3.fromRGB(255,255,255), TextSize = 18,
		AnchorPoint = Vector2.new(1,0.5), BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Position = UDim2.new(1,-42,0.5,0), Size = UDim2.new(0,25,0,25), Name = "Min"
	}, Top)
	Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0.5,0), BackgroundColor3 = Color3.fromRGB(255,255,255),
		BackgroundTransparency = 0.85, BorderSizePixel = 0,
		Position = UDim2.new(0.5,0,0,38), Size = UDim2.new(1,0,0,1), Name = "DecideFrame"
	}, Main)
	local LayersTab = Custom:Create("Frame", {
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Position = UDim2.new(0,9,0,50), Size = UDim2.new(0,TabWidth,1,-59), Name = "LayersTab"
	}, Main)
	Custom:Create("UICorner", { CornerRadius=UDim.new(0,2) }, LayersTab)
	local ScrollTab = Custom:Create("ScrollingFrame", {
		CanvasSize = UDim2.new(0,0,2.1,0), ScrollBarThickness = 0, Active = true,
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Size = UDim2.new(1,0,1,-10), Name = "ScrollTab"
	}, LayersTab)
	Custom:Create("UIListLayout", { Padding=UDim.new(0,0), SortOrder=Enum.SortOrder.LayoutOrder }, ScrollTab)
	local Layers = Custom:Create("Frame", {
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Position = UDim2.new(0,TabWidth+18,0,50),
		Size = UDim2.new(1,-(TabWidth+9+18),1,-59), Name = "Layers"
	}, Main)
	Custom:Create("UICorner", { CornerRadius=UDim.new(0,2) }, Layers)
	local NameTab = Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold, Text = "",
		TextColor3 = Color3.fromRGB(255,255,255), TextSize = 24, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Size = UDim2.new(1,0,0,30), Name = "NameTab"
	}, Layers)
	local LayersReal = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0,1), BackgroundTransparency = 0.999, BorderSizePixel = 0,
		ClipsDescendants = true, Position = UDim2.new(0,0,1,0), Size = UDim2.new(1,0,1,-33), Name = "LayersReal"
	}, Layers)
	local LayersFolder = Custom:Create("Folder", { Name="LayersFolder" }, LayersReal)
	local LayersPageLayout = Custom:Create("UIPageLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder, Name = "LayersPageLayout",
		TweenTime = 0.5, EasingDirection = Enum.EasingDirection.InOut, EasingStyle = Enum.EasingStyle.Quad
	}, LayersFolder)
	local MoreBlur = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(1,1), BackgroundColor3 = Color3.fromRGB(0,0,0),
		BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true,
		Position = UDim2.new(1,0,1,0), Size = UDim2.new(1,0,1,0), Visible = false, Name = "MoreBlur"
	}, Layers)
	Custom:Create("UICorner", {}, MoreBlur)
	local ConnectButton = Custom:Create("TextButton", {
		Text = "", BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Size = UDim2.new(1,0,1,0), Name = "ConnectButton",
	}, MoreBlur)
	local DropdownSelect = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(1,0.5), BackgroundColor3 = Color3.fromRGB(30,30,30),
		BorderSizePixel = 0, LayoutOrder = 1,
		Position = UDim2.new(1,172,0.5,0), Size = UDim2.new(0,160,1,-16),
		Name = "DropdownSelect", ClipsDescendants = true,
	}, MoreBlur)
	Custom:Create("UICorner", { CornerRadius=UDim.new(0,3) }, DropdownSelect)
	Custom:Create("UIStroke", { Color=Color3.fromRGB(255,255,255), Thickness=2.5, Transparency=0.8 }, DropdownSelect)
	local DropdownSelectReal = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0.5,0.5), BackgroundTransparency = 0.999, BorderSizePixel = 0,
		Position = UDim2.new(0.5,0,0.5,0), Size = UDim2.new(1,-10,1,-10), Name = "DropdownSelectReal",
	}, DropdownSelect)
	local DropdownFolder = Custom:Create("Folder", { Name="DropdownFolder" }, DropdownSelectReal)
	local DropPageLayout = Custom:Create("UIPageLayout", {
		EasingDirection = Enum.EasingDirection.InOut, EasingStyle = Enum.EasingStyle.Quad,
		TweenTime = 0.01, SortOrder = Enum.SortOrder.LayoutOrder, Name = "DropPageLayout",
	}, DropdownFolder)

	ConnectButton.Activated:Connect(function()
		if MoreBlur.Visible then
			TweenService:Create(MoreBlur, TweenInfo.new(0.2), {BackgroundTransparency=0.999}):Play()
			TweenService:Create(DropdownSelect, TweenInfo.new(0.2), {Position=UDim2.new(1,172,0.5,0)}):Play()
			task.wait(0.2); MoreBlur.Visible = false
		end
	end)

	ShadowHolder.Size = UDim2.new(0, 115+TitleLabel.TextBounds.X+1+DescLabel.TextBounds.X, 0, 350)
	local _fullSize = ShadowHolder.Size

	local function animateOpen()
		ShadowHolder.Size = UDim2.fromOffset(0, 0); ShadowHolder.Visible = true
		TweenService:Create(ShadowHolder, TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out), { Size = _fullSize }):Play()
	end
	local function animateClose(callback)
		TweenService:Create(ShadowHolder, TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.In), { Size = UDim2.fromOffset(0,0) }):Play()
		task.delay(0.3, function()
			ShadowHolder.Visible = false; ShadowHolder.Size = _fullSize
			if callback then callback() end
		end)
	end
	animateOpen()

	MinBtn.Activated:Connect(function()
		CircleClick(MinBtn, Player:GetMouse().X, Player:GetMouse().Y)
		animateClose(function() if not Open_Close.Visible then Open_Close.Visible = true end end)
	end)
	Open_Close.Activated:Connect(function()
		if Open_Close.Visible then Open_Close.Visible = false end
		animateOpen()
	end)
	CloseBtn.Activated:Connect(function()
		CircleClick(CloseBtn, Player:GetMouse().X, Player:GetMouse().Y)
		animateClose(function()
			if Gui then Gui:Destroy() end
			CosyHub.Unloaded = true
		end)
	end)
	MakeDraggable(Top, ShadowHolder)

	local Tabs = {}
	local CountTab = 0
	local CountDropdown = 0

	function Tabs:CreateTab(Config)
		local _Name = Config[1] or Config.Name or ""
		local Icon  = Config[2] or Config.Icon or ""

		local ScrolLayers = Custom:Create("ScrollingFrame", {
			ScrollBarImageColor3 = Color3.fromRGB(80,80,80), ScrollBarThickness = 0, Active = true,
			LayoutOrder = CountTab, BackgroundTransparency = 0.999, BorderSizePixel = 0,
			Size = UDim2.new(1,0,1,0), Name = "ScrolLayers",
		}, LayersFolder)
		Custom:Create("UIListLayout", { Padding=UDim.new(0,3), SortOrder=Enum.SortOrder.LayoutOrder }, ScrolLayers)

		local Tab = Custom:Create("Frame", {
			BackgroundColor3 = Color3.fromRGB(255,255,255),
			BackgroundTransparency = CountTab==0 and 0.92 or 0.999,
			BorderSizePixel = 0, LayoutOrder = CountTab, Size = UDim2.new(1,0,0,30), Name = "Tab",
		}, ScrollTab)
		Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Tab)
		local TabButton = Custom:Create("TextButton", {
			Font = Enum.Font.GothamBold, Text = "",
			TextColor3 = Color3.fromRGB(255,255,255), TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 0.999, BorderSizePixel = 0,
			Size = UDim2.new(1,0,1,0), Name = "TabButton",
		}, Tab)
		local TabNameLabel = Custom:Create("TextLabel", {
			Font = Enum.Font.GothamBold, Text = _Name,
			TextColor3 = Color3.fromRGB(255,255,255), TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 0.999, BorderSizePixel = 0,
			Size = UDim2.new(1,0,1,0), Position = UDim2.new(0,30,0,0), Name = "TabName",
		}, Tab)
		task.defer(function()
			local textW = TabNameLabel.TextBounds.X
			local needed = textW + 30 + 14
			if needed > Tab.AbsoluteSize.X then
				local extra = needed - Tab.AbsoluteSize.X
				LayersTab.Size = UDim2.new(0, LayersTab.Size.X.Offset + extra, 1, -59)
				Layers.Position = UDim2.new(0, Layers.Position.X.Offset + extra, 0, 50)
				Layers.Size = UDim2.new(1, Layers.Size.X.Offset - extra, 1, -59)
			end
		end)
		Custom:Create("ImageLabel", {
			Image = Icon, BackgroundTransparency = 0.999, BorderSizePixel = 0,
			Position = UDim2.new(0,9,0,7), Size = UDim2.new(0,16,0,16), Name = "FeatureImg",
		}, Tab)
		if CountTab == 0 then
			LayersPageLayout:JumpToIndex(0)
			NameTab.Text = _Name
		end
		TabButton.Activated:Connect(function()
			CircleClick(TabButton, Player:GetMouse().X, Player:GetMouse().Y)
			if Tab.LayoutOrder ~= LayersPageLayout.CurrentPage.LayoutOrder then
				for _, tf in pairs(ScrollTab:GetChildren()) do
					if tf.Name == "Tab" then
						TweenService:Create(tf, TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.InOut), {BackgroundTransparency=0.999}):Play()
					end
				end
				TweenService:Create(Tab, TweenInfo.new(0.6,Enum.EasingStyle.Back,Enum.EasingDirection.InOut), {BackgroundTransparency=0.92}):Play()
				LayersPageLayout:JumpToIndex(Tab.LayoutOrder)
				task.wait(0.05)
				NameTab.Text = _Name
			end
		end)

		local Sections = {}
		local CountSection = 0

		function Sections:AddSection(Title, OpenSection)
			Title = Title or ""
			OpenSection = OpenSection or false

			local Section = Custom:Create("Frame", {
				BackgroundTransparency = 0.999, BorderSizePixel = 0, ClipsDescendants = true,
				LayoutOrder = CountSection, Size = UDim2.new(1,0,0,30), Name = "Section"
			}, ScrolLayers)
			local SectionReal = Custom:Create("Frame", {
				AnchorPoint = Vector2.new(0.5,0), BackgroundColor3 = Color3.fromRGB(255,255,255),
				BackgroundTransparency = 0.935, BorderSizePixel = 0,
				Position = UDim2.new(0.5,0,0,0), Size = UDim2.new(1,1,0,30), Name = "SectionReal"
			}, Section)
			Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, SectionReal)
			local SectionButton = Custom:Create("TextButton", {
				Text = "", BackgroundTransparency = 0.999, BorderSizePixel = 0,
				Size = UDim2.new(1,0,1,0), Name = "SectionButton"
			}, SectionReal)
			local FeatureFrame = Custom:Create("Frame", {
				AnchorPoint = Vector2.new(1,0.5), BackgroundTransparency = 0.999, BorderSizePixel = 0,
				Position = UDim2.new(1,-5,0.5,0), Size = UDim2.new(0,20,0,20), Name = "FeatureFrame"
			}, SectionReal)
			local FeatureImg = Custom:Create("ImageLabel", {
				Image = "rbxassetid://125609963478878", AnchorPoint = Vector2.new(0.5,0.5),
				BackgroundTransparency = 0.999, BorderSizePixel = 0,
				Position = UDim2.new(0.5,0,0.5,0), Rotation = -90, Size = UDim2.new(1,6,1,6), Name = "FeatureImg"
			}, FeatureFrame)
			Custom:Create("TextLabel", {
				Font = Enum.Font.GothamBold, Text = Title,
				TextColor3 = Color3.fromRGB(230,230,230), TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
				AnchorPoint = Vector2.new(0,0.5), BackgroundTransparency = 0.999, BorderSizePixel = 0,
				Position = UDim2.new(0,10,0.5,0), Size = UDim2.new(1,-50,0,13), Name = "SectionTitle"
			}, SectionReal)
			local SectionDecideFrame = Custom:Create("Frame", {
				BackgroundColor3 = Color3.fromRGB(255,255,255), BorderSizePixel = 0,
				AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,33),
				Size = UDim2.new(0,0,0,2), Name = "SectionDecideFrame"
			}, Section)
			Custom:Create("UICorner", {}, SectionDecideFrame)
			Custom:Create("UIGradient", {
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(20,20,20)),
					ColorSequenceKeypoint.new(0.5, Custom.ColorRGB),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(20,20,20)),
				}
			}, SectionDecideFrame)
			local SectionAdd = Custom:Create("Frame", {
				AnchorPoint = Vector2.new(0.5,0), BackgroundTransparency = 0.999, BorderSizePixel = 0,
				ClipsDescendants = true, LayoutOrder = 1,
				Position = UDim2.new(0.5,0,0,38), Size = UDim2.new(1,0,0,100), Name = "SectionAdd"
			}, Section)
			Custom:Create("UICorner", { CornerRadius=UDim.new(0,2) }, SectionAdd)
			Custom:Create("UIListLayout", { Padding=UDim.new(0,3), SortOrder=Enum.SortOrder.LayoutOrder }, SectionAdd)

			local function UpdateSizeScroll()
				local off = 0
				for _, child in pairs(ScrolLayers:GetChildren()) do
					if child.Name ~= "UIListLayout" then off = off + 3 + child.Size.Y.Offset end
				end
				ScrolLayers.CanvasSize = UDim2.new(0,0,0,off)
			end
			local function UpdateSizeSection()
				if OpenSection then
					local h = 38
					for _, v in pairs(SectionAdd:GetChildren()) do
						if v.Name ~= "UIListLayout" and v.Name ~= "UICorner" then h = h + v.Size.Y.Offset + 3 end
					end
					TweenService:Create(FeatureFrame, TweenInfo.new(0.1), {Rotation=90}):Play()
					TweenService:Create(Section, TweenInfo.new(0.1), {Size=UDim2.new(1,1,0,h)}):Play()
					TweenService:Create(SectionAdd, TweenInfo.new(0.1), {Size=UDim2.new(1,0,0,h-38)}):Play()
					TweenService:Create(SectionDecideFrame, TweenInfo.new(0.1), {Size=UDim2.new(1,0,0,2)}):Play()
					task.wait(0.5); UpdateSizeScroll()
				end
			end
			local function ToggleSection()
				CircleClick(SectionButton, Player:GetMouse().X, Player:GetMouse().Y)
				if OpenSection then
					TweenService:Create(FeatureFrame, TweenInfo.new(0.1), {Rotation=0}):Play()
					TweenService:Create(Section, TweenInfo.new(0.1), {Size=UDim2.new(1,1,0,30)}):Play()
					TweenService:Create(SectionDecideFrame, TweenInfo.new(0.1), {Size=UDim2.new(0,0,0,2)}):Play()
					OpenSection = false; task.wait(0.1); UpdateSizeScroll()
				else
					OpenSection = true; UpdateSizeSection()
				end
			end
			SectionButton.Activated:Connect(ToggleSection)
			SectionAdd.ChildAdded:Connect(UpdateSizeSection)
			SectionAdd.ChildRemoved:Connect(UpdateSizeSection)
			UpdateSizeScroll()

			local Item = {}
			local ItemCount = 0

			function Item:AddParagraph(Config)
				local T = Config[1] or Config.Title or ""
				local C = Config[2] or Config.Content or ""
				local SF = {}
				local P = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 0.935,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,35), Name = "Paragraph",
				}, SectionAdd)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, P)
				local PT = Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = T, TextColor3 = Color3.fromRGB(231,231,231),
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,10), Size = UDim2.new(1,-16,0,13), Name = "PTitle",
				}, P)
				local PC = Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = C, TextColor3 = Color3.fromRGB(255,255,255),
					TextSize = 12, TextTransparency = 0.6,
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom,
					BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,23), Name = "PContent",
				}, P)
				local function Update()
					PC.TextWrapped = false
					local lines = math.ceil(PC.TextBounds.X / math.max(PC.AbsoluteSize.X,1))
					PC.Size = UDim2.new(1,-16,0,12+(12*lines))
					P.Size = UDim2.new(1,0,0,PC.AbsoluteSize.Y+33)
					PC.TextWrapped = true; UpdateSizeSection()
				end
				Update(); PC:GetPropertyChangedSignal("AbsoluteSize"):Connect(Update)
				function SF:Set(Config)
					PT.Text = Config[1] or Config.Title or ""
					PC.Text = Config[2] or Config.Content or ""
					Update()
				end
				ItemCount += 1; return SF
			end

			function Item:AddSeperator(Config)
				local T = Config[1] or Config.Title or ""
				local SF = {}
				local S = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(70,70,70), BackgroundTransparency = 0.1,
					BorderSizePixel = 1, LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,30), Name = "Seperator",
				}, SectionAdd)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,6) }, S)
				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = T, TextColor3 = Color3.fromRGB(231,231,231),
					TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0,12,0,0), Size = UDim2.new(1,-16,1,0), Name = "Title",
				}, S)
				function SF:Set(Config) S:FindFirstChild("Title").Text = Config[1] or Config.Title or "" end
				ItemCount += 1; return SF
			end

			function Item:AddLine()
				local L = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(90,90,90), BackgroundTransparency = 0.2,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,7), Name = "Line",
				}, SectionAdd)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,3) }, L)
				ItemCount += 1; return {}
			end

			function Item:AddButton(Config)
				local T  = Config[1] or Config.Title or ""
				local C  = Config[2] or Config.Content or ""
				local Ic = Config[3] or Config.Icon or "rbxassetid://7734010488"
				local CB = Config[4] or Config.Callback or function() end
				local BF = {}
				local btnH = (C and C ~= "") and 48 or 35
				local B = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 0.935,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,btnH), Name = "Button",
				}, SectionAdd)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,5) }, B)
				Custom:Create("UIStroke", { Color=Color3.fromRGB(255,255,255), Thickness=0.5, Transparency=0.92 }, B)
				local IconBg = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1,0.5), BackgroundColor3 = Color3.fromRGB(255,255,255),
					BackgroundTransparency = 0.88, BorderSizePixel = 0,
					Position = UDim2.new(1,-10,0.5,0), Size = UDim2.new(0,26,0,26), Name = "IconBg",
				}, B)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,5) }, IconBg)
				Custom:Create("ImageLabel", {
					Image = Ic, BackgroundTransparency = 1, BorderSizePixel = 0,
					AnchorPoint = Vector2.new(0.5,0.5), Position = UDim2.new(0.5,0,0.5,0),
					Size = UDim2.new(0,16,0,16),
				}, IconBg)
				local titleAnchor = (C and C ~= "") and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
				local titlePosY   = (C and C ~= "") and 9 or 0
				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = T,
					TextColor3 = Color3.fromRGB(230,230,230), TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = titleAnchor,
					BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,titlePosY), Size = UDim2.new(1,-50,0,btnH - titlePosY*2),
				}, B)
				if C and C ~= "" then
					Custom:Create("TextLabel", {
						Font = Enum.Font.GothamBold, Text = C,
						TextColor3 = Color3.fromRGB(255,255,255), TextSize = 11, TextTransparency = 0.5,
						TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
						TextWrapped = true, BackgroundTransparency = 0.999, BorderSizePixel = 0,
						Position = UDim2.new(0,10,0,25), Size = UDim2.new(1,-50,0,14),
					}, B)
				end
				local BB = Custom:Create("TextButton", {
					Text = "", BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Size = UDim2.new(1,0,1,0),
				}, B)
				BB.MouseEnter:Connect(function()
					TweenService:Create(B, TweenInfo.new(0.15), {BackgroundTransparency=0.88}):Play()
				end)
				BB.MouseLeave:Connect(function()
					TweenService:Create(B, TweenInfo.new(0.15), {BackgroundTransparency=0.935}):Play()
				end)
				BB.Activated:Connect(function()
					CircleClick(BB, Player:GetMouse().X, Player:GetMouse().Y); CB()
				end)
				ItemCount += 1; return BF
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
					BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 0.935,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,togH), Name = "Toggle",
				}, SectionAdd)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Tog)
				local titleAnchor = hasContent and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
				local titlePosY   = hasContent and 9 or 0
				local TT = Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = T, TextSize = 13,
					TextColor3 = Color3.fromRGB(231,231,231),
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = titleAnchor,
					BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,titlePosY), Size = UDim2.new(1,-100,0,togH - titlePosY*2), Name = "TT",
				}, Tog)
				if hasContent then
					local TC = Custom:Create("TextLabel", {
						Font = Enum.Font.GothamBold, Text = C, TextSize = 11,
						TextColor3 = Color3.fromRGB(255,255,255), TextTransparency = 0.5,
						TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
						TextWrapped = true, BackgroundTransparency = 0.999, BorderSizePixel = 0,
						Position = UDim2.new(0,10,0,25), Size = UDim2.new(1,-110,0,14), Name = "TC",
					}, Tog)
					task.defer(function()
						local lines = math.max(1, math.ceil(TC.TextBounds.X / math.max(TC.AbsoluteSize.X,1)))
						if lines > 1 then Tog.Size = UDim2.new(1,0,0,togH + (lines-1)*13) end
					end)
				end
				local TB = Custom:Create("TextButton", {
					Text = "", BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Size = UDim2.new(1,0,1,0), Name = "TBtn",
				}, Tog)
				local Track = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1,0.5), BackgroundColor3 = Color3.fromRGB(255,255,255),
					BackgroundTransparency = 0.92, BorderSizePixel = 0,
					Position = UDim2.new(1,-15,0.5,0), Size = UDim2.new(0,30,0,15), Name = "Track",
				}, Tog)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Track)
				local Stroke8 = Custom:Create("UIStroke", { Color=Color3.fromRGB(255,255,255), Thickness=2, Transparency=0.9 }, Track)
				local Knob = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(230,230,230), BorderSizePixel = 0,
					Size = UDim2.new(0,14,0,14), Position = UDim2.new(0,0,0,0), Name = "Knob",
				}, Track)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,15) }, Knob)
				local function Animate(on)
					local tc = on and Custom.ColorRGB or Color3.fromRGB(230,230,230)
					local kp = on and UDim2.new(0,15,0,0) or UDim2.new(0,0,0,0)
					local sc = on and Custom.ColorRGB or Color3.fromRGB(255,255,255)
					local st = on and 0 or 0.9
					local fc = on and Custom.ColorRGB or Color3.fromRGB(255,255,255)
					local ft = on and 0 or 0.92
					local ti = TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
					TweenService:Create(TT, ti, {TextColor3=tc}):Play()
					TweenService:Create(Knob, ti, {Position=kp}):Play()
					TweenService:Create(Stroke8, ti, {Color=sc,Transparency=st}):Play()
					TweenService:Create(Track, ti, {BackgroundColor3=fc,BackgroundTransparency=ft}):Play()
				end
				TB.Activated:Connect(function()
					CircleClick(TB, Player:GetMouse().X, Player:GetMouse().Y)
					FT.Value = not FT.Value; FT:Set(FT.Value)
				end)
				function FT:Set(v) CB(v); Animate(v) end
				FT:Set(FT.Value); ItemCount += 1; return FT
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
				local slHasContent = C and C ~= ""
				local slH = slHasContent and 48 or 35
				local Sl = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 0.935,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,slH), Name = "Slider",
				}, SectionAdd)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Sl)
				local slTitleAnchor = slHasContent and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
				local slTitlePosY   = slHasContent and 9 or 0
				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = T, TextColor3 = Color3.fromRGB(230,230,230), TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = slTitleAnchor,
					BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,slTitlePosY), Size = UDim2.new(1,-180,0,slH - slTitlePosY*2), Name = "ST",
				}, Sl)
				if slHasContent then
					local SC2 = Custom:Create("TextLabel", {
						Font = Enum.Font.GothamBold, Text = C,
						TextColor3 = Color3.fromRGB(255,255,255), TextSize = 11, TextTransparency = 0.5,
						TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
						TextWrapped = true, BackgroundTransparency = 0.999, BorderSizePixel = 0,
						Position = UDim2.new(0,10,0,25), Size = UDim2.new(1,-190,0,14), Name = "SC2",
					}, Sl)
					task.defer(function()
						local lines = math.max(1, math.ceil(SC2.TextBounds.X / math.max(SC2.AbsoluteSize.X,1)))
						if lines > 1 then Sl.Size = UDim2.new(1,0,0,slH + (lines-1)*13) end
					end)
				end
				local SIFrame = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(0,0.5), BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(1,-158, slHasContent and 0 or 0.5, slHasContent and slH*0.28 or 0),
					Size = UDim2.new(0,34,0,20), Name = "SIFrame",
				}, Sl)
				local TBox = Custom:Create("TextBox", {
					Font = Enum.Font.GothamBold, Text = "0", TextColor3 = Color3.fromRGB(255,255,255), TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Right, BackgroundTransparency = 1, BorderSizePixel = 0,
					ClearTextOnFocus = false, Position = UDim2.new(0,0,0,0), Size = UDim2.new(1,0,1,0),
				}, SIFrame)
				local SFrame = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1,0.5), BackgroundColor3 = Color3.fromRGB(255,255,255),
					BackgroundTransparency = 0.8, BorderSizePixel = 0,
					Position = UDim2.new(1,-20, slHasContent and 0 or 0.5, slHasContent and slH*0.28 or 0),
					Size = UDim2.new(0,100,0,3), Name = "SFrame",
				}, Sl)
				Custom:Create("UICorner", {}, SFrame)
				local SDrag = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(0,0.5), BackgroundColor3 = Custom.ColorRGB, BorderSizePixel = 0,
					Position = UDim2.new(0,0,0.5,0), Size = UDim2.new(0.9,0,0,1), Name = "SDrag",
				}, SFrame)
				Custom:Create("UICorner", {}, SDrag)
				local SCircle = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1,0.5), BackgroundColor3 = Custom.ColorRGB, BorderSizePixel = 0,
					Position = UDim2.new(1,4,0.5,0), Size = UDim2.new(0,8,0,8), Name = "SCircle",
				}, SDrag)
				Custom:Create("UICorner", {}, SCircle)
				Custom:Create("UIStroke", { Color=Custom.ColorRGB }, SCircle)
				local Dragging = false
				local function Round(n, f)
					local r = math.floor(n/f + math.sign(n)*0.5)*f
					if r < 0 then r = r + f end
					return r
				end
				function FS:Set(v)
					v = math.clamp(Round(v,Inc), Mn, Mx)
					FS.Value = v; TBox.Text = tostring(v)
					TweenService:Create(SDrag, TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {
						Size = UDim2.fromScale((v-Mn)/(Mx-Mn), 1)
					}):Play()
				end
				SFrame.InputBegan:Connect(function(i)
					if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
						Dragging = true
					end
				end)
				SFrame.InputEnded:Connect(function(i)
					if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
						Dragging = false; CB(FS.Value)
					end
				end)
				local _lx = nil
				UserInputService.InputChanged:Connect(function(i)
					if Dragging then
						local cx = i.Position.X
						if cx ~= _lx then
							_lx = cx
							local sc = math.clamp((cx-SFrame.AbsolutePosition.X)/SFrame.AbsoluteSize.X,0,1)
							FS:Set(Mn+((Mx-Mn)*sc))
						end
					end
				end)
				TBox:GetPropertyChangedSignal("Text"):Connect(function()
					local vld = TBox.Text:gsub("[^%d]","")
					if vld ~= "" then TBox.Text = tostring(math.min(tonumber(vld),Mx))
					else TBox.Text = "0" end
				end)
				TBox.FocusLost:Connect(function() FS:Set(tonumber(TBox.Text) or 0); CB(FS.Value) end)
				FS:Set(tonumber(Def)); CB(FS.Value); ItemCount += 1; return FS
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
					BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 0.935,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,inpH), Name = "Input",
				}, SectionAdd)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Inp)
				local inpTitleAnchor = inpHasContent and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
				local inpTitlePosY   = inpHasContent and 9 or 0
				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = T, TextColor3 = Color3.fromRGB(230,230,230), TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = inpTitleAnchor,
					BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,inpTitlePosY), Size = UDim2.new(1,-180,0,inpH - inpTitlePosY*2),
				}, Inp)
				if inpHasContent then
					local InpC = Custom:Create("TextLabel", {
						Font = Enum.Font.GothamBold, Text = C,
						TextColor3 = Color3.fromRGB(255,255,255), TextSize = 11, TextTransparency = 0.5,
						TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
						TextWrapped = true, BackgroundTransparency = 0.999, BorderSizePixel = 0,
						Position = UDim2.new(0,10,0,25), Size = UDim2.new(0.45,0,0,14), Name = "SC",
					}, Inp)
					task.defer(function()
						local lines = math.max(1, math.ceil(InpC.TextBounds.X / math.max(InpC.AbsoluteSize.X,1)))
						if lines > 1 then Inp.Size = UDim2.new(1,0,0,inpH + (lines-1)*13) end
					end)
				end
				local ifY = inpHasContent and UDim2.new(1,-7,0,9) or UDim2.new(1,-7,0.5,0)
				local IFrame = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1, inpHasContent and 0 or 0.5),
					BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 0.95,
					BorderSizePixel = 0, ClipsDescendants = true, Position = ifY, Size = UDim2.new(0,148,0,30),
				}, Inp)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, IFrame)
				local ITB = Custom:Create("TextBox", {
					Font = Enum.Font.GothamBold,
					PlaceholderColor3 = Color3.fromRGB(120,120,120), PlaceholderText = "Type here...",
					Text = "", TextColor3 = Color3.fromRGB(255,255,255), TextSize = 12,
					TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0,0.5),
					BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Position = UDim2.new(0,5,0.5,0), Size = UDim2.new(1,-10,1,-8),
				}, IFrame)
				function FI:Set(v) ITB.Text = v; FI.Value = v; CB(v) end
				ITB.FocusLost:Connect(function() FI:Set(ITB.Text) end)
				FI:Set(Def); ItemCount += 1; return FI
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
					BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 0.935,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,ddH), Name = "Dropdown",
				}, SectionAdd)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, DD)
				local DDB = Custom:Create("TextButton", {
					Text = "", BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Size = UDim2.new(1,0,1,0), Name = "DDB",
				}, DD)
				local ddTitleAnchor = ddHasContent and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
				local ddTitlePosY   = ddHasContent and 9 or 0
				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = T, TextColor3 = Color3.fromRGB(230,230,230), TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = ddTitleAnchor,
					BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,ddTitlePosY), Size = UDim2.new(1,-180,0,ddH - ddTitlePosY*2),
				}, DD)
				if ddHasContent then
					local DDC = Custom:Create("TextLabel", {
						Font = Enum.Font.GothamBold, Text = C,
						TextColor3 = Color3.fromRGB(255,255,255), TextSize = 11, TextTransparency = 0.5,
						TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
						TextWrapped = true, BackgroundTransparency = 0.999, BorderSizePixel = 0,
						Position = UDim2.new(0,10,0,25), Size = UDim2.new(1,-190,0,14),
					}, DD)
					task.defer(function()
						local lines = math.max(1, math.ceil(DDC.TextBounds.X / math.max(DDC.AbsoluteSize.X,1)))
						if lines > 1 then DD.Size = UDim2.new(1,0,0,ddH + (lines-1)*13) end
					end)
				end
				local SelFrame = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1,0.5), BackgroundColor3 = Color3.fromRGB(255,255,255),
					BackgroundTransparency = 0.95, BorderSizePixel = 0,
					Position = UDim2.new(1,-7,0.5,0), Size = UDim2.new(0,148,0,30),
					Name = "SelFrame", LayoutOrder = CountDropdown,
				}, DD)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, SelFrame)
				local SelTxt = Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = "",
					TextColor3 = Color3.fromRGB(255,255,255), TextSize = 12, TextTransparency = 0.6,
					TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0,0.5),
					BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Position = UDim2.new(0,5,0.5,0), Size = UDim2.new(1,-30,1,-8),
				}, SelFrame)
				local ScrollSel = Custom:Create("ScrollingFrame", {
					CanvasSize = UDim2.new(0,0,0,0), ScrollBarThickness = 0, Active = true,
					LayoutOrder = CountDropdown, BackgroundTransparency = 0.999, BorderSizePixel = 0,
					Size = UDim2.new(1,0,1,0), Name = "ScrollSel",
				}, DropdownFolder)
				Custom:Create("UIListLayout", { Padding=UDim.new(0,3), SortOrder=Enum.SortOrder.LayoutOrder }, ScrollSel)
				local SearchBar = Custom:Create("TextBox", {
					Font = Enum.Font.GothamBold, PlaceholderText = "Search",
					PlaceholderColor3 = Color3.fromRGB(120,120,120),
					Text = "", TextColor3 = Color3.fromRGB(255,255,255), TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(0,0,0), BackgroundTransparency = 0.9,
					BorderSizePixel = 1, Size = UDim2.new(1,0,0,20), Name = "SearchBar",
				}, ScrollSel)
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
							FD.Value = {}; FD.Options = {}; SelTxt.Text = "Select Options"; df:Destroy()
						end
					end
				end
				function FD:Set(v)
					FD.Value = v or FD.Value
					for _, d in pairs(ScrollSel:GetChildren()) do
						if d.Name ~= "UIListLayout" and d.Name ~= "SearchBar" then
							local found = table.find(FD.Value, d.OptionText and d.OptionText.Text)
							if found then
								TweenService:Create(d, TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {BackgroundTransparency=0.935}):Play()
							else
								TweenService:Create(d, TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {BackgroundTransparency=0.999}):Play()
							end
						end
					end
					local joined = table.concat(FD.Value,", ")
					SelTxt.Text = joined ~= "" and joined or "Select Options"
					CB(FD.Value)
				end
				function FD:AddOption(name)
					name = name or "Option"
					local Opt = Custom:Create("Frame", {
						BackgroundTransparency = 0.999, BorderSizePixel = 0,
						LayoutOrder = DropCount, Size = UDim2.new(1,0,0,30), Name = "Option",
					}, ScrollSel)
					Custom:Create("UICorner", { CornerRadius=UDim.new(0,3) }, Opt)
					local OB = Custom:Create("TextButton", {
						Text = "", BackgroundTransparency = 0.999, BorderSizePixel = 0,
						Size = UDim2.new(1,0,1,0), Name = "OptionButton",
					}, Opt)
					local OT = Custom:Create("TextLabel", {
						Font = Enum.Font.GothamBold, Text = name,
						TextColor3 = Color3.fromRGB(230,230,230), TextSize = 13,
						TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
						BackgroundTransparency = 0.999, BorderSizePixel = 0,
						Position = UDim2.new(0,8,0,8), Size = UDim2.new(1,-100,0,13), Name = "OptionText",
					}, Opt)
					local CF2 = Custom:Create("Frame", {
						AnchorPoint = Vector2.new(0,0.5), BackgroundColor3 = Custom.ColorRGB, BorderSizePixel = 0,
						Position = UDim2.new(0,2,0.5,0), Size = UDim2.new(0,0,0,0), Name = "ChooseFrame",
					}, Opt)
					Custom:Create("UIStroke", { Color=Custom.ColorRGB, Thickness=1.6, Transparency=0.999 }, CF2)
					Custom:Create("UICorner", {}, CF2)
					OB.Activated:Connect(function()
						CircleClick(OB, Player:GetMouse().X, Player:GetMouse().Y)
						local sel = Opt.BackgroundTransparency > 0.95
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
							if ch.Name ~= "UIListLayout" and ch.Name ~= "SearchBar" then off = off + 5 + ch.Size.Y.Offset end
						end
						ScrollSel.CanvasSize = UDim2.new(0,0,0,off)
					end
					UpdateCanvas(); DropCount += 1
				end
				function FD:Refresh(list, sel)
					list = list or {}; sel = sel or {}
					FD:Clear()
					for _, d in ipairs(list) do FD:AddOption(d) end
					FD.Options = list; FD:Set(sel)
				end
				DDB.Activated:Connect(function()
					if not MoreBlur.Visible then
						MoreBlur.Visible = true
						DropPageLayout:JumpToIndex(SelFrame.LayoutOrder)
						TweenService:Create(MoreBlur, TweenInfo.new(0.1), {BackgroundTransparency=0.7}):Play()
						TweenService:Create(DropdownSelect, TweenInfo.new(0.1), {Position=UDim2.new(1,-11,0.5,0)}):Play()
					end
				end)
				FD:Refresh(FD.Options, FD.Value)
				ItemCount += 1; CountDropdown += 1; return FD
			end

			function Item:AddColorPicker(Config)
				local T   = Config[1] or Config.Title or ""
				local Col = Config[2] or Config.Color or Color3.fromRGB(255,255,255)
				local CB  = Config[3] or Config.Callback or function() end
				local FCP = { Color = Col }
				local CP = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 0.935,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,35), Name = "ColorPicker",
				}, SectionAdd)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, CP)
				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = T, TextColor3 = Color3.fromRGB(231,231,231), TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,0), Size = UDim2.new(1,-60,1,0),
				}, CP)
				local Display = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1,0.5), BackgroundColor3 = Col, BorderSizePixel = 0,
					Position = UDim2.new(1,-10,0.5,0), Size = UDim2.new(0,36,0,22), Name = "Display",
				}, CP)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, Display)
				Custom:Create("UIStroke", { Color=Color3.fromRGB(100,100,100), Thickness=1 }, Display)
				local Interact = Custom:Create("TextButton", {
					Text = "", BackgroundTransparency = 1, BorderSizePixel = 0,
					Size = UDim2.new(1,0,1,0), ZIndex = 5,
				}, CP)
				local Overlay = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(0,0,0), BackgroundTransparency = 0.5, BorderSizePixel = 0,
					Size = UDim2.new(1,0,1,0), Position = UDim2.new(0,0,0,0),
					ZIndex = 100, Visible = false, Name = "CPOverlay",
				}, Main)
				local OverlayClose = Custom:Create("TextButton", {
					Text = "", BackgroundTransparency = 1, BorderSizePixel = 0,
					Size = UDim2.new(1,0,1,0), ZIndex = 101,
				}, Overlay)
				local Panel = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(0.5,0.5), BackgroundColor3 = Color3.fromRGB(20,20,20),
					BorderSizePixel = 0, Position = UDim2.new(0.5,0,0.5,0),
					Size = UDim2.new(0,220,0,210), ZIndex = 102, Name = "CPPanel",
				}, Overlay)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,8) }, Panel)
				Custom:Create("UIStroke", { Color=Color3.fromRGB(60,60,60), Thickness=1.5 }, Panel)
				local PanelTop = Custom:Create("Frame", {
					BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1,0,0,32), ZIndex = 102,
				}, Panel)
				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = T,
					TextColor3 = Color3.fromRGB(220,220,220), TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Center, TextYAlignment = Enum.TextYAlignment.Center,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0,0,0,0), Size = UDim2.new(1,0,1,0), ZIndex = 102,
				}, PanelTop)
				Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(55,55,55), BackgroundTransparency = 0, BorderSizePixel = 0,
					Position = UDim2.new(0,0,0,32), Size = UDim2.new(1,0,0,1), ZIndex = 102,
				}, Panel)
				local CPBg = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromHSV(0,1,1), BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,40), Size = UDim2.new(1,-20,0,100), ZIndex = 102,
				}, Panel)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, CPBg)
				local WhiteGrad = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255,255,255), BorderSizePixel = 0, Size = UDim2.new(1,0,1,0), ZIndex = 102,
				}, CPBg)
				Custom:Create("UIGradient", {
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,255,255))},
					Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)},
					Rotation = 0,
				}, WhiteGrad)
				local BlackGrad = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(0,0,0), BorderSizePixel = 0, Size = UDim2.new(1,0,1,0), ZIndex = 102,
				}, CPBg)
				Custom:Create("UIGradient", {
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))},
					Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)},
					Rotation = 90,
				}, BlackGrad)
				local MainBtn = Custom:Create("TextButton", {
					Text = "", BackgroundTransparency = 1, BorderSizePixel = 0,
					Size = UDim2.new(1,0,1,0), ZIndex = 103,
				}, CPBg)
				local MainPoint = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(0.5,0.5), BackgroundColor3 = Color3.fromRGB(255,255,255),
					BorderSizePixel = 0, Size = UDim2.new(0,10,0,10), Position = UDim2.new(1,0,0,0), ZIndex = 104,
				}, CPBg)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,99) }, MainPoint)
				Custom:Create("UIStroke", { Color=Color3.fromRGB(255,255,255), Thickness=1.5 }, MainPoint)
				local HueSlider = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255,0,0), BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,150), Size = UDim2.new(1,-20,0,12), ZIndex = 102,
				}, Panel)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,3) }, HueSlider)
				local HueGradFrame = Custom:Create("Frame", {
					Size = UDim2.new(1,0,1,0), BackgroundColor3 = Color3.fromRGB(255,0,0),
					BorderSizePixel = 0, ZIndex = 102,
				}, HueSlider)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,3) }, HueGradFrame)
				Custom:Create("UIGradient", {
					Color = ColorSequence.new{
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
					Text = "", BackgroundTransparency = 1, BorderSizePixel = 0,
					Size = UDim2.new(1,0,1,0), ZIndex = 103,
				}, HueSlider)
				local SliderPoint = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(0.5,0.5), BackgroundColor3 = Color3.fromRGB(255,255,255),
					BorderSizePixel = 0, Size = UDim2.new(0,14,0,14), Position = UDim2.new(0,0,0.5,0), ZIndex = 104,
				}, HueSlider)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,99) }, SliderPoint)
				Custom:Create("UIStroke", { Color=Color3.fromRGB(255,255,255), Thickness=1.5 }, SliderPoint)
				local HexFrame = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(30,30,30), BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,172), Size = UDim2.new(1,-20,0,26), ZIndex = 102,
				}, Panel)
				Custom:Create("UICorner", { CornerRadius=UDim.new(0,4) }, HexFrame)
				Custom:Create("UIStroke", { Color=Color3.fromRGB(70,70,70), Thickness=1 }, HexFrame)
				local HexBox = Custom:Create("TextBox", {
					Font = Enum.Font.GothamBold, PlaceholderText = "#FFFFFF",
					PlaceholderColor3 = Color3.fromRGB(100,100,100),
					Text = "", TextColor3 = Color3.fromRGB(255,255,255), TextSize = 12,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Size = UDim2.new(1,-8,1,0), Position = UDim2.new(0,4,0,0), ZIndex = 103,
				}, HexFrame)
				local opened = false
				local mainDragging = false
				local hueDragging  = false
				local mouse = Player:GetMouse()
				local h, s, v2 = Col:ToHSV()
				local function setDisplay()
					local c = Color3.fromHSV(h,s,v2)
					CPBg.BackgroundColor3 = Color3.fromHSV(h,1,1)
					MainPoint.Position = UDim2.new(s,-5,1-v2,-5)
					MainPoint.BackgroundColor3 = c
					SliderPoint.Position = UDim2.new(h,-7,0.5,0)
					SliderPoint.BackgroundColor3 = Color3.fromHSV(h,1,1)
					Display.BackgroundColor3 = c
					HexBox.Text = string.format("#%02X%02X%02X", c.R*0xFF, c.G*0xFF, c.B*0xFF)
					FCP.Color = c
				end
				setDisplay()
				local function openModal()
					if opened then return end
					opened = true; Overlay.Visible = true
					Overlay.BackgroundTransparency = 1
					Panel.Size = UDim2.new(0,0,0,0); Panel.Position = UDim2.new(0.5,0,0.5,0)
					Panel.BackgroundTransparency = 1
					TweenService:Create(Overlay, TweenInfo.new(0.2), {BackgroundTransparency=0.5}):Play()
					TweenService:Create(Panel, TweenInfo.new(0.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {
						Size=UDim2.new(0,220,0,210), BackgroundTransparency=0,
					}):Play()
					setDisplay(); task.wait(0.3); setDisplay()
				end
				local function closeModal()
					if not opened then return end
					opened = false; mainDragging = false; hueDragging = false
					TweenService:Create(Overlay, TweenInfo.new(0.22), {BackgroundTransparency=1}):Play()
					TweenService:Create(Panel, TweenInfo.new(0.22,Enum.EasingStyle.Quad,Enum.EasingDirection.In), {
						Position=UDim2.new(0.5,0,0.65,0), BackgroundTransparency=1,
					}):Play()
					task.wait(0.22); Overlay.Visible = false
					Panel.Position = UDim2.new(0.5,0,0.5,0); Panel.BackgroundTransparency = 0
				end
				Interact.Activated:Connect(function() task.spawn(openModal) end)
				OverlayClose.Activated:Connect(function() task.spawn(closeModal) end)
				UserInputService.InputEnded:Connect(function(inp)
					if inp.UserInputType == Enum.UserInputType.MouseButton1
					or inp.UserInputType == Enum.UserInputType.Touch then
						if mainDragging or hueDragging then pcall(function() CB(Color3.fromHSV(h,s,v2)) end) end
						mainDragging = false; hueDragging = false
					end
				end)
				MainBtn.MouseButton1Down:Connect(function() if opened then mainDragging = true end end)
				HueBtn.MouseButton1Down:Connect(function() if opened then hueDragging = true end end)
				HexBox.FocusLost:Connect(function()
					local ok = pcall(function()
						local r,g,b = string.match(HexBox.Text,"^#?(%w%w)(%w%w)(%w%w)$")
						local c = Color3.fromRGB(tonumber(r,16),tonumber(g,16),tonumber(b,16))
						h,s,v2 = c:ToHSV(); setDisplay(); pcall(function() CB(Color3.fromHSV(h,s,v2)) end)
					end)
					if not ok then setDisplay() end
				end)
				local renderConn = RunService.RenderStepped:Connect(function()
					if mainDragging then
						local lx = math.clamp(mouse.X - CPBg.AbsolutePosition.X, 0, CPBg.AbsoluteSize.X)
						local ly = math.clamp(mouse.Y - CPBg.AbsolutePosition.Y, 0, CPBg.AbsoluteSize.Y)
						s = lx / math.max(CPBg.AbsoluteSize.X, 1)
						v2 = 1 - (ly / math.max(CPBg.AbsoluteSize.Y, 1))
						MainPoint.Position = UDim2.new(0, lx-MainPoint.AbsoluteSize.X/2, 0, ly-MainPoint.AbsoluteSize.Y/2)
						MainPoint.BackgroundColor3 = Color3.fromHSV(h,s,v2)
						Display.BackgroundColor3 = Color3.fromHSV(h,s,v2)
						HexBox.Text = string.format("#%02X%02X%02X", Color3.fromHSV(h,s,v2).R*0xFF, Color3.fromHSV(h,s,v2).G*0xFF, Color3.fromHSV(h,s,v2).B*0xFF)
						FCP.Color = Color3.fromHSV(h,s,v2)
						pcall(function() CB(FCP.Color) end)
					end
					if hueDragging then
						local lx = math.clamp(mouse.X - HueSlider.AbsolutePosition.X, 0, HueSlider.AbsoluteSize.X)
						h = lx / math.max(HueSlider.AbsoluteSize.X, 1)
						CPBg.BackgroundColor3 = Color3.fromHSV(h,1,1)
						SliderPoint.Position = UDim2.new(h,-7,0.5,0)
						SliderPoint.BackgroundColor3 = Color3.fromHSV(h,1,1)
						Display.BackgroundColor3 = Color3.fromHSV(h,s,v2)
						MainPoint.BackgroundColor3 = Color3.fromHSV(h,s,v2)
						HexBox.Text = string.format("#%02X%02X%02X", Color3.fromHSV(h,s,v2).R*0xFF, Color3.fromHSV(h,s,v2).G*0xFF, Color3.fromHSV(h,s,v2).B*0xFF)
						FCP.Color = Color3.fromHSV(h,s,v2)
						pcall(function() CB(FCP.Color) end)
					end
				end)
				CP.Destroying:Connect(function()
					if renderConn then renderConn:Disconnect() end
					if Overlay and Overlay.Parent then Overlay:Destroy() end
				end)
				function FCP:Set(c)
					FCP.Color = c; h,s,v2 = c:ToHSV(); setDisplay()
				end
				ItemCount += 1; return FCP
			end

			ItemCount += 1
			return Item
		end

		CountTab += 1
		return Sections
	end

	return Tabs
end

return CosyHub

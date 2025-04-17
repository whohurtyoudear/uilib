-- Synthwave UI Library v2.0
-- Enhanced with more features, better organization, and improved visuals
-- By whohurtyoudear (enhanced by AI)

local Library = {}
Library.__index = Library

-- Colors with Synthwave palette
local colors = {
    background = Color3.fromRGB(25, 25, 40),
    accent = Color3.fromRGB(255, 65, 180),
    secondary = Color3.fromRGB(65, 200, 255),
    text = Color3.fromRGB(255, 255, 255),
    dark = Color3.fromRGB(15, 15, 25),
    darker = Color3.fromRGB(10, 10, 20),
    success = Color3.fromRGB(65, 255, 180),
    warning = Color3.fromRGB(255, 180, 65),
    error = Color3.fromRGB(255, 65, 65)
}

-- Utility functions
local function tween(obj, props, duration, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    game:GetService("TweenService"):Create(obj, TweenInfo.new(duration, style, direction), props):Play()
end

local function createHighlight(frame)
    local highlight = Instance.new("Frame")
    highlight.Name = "Highlight"
    highlight.BackgroundColor3 = colors.accent
    highlight.BorderSizePixel = 0
    highlight.Size = UDim2.new(0, 0, 1, 0)
    highlight.Position = UDim2.new(0, 0, 0, 0)
    highlight.ZIndex = 2
    highlight.Parent = frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = highlight
    
    return highlight
end

-- Main Library Functions
function Library:CreateWindow(title)
    local self = setmetatable({}, Library)
    self.title = title or "Synthwave UI"
    self.tabs = {}
    self.notifications = {}
    self.theme = colors
    
    -- Main screen gui
    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = "SynthwaveUI"
    self.screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    self.screenGui.ResetOnSpawn = false
    self.screenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main container
    self.mainFrame = Instance.new("Frame")
    self.mainFrame.Name = "MainFrame"
    self.mainFrame.BackgroundColor3 = self.theme.background
    self.mainFrame.Size = UDim2.new(0, 450, 0, 500)
    self.mainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
    self.mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.mainFrame.ClipsDescendants = true
    self.mainFrame.Parent = self.screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = self.mainFrame
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    mainStroke.Color = self.theme.accent
    mainStroke.Thickness = 2
    mainStroke.Parent = self.mainFrame
    
    -- Header
    self.header = Instance.new("Frame")
    self.header.Name = "Header"
    self.header.BackgroundColor3 = self.theme.dark
    self.header.Size = UDim2.new(1, 0, 0, 40)
    self.header.Position = UDim2.new(0, 0, 0, 0)
    self.header.Parent = self.mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 8)
    headerCorner.Parent = self.header
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Text = self.title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = self.theme.text
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = self.header
    
    -- Close button
    self.closeButton = Instance.new("TextButton")
    self.closeButton.Name = "CloseButton"
    self.closeButton.Text = "X"
    self.closeButton.Font = Enum.Font.GothamBold
    self.closeButton.TextSize = 18
    self.closeButton.TextColor3 = self.theme.text
    self.closeButton.BackgroundColor3 = self.theme.darker
    self.closeButton.Size = UDim2.new(0, 40, 1, 0)
    self.closeButton.Position = UDim2.new(1, -40, 0, 0)
    self.closeButton.Parent = self.header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = self.closeButton
    
    self.closeButton.MouseEnter:Connect(function()
        tween(self.closeButton, {BackgroundColor3 = self.theme.error}, 0.2)
    end)
    
    self.closeButton.MouseLeave:Connect(function()
        tween(self.closeButton, {BackgroundColor3 = self.theme.darker}, 0.2)
    end)
    
    self.closeButton.MouseButton1Click:Connect(function()
        self.screenGui:Destroy()
    end)
    
    -- Tab buttons container
    self.tabButtonsFrame = Instance.new("Frame")
    self.tabButtonsFrame.Name = "TabButtons"
    self.tabButtonsFrame.BackgroundColor3 = self.theme.dark
    self.tabButtonsFrame.Size = UDim2.new(1, 0, 0, 40)
    self.tabButtonsFrame.Position = UDim2.new(0, 0, 0, 40)
    self.tabButtonsFrame.Parent = self.mainFrame
    
    local tabButtonsList = Instance.new("UIListLayout")
    tabButtonsList.FillDirection = Enum.FillDirection.Horizontal
    tabButtonsList.Padding = UDim.new(0, 0)
    tabButtonsList.Parent = self.tabButtonsFrame
    
    -- Content frame
    self.contentFrame = Instance.new("Frame")
    self.contentFrame.Name = "Content"
    self.contentFrame.BackgroundColor3 = self.theme.darker
    self.contentFrame.Size = UDim2.new(1, -20, 1, -100)
    self.contentFrame.Position = UDim2.new(0, 10, 0, 90)
    self.contentFrame.Parent = self.mainFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 6)
    contentCorner.Parent = self.contentFrame
    
    local contentList = Instance.new("UIListLayout")
    contentList.Padding = UDim.new(0, 10)
    contentList.Parent = self.contentFrame
    
    -- Make draggable
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        tween(self.mainFrame, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, 0.1)
    end
    
    self.header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    self.header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Notification handler
    self.notificationFrame = Instance.new("Frame")
    self.notificationFrame.Name = "Notifications"
    self.notificationFrame.BackgroundTransparency = 1
    self.notificationFrame.Size = UDim2.new(0, 300, 1, -20)
    self.notificationFrame.Position = UDim2.new(1, -310, 0, 10)
    self.notificationFrame.AnchorPoint = Vector2.new(1, 0)
    self.notificationFrame.Parent = self.screenGui
    
    local notificationList = Instance.new("UIListLayout")
    notificationList.SortOrder = Enum.SortOrder.LayoutOrder
    notificationList.Padding = UDim.new(0, 10)
    notificationList.Parent = self.notificationFrame
    
    return self
end

function Library:CreateTab(name)
    local tab = {}
    tab.name = name
    tab.elements = {}
    tab.parent = self
    
    -- Tab button
    tab.button = Instance.new("TextButton")
    tab.button.Name = name
    tab.button.Text = name
    tab.button.Font = Enum.Font.Gotham
    tab.button.TextSize = 14
    tab.button.TextColor3 = self.theme.text
    tab.button.BackgroundColor3 = self.theme.dark
    tab.button.AutoButtonColor = false
    tab.button.Size = UDim2.new(0, 100, 1, 0)
    tab.button.Parent = self.tabButtonsFrame
    
    tab.highlight = createHighlight(tab.button)
    
    -- Tab content
    tab.content = Instance.new("ScrollingFrame")
    tab.content.Name = name
    tab.content.BackgroundTransparency = 1
    tab.content.Size = UDim2.new(1, 0, 1, 0)
    tab.content.Position = UDim2.new(0, 0, 0, 0)
    tab.content.Visible = false
    tab.content.ScrollBarThickness = 4
    tab.content.ScrollBarImageColor3 = self.theme.accent
    tab.content.Parent = self.contentFrame
    
    local contentList = Instance.new("UIListLayout")
    contentList.Padding = UDim.new(0, 10)
    contentList.Parent = tab.content
    
    tab.button.MouseEnter:Connect(function()
        tween(tab.highlight, {Size = UDim2.new(1, 0, 1, 0)}, 0.2)
    end)
    
    tab.button.MouseLeave:Connect(function()
        if not tab.content.Visible then
            tween(tab.highlight, {Size = UDim2.new(0, 0, 1, 0)}, 0.2)
        end
    end)
    
    tab.button.MouseButton1Click:Connect(function()
        for _, otherTab in pairs(self.tabs) do
            otherTab.content.Visible = false
            tween(otherTab.highlight, {Size = UDim2.new(0, 0, 1, 0)}, 0.2)
        end
        
        tab.content.Visible = true
        tween(tab.highlight, {Size = UDim2.new(1, 0, 1, 0)}, 0.2)
    end)
    
    -- Make first tab active by default
    if #self.tabs == 0 then
        tab.content.Visible = true
        tween(tab.highlight, {Size = UDim2.new(1, 0, 1, 0)}, 0.2)
    end
    
    table.insert(self.tabs, tab)
    
    -- Tab methods
    function tab:AddButton(text, callback)
        local button = Instance.new("TextButton")
        button.Name = text
        button.Text = text
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.TextColor3 = self.parent.theme.text
        button.BackgroundColor3 = self.parent.theme.dark
        button.Size = UDim2.new(1, -20, 0, 35)
        button.Position = UDim2.new(0, 10, 0, 0)
        button.Parent = self.content
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button
        
        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.Color = self.parent.theme.darker
        buttonStroke.Thickness = 1
        buttonStroke.Parent = button
        
        local buttonHighlight = createHighlight(button)
        buttonHighlight.ZIndex = 0
        
        button.MouseEnter:Connect(function()
            tween(buttonHighlight, {Size = UDim2.new(1, 0, 1, 0)}, 0.2)
            tween(buttonStroke, {Color = self.parent.theme.accent}, 0.2)
        end)
        
        button.MouseLeave:Connect(function()
            tween(buttonHighlight, {Size = UDim2.new(0, 0, 1, 0)}, 0.2)
            tween(buttonStroke, {Color = self.parent.theme.darker}, 0.2)
        end)
        
        button.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)
        
        table.insert(self.elements, button)
        return button
    end
    
    function tab:AddToggle(text, default, callback)
        local toggle = {}
        toggle.value = default or false
        
        local frame = Instance.new("Frame")
        frame.Name = text
        frame.BackgroundColor3 = self.parent.theme.dark
        frame.Size = UDim2.new(1, -20, 0, 35)
        frame.Position = UDim2.new(0, 10, 0, 0)
        frame.Parent = self.content
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 6)
        frameCorner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = self.parent.theme.text
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0.7, -10, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Name = "Toggle"
        toggleFrame.BackgroundColor3 = self.parent.theme.darker
        toggleFrame.Size = UDim2.new(0, 50, 0, 25)
        toggleFrame.Position = UDim2.new(1, -60, 0.5, -12.5)
        toggleFrame.AnchorPoint = Vector2.new(1, 0.5)
        toggleFrame.Parent = frame
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 12)
        toggleCorner.Parent = toggleFrame
        
        local toggleButton = Instance.new("Frame")
        toggleButton.Name = "Button"
        toggleButton.BackgroundColor3 = self.parent.theme.text
        toggleButton.Size = UDim2.new(0, 21, 0, 21)
        toggleButton.Position = UDim2.new(0, 2, 0.5, -10.5)
        toggleButton.AnchorPoint = Vector2.new(0, 0.5)
        toggleButton.Parent = toggleFrame
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 10)
        buttonCorner.Parent = toggleButton
        
        local function updateToggle()
            if toggle.value then
                tween(toggleButton, {Position = UDim2.new(1, -23, 0.5, -10.5), BackgroundColor3 = self.parent.theme.accent}, 0.2)
                tween(toggleFrame, {BackgroundColor3 = Color3.fromRGB(65, 25, 60)}, 0.2)
            else
                tween(toggleButton, {Position = UDim2.new(0, 2, 0.5, -10.5), BackgroundColor3 = self.parent.theme.text}, 0.2)
                tween(toggleFrame, {BackgroundColor3 = self.parent.theme.darker}, 0.2)
            end
        end
        
        updateToggle()
        
        frame.MouseButton1Click:Connect(function()
            toggle.value = not toggle.value
            updateToggle()
            if callback then
                callback(toggle.value)
            end
        end)
        
        table.insert(self.elements, toggle)
        return toggle
    end
    
    function tab:AddSlider(text, min, max, default, callback, precise)
        local slider = {}
        slider.value = default or min
        slider.min = min or 0
        slider.max = max or 100
        slider.precise = precise or false
        
        local frame = Instance.new("Frame")
        frame.Name = text
        frame.BackgroundColor3 = self.parent.theme.dark
        frame.Size = UDim2.new(1, -20, 0, 60)
        frame.Position = UDim2.new(0, 10, 0, 0)
        frame.Parent = self.content
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 6)
        frameCorner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = self.parent.theme.text
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, -20, 0, 20)
        label.Position = UDim2.new(0, 10, 0, 5)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Name = "Value"
        valueLabel.Text = tostring(slider.value)
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextSize = 14
        valueLabel.TextColor3 = self.parent.theme.text
        valueLabel.BackgroundTransparency = 1
        valueLabel.Size = UDim2.new(1, -20, 0, 20)
        valueLabel.Position = UDim2.new(0, 10, 0, 25)
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Parent = frame
        
        local sliderTrack = Instance.new("Frame")
        sliderTrack.Name = "Track"
        sliderTrack.BackgroundColor3 = self.parent.theme.darker
        sliderTrack.Size = UDim2.new(1, -20, 0, 5)
        sliderTrack.Position = UDim2.new(0, 10, 1, -15)
        sliderTrack.Parent = frame
        
        local trackCorner = Instance.new("UICorner")
        trackCorner.CornerRadius = UDim.new(0, 2)
        trackCorner.Parent = sliderTrack
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Name = "Fill"
        sliderFill.BackgroundColor3 = self.parent.theme.accent
        sliderFill.Size = UDim2.new((slider.value - slider.min) / (slider.max - slider.min), 0, 1, 0)
        sliderFill.Position = UDim2.new(0, 0, 0, 0)
        sliderFill.Parent = sliderTrack
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 2)
        fillCorner.Parent = sliderFill
        
        local sliderButton = Instance.new("TextButton")
        sliderButton.Name = "Button"
        sliderButton.Text = ""
        sliderButton.BackgroundColor3 = self.parent.theme.text
        sliderButton.Size = UDim2.new(0, 15, 0, 15)
        sliderButton.Position = UDim2.new((slider.value - slider.min) / (slider.max - slider.min), -7.5, 0.5, -7.5)
        sliderButton.AnchorPoint = Vector2.new(0.5, 0.5)
        sliderButton.Parent = sliderTrack
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 7)
        buttonCorner.Parent = sliderButton
        
        local function updateSlider(value)
            value = math.clamp(value, slider.min, slider.max)
            if slider.precise then
                value = math.floor(value * 100) / 100
            else
                value = math.floor(value)
            end
            
            slider.value = value
            valueLabel.Text = tostring(value)
            
            local fillSize = (value - slider.min) / (slider.max - slider.min)
            tween(sliderFill, {Size = UDim2.new(fillSize, 0, 1, 0)}, 0.1)
            tween(sliderButton, {Position = UDim2.new(fillSize, -7.5, 0.5, -7.5)}, 0.1)
            
            if callback then
                callback(value)
            end
        end
        
        local dragging = false
        local function slide(input)
            local pos = UDim2.new(math.clamp((input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X, 0, 1), 0, 0.5, 0)
            local value = slider.min + (pos.X.Scale * (slider.max - slider.min))
            updateSlider(value)
        end
        
        sliderButton.MouseButton1Down:Connect(function()
            dragging = true
        end)
        
        sliderTrack.MouseButton1Down:Connect(function(input)
            dragging = true
            slide(input)
        end)
        
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                slide(input)
            end
        end)
        
        table.insert(self.elements, slider)
        return slider
    end
    
    function tab:AddDropdown(text, options, callback, default)
        local dropdown = {}
        dropdown.options = options or {}
        dropdown.value = default or options[1]
        dropdown.open = false
        
        local frame = Instance.new("Frame")
        frame.Name = text
        frame.BackgroundColor3 = self.parent.theme.dark
        frame.Size = UDim2.new(1, -20, 0, 35)
        frame.Position = UDim2.new(0, 10, 0, 0)
        frame.Parent = self.content
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 6)
        frameCorner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = self.parent.theme.text
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0.7, -10, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Name = "Value"
        valueLabel.Text = dropdown.value
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextSize = 14
        valueLabel.TextColor3 = self.parent.theme.text
        valueLabel.BackgroundTransparency = 1
        valueLabel.Size = UDim2.new(0.3, -10, 1, 0)
        valueLabel.Position = UDim2.new(0.7, 10, 0, 0)
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Parent = frame
        
        local dropdownList = Instance.new("ScrollingFrame")
        dropdownList.Name = "DropdownList"
        dropdownList.BackgroundColor3 = self.parent.theme.darker
        dropdownList.Size = UDim2.new(1, 0, 0, 0)
        dropdownList.Position = UDim2.new(0, 0, 1, 5)
        dropdownList.Visible = false
        dropdownList.ScrollBarThickness = 4
        dropdownList.ScrollBarImageColor3 = self.parent.theme.accent
        dropdownList.AutomaticCanvasSize = Enum.AutomaticSize.Y
        dropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
        dropdownList.Parent = frame
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 2)
        listLayout.Parent = dropdownList
        
        local listCorner = Instance.new("UICorner")
        listCorner.CornerRadius = UDim.new(0, 6)
        listCorner.Parent = dropdownList
        
        local function toggleDropdown()
            dropdown.open = not dropdown.open
            if dropdown.open then
                dropdownList.Visible = true
                tween(dropdownList, {Size = UDim2.new(1, 0, 0, math.min(#dropdown.options * 30, 150))}, 0.2)
            else
                tween(dropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, function()
                    dropdownList.Visible = false
                end)
            end
        end
        
        local function createOption(option)
            local optionButton = Instance.new("TextButton")
            optionButton.Name = option
            optionButton.Text = option
            optionButton.Font = Enum.Font.Gotham
            optionButton.TextSize = 14
            optionButton.TextColor3 = self.parent.theme.text
            optionButton.BackgroundColor3 = self.parent.theme.darker
            optionButton.Size = UDim2.new(1, -10, 0, 30)
            optionButton.Position = UDim2.new(0, 5, 0, 0)
            optionButton.Parent = dropdownList
            
            local optionCorner = Instance.new("UICorner")
            optionCorner.CornerRadius = UDim.new(0, 4)
            optionCorner.Parent = optionButton
            
            optionButton.MouseEnter:Connect(function()
                tween(optionButton, {BackgroundColor3 = self.parent.theme.dark}, 0.2)
            end)
            
            optionButton.MouseLeave:Connect(function()
                tween(optionButton, {BackgroundColor3 = self.parent.theme.darker}, 0.2)
            end)
            
            optionButton.MouseButton1Click:Connect(function()
                dropdown.value = option
                valueLabel.Text = option
                toggleDropdown()
                if callback then
                    callback(option)
                end
            end)
        end
        
        for _, option in pairs(dropdown.options) do
            createOption(option)
        end
        
        frame.MouseButton1Click:Connect(toggleDropdown)
        
        table.insert(self.elements, dropdown)
        return dropdown
    end
    
    function tab:AddLabel(text)
        local label = Instance.new("TextLabel")
        label.Name = text
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = self.parent.theme.text
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, -20, 0, 20)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = self.content
        
        table.insert(self.elements, label)
        return label
    end
    
    function tab:AddTextBox(text, placeholder, callback)
        local textbox = {}
        
        local frame = Instance.new("Frame")
        frame.Name = text
        frame.BackgroundColor3 = self.parent.theme.dark
        frame.Size = UDim2.new(1, -20, 0, 35)
        frame.Position = UDim2.new(0, 10, 0, 0)
        frame.Parent = self.content
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 6)
        frameCorner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = self.parent.theme.text
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0.4, -10, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local input = Instance.new("TextBox")
        input.Name = "Input"
        input.Text = ""
        input.PlaceholderText = placeholder or "Enter text..."
        input.Font = Enum.Font.Gotham
        input.TextSize = 14
        input.TextColor3 = self.parent.theme.text
        input.BackgroundColor3 = self.parent.theme.darker
        input.Size = UDim2.new(0.6, -20, 0, 25)
        input.Position = UDim2.new(0.4, 10, 0.5, -12.5)
        input.Parent = frame
        
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 4)
        inputCorner.Parent = input
        
        input.FocusLost:Connect(function(enterPressed)
            if enterPressed and callback then
                callback(input.Text)
            end
        end)
        
        table.insert(self.elements, textbox)
        return textbox
    end
    
    function tab:AddKeybind(text, default, callback)
        local keybind = {}
        keybind.value = default or Enum.KeyCode.Unknown
        keybind.listening = false
        
        local frame = Instance.new("Frame")
        frame.Name = text
        frame.BackgroundColor3 = self.parent.theme.dark
        frame.Size = UDim2.new(1, -20, 0, 35)
        frame.Position = UDim2.new(0, 10, 0, 0)
        frame.Parent = self.content
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 6)
        frameCorner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = self.parent.theme.text
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0.7, -10, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local keyLabel = Instance.new("TextButton")
        keyLabel.Name = "Key"
        keyLabel.Text = tostring(keybind.value.Name)
        keyLabel.Font = Enum.Font.Gotham
        keyLabel.TextSize = 14
        keyLabel.TextColor3 = self.parent.theme.text
        keyLabel.BackgroundColor3 = self.parent.theme.darker
        keyLabel.Size = UDim2.new(0.3, -20, 0, 25)
        keyLabel.Position = UDim2.new(0.7, 10, 0.5, -12.5)
        keyLabel.Parent = frame
        
        local keyCorner = Instance.new("UICorner")
        keyCorner.CornerRadius = UDim.new(0, 4)
        keyCorner.Parent = keyLabel
        
        local function updateKeybind(key)
            keybind.value = key
            keyLabel.Text = tostring(key.Name)
            keybind.listening = false
            tween(keyLabel, {BackgroundColor3 = self.parent.theme.darker}, 0.2)
        end
        
        keyLabel.MouseButton1Click:Connect(function()
            if not keybind.listening then
                keybind.listening = true
                keyLabel.Text = "..."
                tween(keyLabel, {BackgroundColor3 = self.parent.theme.accent}, 0.2)
            end
        end)
        
        game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if keybind.listening and not gameProcessed then
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    updateKeybind(input.KeyCode)
                    if callback then
                        callback(input.KeyCode)
                    end
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    updateKeybind(Enum.KeyCode.MouseButton1)
                    if callback then
                        callback(Enum.KeyCode.MouseButton1)
                    end
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    updateKeybind(Enum.KeyCode.MouseButton2)
                    if callback then
                        callback(Enum.KeyCode.MouseButton2)
                    end
                end
            elseif not keybind.listening and input.KeyCode == keybind.value then
                if callback then
                    callback(keybind.value)
                end
            end
        end)
        
        table.insert(self.elements, keybind)
        return keybind
    end
    
    function tab:AddColorPicker(text, default, callback)
        local colorpicker = {}
        colorpicker.value = default or Color3.fromRGB(255, 255, 255)
        
        local frame = Instance.new("Frame")
        frame.Name = text
        frame.BackgroundColor3 = self.parent.theme.dark
        frame.Size = UDim2.new(1, -20, 0, 35)
        frame.Position = UDim2.new(0, 10, 0, 0)
        frame.Parent = self.content
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 6)
        frameCorner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = self.parent.theme.text
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0.7, -10, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local colorBox = Instance.new("TextButton")
        colorBox.Name = "Color"
        colorBox.Text = ""
        colorBox.BackgroundColor3 = colorpicker.value
        colorBox.Size = UDim2.new(0.3, -20, 0, 25)
        colorBox.Position = UDim2.new(0.7, 10, 0.5, -12.5)
        colorBox.Parent = frame
        
        local colorCorner = Instance.new("UICorner")
        colorCorner.CornerRadius = UDim.new(0, 4)
        colorCorner.Parent = colorBox
        
        local colorPickerFrame = Instance.new("Frame")
        colorPickerFrame.Name = "ColorPicker"
        colorPickerFrame.BackgroundColor3 = self.parent.theme.darker
        colorPickerFrame.Size = UDim2.new(0, 200, 0, 150)
        colorPickerFrame.Position = UDim2.new(1, 10, 0, 0)
        colorPickerFrame.Visible = false
        colorPickerFrame.Parent = frame
        
        local pickerCorner = Instance.new("UICorner")
        pickerCorner.CornerRadius = UDim.new(0, 6)
        pickerCorner.Parent = colorPickerFrame
        
        local hueSlider = Instance.new("Frame")
        hueSlider.Name = "HueSlider"
        hueSlider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        hueSlider.Size = UDim2.new(0, 20, 1, -20)
        hueSlider.Position = UDim2.new(1, -25, 0, 10)
        hueSlider.Parent = colorPickerFrame
        
        local hueGradient = Instance.new("UIGradient")
        hueGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 255))),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255))),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255))),
            ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0))),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0))),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)))
        }
        hueGradient.Parent = hueSlider
        
        local hueCorner = Instance.new("UICorner")
        hueCorner.CornerRadius = UDim.new(0, 4)
        hueCorner.Parent = hueSlider
        
        local hueSelector = Instance.new("Frame")
        hueSelector.Name = "Selector"
        hueSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        hueSelector.Size = UDim2.new(1, 0, 0, 2)
        hueSelector.Position = UDim2.new(0, 0, 0, 0)
        hueSelector.Parent = hueSlider
        
        local selectorCorner = Instance.new("UICorner")
        selectorCorner.CornerRadius = UDim.new(0, 1)
        selectorCorner.Parent = hueSelector
        
        local saturationBox = Instance.new("ImageButton")
        saturationBox.Name = "SaturationBox"
        saturationBox.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        saturationBox.Size = UDim2.new(1, -30, 1, -20)
        saturationBox.Position = UDim2.new(0, 10, 0, 10)
        saturationBox.Parent = colorPickerFrame
        
        local saturationGradient1 = Instance.new("UIGradient")
        saturationGradient1.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))),
            ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 1, 1)))
        }
        saturationGradient1.Rotation = 90
        saturationGradient1.Parent = saturationBox
        
        local saturationGradient2 = Instance.new("UIGradient")
        saturationGradient2.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0))),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0, 0)))
        }
        saturationGradient2.Parent = saturationBox
        
        local saturationCorner = Instance.new("UICorner")
        saturationCorner.CornerRadius = UDim.new(0, 4)
        saturationCorner.Parent = saturationBox
        
        local saturationSelector = Instance.new("Frame")
        saturationSelector.Name = "Selector"
        saturationSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        saturationSelector.Size = UDim2.new(0, 6, 0, 6)
        saturationSelector.Position = UDim2.new(1, 0, 1, 0)
        saturationSelector.AnchorPoint = Vector2.new(1, 1)
        saturationSelector.Parent = saturationBox
        
        local selectorCorner2 = Instance.new("UICorner")
        selectorCorner2.CornerRadius = UDim.new(1, 0)
        selectorCorner2.Parent = saturationSelector
        
        local previewBox = Instance.new("Frame")
        previewBox.Name = "Preview"
        previewBox.BackgroundColor3 = colorpicker.value
        previewBox.Size = UDim2.new(0, 30, 0, 20)
        previewBox.Position = UDim2.new(0, 10, 1, -25)
        previewBox.Parent = colorPickerFrame
        
        local previewCorner = Instance.new("UICorner")
        previewCorner.CornerRadius = UDim.new(0, 4)
        previewCorner.Parent = previewBox
        
        local hexLabel = Instance.new("TextLabel")
        hexLabel.Name = "Hex"
        hexLabel.Text = "#" .. string.format("%02X%02X%02X", colorpicker.value.r * 255, colorpicker.value.g * 255, colorpicker.value.b * 255)
        hexLabel.Font = Enum.Font.Gotham
        hexLabel.TextSize = 12
        hexLabel.TextColor3 = self.parent.theme.text
        hexLabel.BackgroundTransparency = 1
        hexLabel.Size = UDim2.new(1, -50, 0, 20)
        hexLabel.Position = UDim2.new(0, 50, 1, -25)
        hexLabel.TextXAlignment = Enum.TextXAlignment.Left
        hexLabel.Parent = colorPickerFrame
        
        local function updateColor(hue, sat, val)
            local color = Color3.fromHSV(hue, sat, val)
            colorpicker.value = color
            colorBox.BackgroundColor3 = color
            previewBox.BackgroundColor3 = color
            hexLabel.Text = "#" .. string.format("%02X%02X%02X", color.r * 255, color.g * 255, color.b * 255)
            
            if callback then
                callback(color)
            end
        end
        
        local function togglePicker()
            colorPickerFrame.Visible = not colorPickerFrame.Visible
        end
        
        colorBox.MouseButton1Click:Connect(togglePicker)
        
        local hueDragging = false
        local satDragging = false
        
        hueSlider.MouseButton1Down:Connect(function()
            hueDragging = true
        end)
        
        saturationBox.MouseButton1Down:Connect(function()
            satDragging = true
        end)
        
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                hueDragging = false
                satDragging = false
            end
        end)
        
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if hueDragging then
                    local y = math.clamp((input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y, 0, 1)
                    hueSelector.Position = UDim2.new(0, 0, y, 0)
                    local hue = 1 - y
                    local r, g, b = saturationBox.BackgroundColor3.r, saturationBox.BackgroundColor3.g, saturationBox.BackgroundColor3.b
                    local h, s, v = Color3.toHSV(Color3.fromRGB(r * 255, g * 255, b * 255))
                    updateColor(hue, s, v)
                elseif satDragging then
                    local x = math.clamp((input.Position.X - saturationBox.AbsolutePosition.X) / saturationBox.AbsoluteSize.X, 0, 1)
                    local y = math.clamp((input.Position.Y - saturationBox.AbsolutePosition.Y) / saturationBox.AbsoluteSize.Y, 0, 1)
                    saturationSelector.Position = UDim2.new(x, 0, y, 0)
                    local sat = x
                    local val = 1 - y
                    local r, g, b = hueSlider.BackgroundColor3.r, hueSlider.BackgroundColor3.g, hueSlider.BackgroundColor3.b
                    local h, s, v = Color3.toHSV(Color3.fromRGB(r * 255, g * 255, b * 255))
                    updateColor(h, sat, val)
                end
            end
        end)
        
        table.insert(self.elements, colorpicker)
        return colorpicker
    end
    
    return tab
end

function Library:CreateNotification(title, text, duration)
    duration = duration or 5
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.BackgroundColor3 = self.theme.dark
    notification.Size = UDim2.new(1, 0, 0, 0)
    notification.Position = UDim2.new(0, 0, 0, 0)
    notification.ClipsDescendants = true
    notification.Parent = self.notificationFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = notification
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = self.theme.accent
    stroke.Thickness = 1
    stroke.Parent = notification
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextColor3 = self.theme.text
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -20, 0, 20)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notification
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "Text"
    textLabel.Text = text
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 12
    textLabel.TextColor3 = self.theme.text
    textLabel.TextWrapped = true
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, -20, 0, 0)
    textLabel.Position = UDim2.new(0, 10, 0, 35)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notification
    
    local textSize = game:GetService("TextService"):GetTextSize(text, 12, Enum.Font.Gotham, Vector2.new(280, math.huge))
    textLabel.Size = UDim2.new(1, -20, 0, textSize.Y)
    notification.Size = UDim2.new(1, 0, 0, textSize.Y + 45)
    
    tween(notification, {Size = UDim2.new(1, 0, 0, textSize.Y + 45)}, 0.2)
    
    task.delay(duration, function()
        tween(notification, {Size = UDim2.new(1, 0, 0, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, function()
            notification:Destroy()
        end)
    end)
    
    table.insert(self.notifications, notification)
    return notification
end

return Library

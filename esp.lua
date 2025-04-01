-- Gets Roblox services
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local P = game:GetService("Players")
local HS = game:GetService("HttpService")

-- Sets global functions
_G["setclipboard"] = write_clipboard or writeclipboard or setclipboard or set_clipboard or nil
_G["request"] = http_request or request or httprequest or nil
_G["readfile"] = readfile or read_file or nil
_G["writefile"] = writefile or write_file or nil
_G["isfile"] = isfile or is_file or nil

-- Function to check global variable existence
local function getGlobal(path)
    local value = ((getgenv and getgenv()) or getfenv())
    while value ~= nil and path ~= "" do
        local name, nextValue = string.match(path, "^([^.]+)%.?(.*)$")
        value = value[name]
        path = nextValue
    end
    return value~=nil
end

-- Function to make UI element draggable
local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        TS:Create(object, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = pos}):Play()
    end

    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = object.Position
            input.Changed:Connect(function() Dragging = false end)
        end
    end)

    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

-- Library object definition
local Lib = {}

function Lib:Init(Settings)
    local tic = tick()
    Settings = Settings or {}
    Settings.Debug = Settings.Debug or true

    -- Debug checks
    if Settings.Debug and not _G["UNCks_checked"] then
        local fails, passes = 0, 0
        for _, func in pairs({"setclipboard","request","readfile","writefile","isfile"}) do
            if getGlobal(func) then passes += 1 else fails += 1 end
        end
        _G["UNCks_checked"] = true
    end

    -- Default settings
    Settings.Title = Settings.Title or "Lunar Key System"
    Settings.Description = Settings.Description or "Purchase at Lunar.vip to get your key"
    Settings.Link = Settings.Link or "https://lunar.vip"
    Settings.SaveKey = Settings.SaveKey ~= false
    Settings.Verify = Settings.Verify or function() return true end
    Settings.Logo = Settings.Logo or "rbxassetid://8573754371"

    -- Main UI construction
    local KeySystem = Instance.new("ScreenGui")
    KeySystem.Name = "LunarKeySystem"
    KeySystem.DisplayOrder = 999
    KeySystem.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    KeySystem.Parent = P.LocalPlayer:WaitForChild("PlayerGui")

    local MainContainer = Instance.new("CanvasGroup")
    MainContainer.Name = "MainContainer"
    MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    MainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    MainContainer.BackgroundTransparency = 0
    MainContainer.GroupTransparency = 0
    MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainContainer.Size = UDim2.new(0, 450, 0, 300)
    MainContainer.Parent = KeySystem

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 14)
    MainCorner.Parent = MainContainer

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(80, 120, 200)
    MainStroke.Thickness = 2
    MainStroke.Transparency = 0.7
    MainStroke.Parent = MainContainer

    -- Moon glow effect
    local MoonGlow = Instance.new("ImageLabel")
    MoonGlow.Name = "MoonGlow"
    MoonGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    MoonGlow.BackgroundTransparency = 1
    MoonGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    MoonGlow.Size = UDim2.new(1, 100, 1, 100)
    MoonGlow.Image = Settings.Logo
    MoonGlow.ImageColor3 = Color3.fromRGB(30, 50, 100)
    MoonGlow.ImageTransparency = 0.85
    MoonGlow.ZIndex = -1
    MoonGlow.Parent = MainContainer

    -- Top bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.Parent = MainContainer

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.5, 0, 0.5, 0)
    Title.Size = UDim2.new(0.8, 0, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = Settings.Title
    Title.TextColor3 = Color3.fromRGB(220, 230, 255)
    Title.TextSize = 20
    Title.Parent = TopBar

    -- Close button
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -15, 0.5, 0)
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Image = "rbxassetid://3926305904"
    CloseButton.ImageColor3 = Color3.fromRGB(180, 190, 220)
    CloseButton.Parent = TopBar

    -- Content frame
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    ContentFrame.Parent = MainContainer

    -- Description
    local Description = Instance.new("TextLabel")
    Description.Name = "Description"
    Description.AnchorPoint = Vector2.new(0.5, 0)
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0.5, 0, 0, 20)
    Description.Size = UDim2.new(0.8, 0, 0, 50)
    Description.Font = Enum.Font.Gotham
    Description.Text = Settings.Description
    Description.TextColor3 = Color3.fromRGB(180, 200, 220)
    Description.TextSize = 14
    Description.TextWrapped = true
    Description.Parent = ContentFrame

    -- Key input
    local KeyInputContainer = Instance.new("Frame")
    KeyInputContainer.Name = "KeyInputContainer"
    KeyInputContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    KeyInputContainer.BackgroundTransparency = 1
    KeyInputContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    KeyInputContainer.Size = UDim2.new(0.8, 0, 0, 50)
    KeyInputContainer.Parent = ContentFrame

    local KeyInput = Instance.new("TextBox")
    KeyInput.Name = "KeyInput"
    KeyInput.AnchorPoint = Vector2.new(0.5, 0.5)
    KeyInput.BackgroundTransparency = 1
    KeyInput.Position = UDim2.new(0.5, 0, 0.5, 0)
    KeyInput.Size = UDim2.new(1, 0, 1, 0)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.TextColor3 = Color3.fromRGB(220, 230, 255)
    KeyInput.TextSize = 16
    KeyInput.Parent = KeyInputContainer

    local KeyPlaceholder = Instance.new("TextLabel")
    KeyPlaceholder.Name = "KeyPlaceholder"
    KeyPlaceholder.AnchorPoint = Vector2.new(0, 0.5)
    KeyPlaceholder.BackgroundTransparency = 1
    KeyPlaceholder.Position = UDim2.new(0, 0, 0.5, 0)
    KeyPlaceholder.Size = UDim2.new(1, 0, 1, 0)
    KeyPlaceholder.Font = Enum.Font.Gotham
    KeyPlaceholder.Text = "Enter your lunar key..."
    KeyPlaceholder.TextColor3 = Color3.fromRGB(120, 140, 180)
    KeyPlaceholder.TextSize = 16
    KeyPlaceholder.Parent = KeyInput

    local InputUnderline = Instance.new("Frame")
    InputUnderline.Name = "InputUnderline"
    InputUnderline.AnchorPoint = Vector2.new(0.5, 1)
    InputUnderline.BackgroundColor3 = Color3.fromRGB(100, 150, 220)
    InputUnderline.BorderSizePixel = 0
    InputUnderline.Position = UDim2.new(0.5, 0, 1, -5)
    InputUnderline.Size = UDim2.new(0, 0, 0, 2)
    InputUnderline.Parent = KeyInputContainer

    -- Buttons
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.AnchorPoint = Vector2.new(0.5, 1)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Position = UDim2.new(0.5, 0, 1, -20)
    ButtonContainer.Size = UDim2.new(0.8, 0, 0, 40)
    ButtonContainer.Parent = ContentFrame

    local GetKeyButton = Instance.new("TextButton")
    GetKeyButton.Name = "GetKeyButton"
    GetKeyButton.AnchorPoint = Vector2.new(0.5, 0.5)
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(40, 60, 90)
    GetKeyButton.BackgroundTransparency = 0.5
    GetKeyButton.Position = UDim2.new(0.3, 0, 0.5, 0)
    GetKeyButton.Size = UDim2.new(0.4, 0, 0.8, 0)
    GetKeyButton.Font = Enum.Font.GothamMedium
    GetKeyButton.Text = "GET KEY"
    GetKeyButton.TextColor3 = Color3.fromRGB(180, 210, 255)
    GetKeyButton.TextSize = 14
    GetKeyButton.Parent = ButtonContainer

    local DiscordButton = Instance.new("TextButton")
    DiscordButton.Name = "DiscordButton"
    DiscordButton.AnchorPoint = Vector2.new(0.5, 0.5)
    DiscordButton.BackgroundColor3 = Color3.fromRGB(60, 70, 120)
    DiscordButton.BackgroundTransparency = 0.5
    DiscordButton.Position = UDim2.new(0.7, 0, 0.5, 0)
    DiscordButton.Size = UDim2.new(0.4, 0, 0.8, 0)
    DiscordButton.Font = Enum.Font.GothamMedium
    DiscordButton.Text = "DISCORD"
    DiscordButton.TextColor3 = Color3.fromRGB(180, 210, 255)
    DiscordButton.TextSize = 14
    DiscordButton.Parent = ButtonContainer

    -- Button styling
    for _, button in pairs({GetKeyButton, DiscordButton}) do
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = button
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = button == GetKeyButton and Color3.fromRGB(100, 160, 220) or Color3.fromRGB(120, 140, 220)
        stroke.Transparency = 0.7
        stroke.Thickness = 1.5
        stroke.Parent = button
    end

    -- Make draggable
    MakeDraggable(TopBar, MainContainer)

    -- Close button
    CloseButton.MouseButton1Click:Connect(function()
        TS:Create(MainContainer, TweenInfo.new(0.3), {GroupTransparency = 1}):Play()
        task.wait(0.3)
        KeySystem:Destroy()
    end)

    -- Button hover effects
    local function setupButtonHover(button)
        button.MouseEnter:Connect(function()
            TS:Create(button, TweenInfo.new(0.2), {
                BackgroundTransparency = 0.3,
                TextColor3 = Color3.fromRGB(200, 230, 255)
            }):Play()
        end)
        button.MouseLeave:Connect(function()
            TS:Create(button, TweenInfo.new(0.2), {
                BackgroundTransparency = 0.5,
                TextColor3 = Color3.fromRGB(180, 210, 255)
            }):Play()
        end)
    end
    setupButtonHover(GetKeyButton)
    setupButtonHover(DiscordButton)

    -- Key input focus effects
    KeyInput.Focused:Connect(function()
        KeyPlaceholder.TextTransparency = 1
        TS:Create(InputUnderline, TweenInfo.new(0.3), {
            Size = UDim2.new(1, 0, 0, 2),
            BackgroundColor3 = Color3.fromRGB(150, 200, 255)
        }):Play()
    end)

    KeyInput.FocusLost:Connect(function()
        if KeyInput.Text == "" then
            KeyPlaceholder.TextTransparency = 0
        end
        TS:Create(InputUnderline, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 2),
            BackgroundColor3 = Color3.fromRGB(100, 150, 220)
        }):Play()
    end)

    -- Button functionality
    GetKeyButton.MouseButton1Click:Connect(function()
        if Settings.Link then
            KeyInput.Text = Settings.Link
            if setclipboard then setclipboard(Settings.Link) end
        end
    end)

    DiscordButton.MouseButton1Click:Connect(function()
        if Settings.Discord then
            KeyInput.Text = Settings.Discord
            if setclipboard then setclipboard(Settings.Discord) end
            if request then
                pcall(function()
                    local invite = Settings.Discord:gsub("https://discord.gg/", ""):gsub("https://discord.com/invite/", "")
                    request({
                        Url = "http://127.0.0.1:6463/rpc?v=1",
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json",
                            ["Origin"] = "https://discord.com"
                        },
                        Body = HS:JSONEncode({
                            cmd = "INVITE_BROWSER",
                            args = {code = invite},
                            nonce = HS:GenerateGUID(false)
                        })
                    })
                end)
            end
        end
    end)

    -- Initial animation
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    TS:Create(MainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 450, 0, 300)
    }):Play()

    -- Key verification
    local keyVerified = false
    KeyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local success, result = pcall(Settings.Verify, KeyInput.Text)
            if success and type(result) == "boolean" then
                keyVerified = result
                if Settings.Debug then
                    print(result and "✅ Valid key" or "❌ Invalid key")
                end
                if result and Settings.SaveKey and writefile then
                    writefile(Settings.Title:gsub(" ", ""):lower() .. ".key", KeyInput.Text)
                end
            end
        end
    end)

    -- Main loop
    repeat task.wait() until keyVerified or not KeySystem.Parent

    if keyVerified then
        TS:Create(MainContainer, TweenInfo.new(0.3), {
            GroupTransparency = 1
        }):Play()
        task.wait(0.3)
        KeySystem:Destroy()
    end

    return keyVerified
end

return Lib

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

    -- Updates position during drag
    local function Update(input)
        local Delta = input.Position - DragStart
        local DX, DY= Delta.X,Delta.Y
        local pos = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + DX,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + DY
        )
        TS:Create(object,TweenInfo.new(.2,Enum.EasingStyle.Back),{Position = pos}):Play()
    end

    -- Starts dragging on input
    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position

                input.Changed:Connect(
                    function()
                        Dragging = false
                    end)
            end
        end)

    -- Tracks drag movement
    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                input.UserInputType == Enum.UserInputType.Touch
            then
                DragInput = input
            end
        end
    )

    -- Updates position on input change
    UIS.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end

-- Prints credits. Please don't remove it
print("Credits to ShootLucky")

-- Library object definition
local Lib = {}

-- Library initialization function
function Lib:Init(Settings)
    local tic = tick()
    Settings=Settings or {}
    Settings.Debug=Settings.Debug or true

    -- Debug mode environment check
    if Settings.Debug==true then        
        if not _G["UNCks_checked"] then
            print("⏺️[UNC] Starting environment check for script")
            local fails,passes=0,0
            for _, func in pairs({"setclipboard","request","readfile","writefile","isfile"}) do
                local success = getGlobal(func)
                if success then
                    passes=passes+1
                    print("✅[UNC] Check of \"" .. func .. "\" was passed")
                else
                    fails=fails+1
                    warn("⛔[UNC] Check of \"" .. func .. "\" was failed ")
                end
            end
            _G["UNCks_checked"] = true
            local rate = math.round(passes / (passes + fails) * 100)
            print(("⏺️[UNC] Checked with a %s%% success rate (%s out of %s)"):format(rate,passes,(passes + fails)))
        end
        print("⏺️[Key System] Loading...")
    end

    -- Sets default settings
    for name, value in pairs({
        ["Debug"]= true,
        ["Verify"]= function(...)return true end,
        ["Title"]= "Lunar Key System",
        ["Link"]="https://lunar.vip",
        ["SaveKey"]=true,
        ["Logo"]="rbxassetid://8573754371", -- Moon glow texture
        }) do
        if Settings[name]==nil or typeof(Settings[name])~=typeof(value) then
            Settings[name]=value
            if Settings.Debug == true then
                warn(("⚠️[KeySystem] Setting \"%s\" is not %s."):format(name,typeof(value)))
            end
        end
    end
    Settings["Description"]=Settings["Decription"] or "Purchase at Lunar.vip to get your key"

    -- Key system variable
    local _5432Key543Entered7654 = false

    -- Creates main UI components
    local KeySystem = Instance.new("ScreenGui")
    local MainContainer = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainStroke = Instance.new("UIStroke")
    local MoonGlow = Instance.new("ImageLabel")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("ImageButton")
    local ContentFrame = Instance.new("Frame")
    local Description = Instance.new("TextLabel")
    local KeyInputContainer = Instance.new("Frame")
    local KeyInput = Instance.new("TextBox")
    local KeyPlaceholder = Instance.new("TextLabel")
    local InputUnderline = Instance.new("Frame")
    local ButtonContainer = Instance.new("Frame")
    local GetKeyButton = Instance.new("TextButton")
    local DiscordButton = Instance.new("TextButton")
    local ButtonCorner1 = Instance.new("UICorner")
    local ButtonCorner2 = Instance.new("UICorner")
    local ButtonStroke1 = Instance.new("UIStroke")
    local ButtonStroke2 = Instance.new("UIStroke")

    -- Configures ScreenGui properties
    KeySystem.Name = "LunarKeySystem"
    KeySystem.DisplayOrder = 999
    KeySystem.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    KeySystem.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Main container with lunar styling
    MainContainer.Name = "MainContainer"
    MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    MainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 30) -- Deep space blue
    MainContainer.BorderSizePixel = 0
    MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainContainer.Size = UDim2.new(0, 450, 0, 300)
    MainContainer.Parent = KeySystem

    -- Soft rounded corners
    MainCorner.CornerRadius = UDim.new(0, 14)
    MainCorner.Parent = MainContainer

    -- Glowing border effect
    MainStroke.Color = Color3.fromRGB(80, 120, 200) -- Moonlight blue
    MainStroke.Thickness = 2
    MainStroke.Transparency = 0.7
    MainStroke.Parent = MainContainer

    -- Moon glow background effect
    MoonGlow.Name = "MoonGlow"
    MoonGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    MoonGlow.BackgroundTransparency = 1
    MoonGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    MoonGlow.Size = UDim2.new(1, 100, 1, 100)
    MoonGlow.Image = Settings.Logo
    MoonGlow.ImageColor3 = Color3.fromRGB(30, 50, 100)
    MoonGlow.ImageTransparency = 0.85
    MoonGlow.ScaleType = Enum.ScaleType.Slice
    MoonGlow.SliceCenter = Rect.new(100, 100, 100, 100)
    MoonGlow.ZIndex = -1
    MoonGlow.Parent = MainContainer

    -- Top bar with title
    TopBar.Name = "TopBar"
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.Parent = MainContainer

    -- Elegant title text
    Title.Name = "Title"
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.5, 0, 0.5, 0)
    Title.Size = UDim2.new(0.8, 0, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = Settings.Title
    Title.TextColor3 = Color3.fromRGB(220, 230, 255) -- Moon glow white
    Title.TextSize = 20
    Title.TextTransparency = 0.1
    Title.Parent = TopBar

    -- Minimal close button
    CloseButton.Name = "CloseButton"
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -15, 0.5, 0)
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Image = "rbxassetid://3926305904" -- X icon
    CloseButton.ImageColor3 = Color3.fromRGB(180, 190, 220)
    CloseButton.ImageRectOffset = Vector2.new(284, 4)
    CloseButton.ImageRectSize = Vector2.new(24, 24)
    CloseButton.Parent = TopBar

    -- Content area
    ContentFrame.Name = "ContentFrame"
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    ContentFrame.Parent = MainContainer

    -- Description text
    Description.Name = "Description"
    Description.AnchorPoint = Vector2.new(0.5, 0)
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0.5, 0, 0, 20)
    Description.Size = UDim2.new(0.8, 0, 0, 50)
    Description.Font = Enum.Font.Gotham
    Description.Text = Settings.Description
    Description.TextColor3 = Color3.fromRGB(180, 200, 220)
    Description.TextSize = 14
    Description.TextTransparency = 0.2
    Description.TextWrapped = true
    Description.TextYAlignment = Enum.TextYAlignment.Top
    Description.Parent = ContentFrame

    -- Key input container
    KeyInputContainer.Name = "KeyInputContainer"
    KeyInputContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    KeyInputContainer.BackgroundTransparency = 1
    KeyInputContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    KeyInputContainer.Size = UDim2.new(0.8, 0, 0, 50)
    KeyInputContainer.Parent = ContentFrame

    -- Key input box
    KeyInput.Name = "KeyInput"
    KeyInput.AnchorPoint = Vector2.new(0.5, 0.5)
    KeyInput.BackgroundTransparency = 1
    KeyInput.Position = UDim2.new(0.5, 0, 0.5, 0)
    KeyInput.Size = UDim2.new(1, 0, 1, 0)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.PlaceholderColor3 = Color3.fromRGB(120, 140, 180)
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(220, 230, 255)
    KeyInput.TextSize = 16
    KeyInput.TextXAlignment = Enum.TextXAlignment.Left
    KeyInput.Parent = KeyInputContainer

    -- Floating placeholder text
    KeyPlaceholder.Name = "KeyPlaceholder"
    KeyPlaceholder.AnchorPoint = Vector2.new(0, 0.5)
    KeyPlaceholder.BackgroundTransparency = 1
    KeyPlaceholder.Position = UDim2.new(0, 0, 0.5, 0)
    KeyPlaceholder.Size = UDim2.new(1, 0, 1, 0)
    KeyPlaceholder.Font = Enum.Font.Gotham
    KeyPlaceholder.Text = "Enter your lunar key..."
    KeyPlaceholder.TextColor3 = Color3.fromRGB(120, 140, 180)
    KeyPlaceholder.TextSize = 16
    KeyPlaceholder.TextXAlignment = Enum.TextXAlignment.Left
    KeyPlaceholder.Parent = KeyInput

    -- Animated underline effect
    InputUnderline.Name = "InputUnderline"
    InputUnderline.AnchorPoint = Vector2.new(0.5, 1)
    InputUnderline.BackgroundColor3 = Color3.fromRGB(100, 150, 220)
    InputUnderline.BorderSizePixel = 0
    InputUnderline.Position = UDim2.new(0.5, 0, 1, -5)
    InputUnderline.Size = UDim2.new(0, 0, 0, 2)
    InputUnderline.Parent = KeyInputContainer

    -- Button container
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.AnchorPoint = Vector2.new(0.5, 1)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Position = UDim2.new(0.5, 0, 1, -20)
    ButtonContainer.Size = UDim2.new(0.8, 0, 0, 40)
    ButtonContainer.Parent = ContentFrame

    -- Get Key button
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

    -- Discord button
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
    ButtonCorner1.CornerRadius = UDim.new(0, 8)
    ButtonCorner1.Parent = GetKeyButton
    
    ButtonCorner2.CornerRadius = UDim.new(0, 8)
    ButtonCorner2.Parent = DiscordButton
    
    ButtonStroke1.Color = Color3.fromRGB(100, 160, 220)
    ButtonStroke1.Transparency = 0.7
    ButtonStroke1.Thickness = 1.5
    ButtonStroke1.Parent = GetKeyButton
    
    ButtonStroke2.Color = Color3.fromRGB(120, 140, 220)
    ButtonStroke2.Transparency = 0.7
    ButtonStroke2.Thickness = 1.5
    ButtonStroke2.Parent = DiscordButton

    -- Make the window draggable
    MakeDraggable(TopBar, MainContainer)

    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        TS:Create(MainContainer, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        wait(0.3)
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

    -- Text box focus effects
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
        
        -- Key verification
        local CurrentKeyInput = KeyInput.Text
        if string.gsub(CurrentKeyInput," ","") ~= "" and typeof(Settings.Verify)== "function" then
            local a = Settings.Verify(CurrentKeyInput)
            if typeof(a)=="boolean" then
                _5432Key543Entered7654= a
                if Settings.Debug == true then
                    if a then
                        print("✅[Key System] Key is valid"..(" (%s)"):format(CurrentKeyInput))
                    else
                        print("⛔[Key System] Key is invalid"..(" (%s)"):format(CurrentKeyInput))
                    end
                end
            end
        end
    end)

    -- Button functionality
    GetKeyButton.MouseButton1Click:Connect(function()
        if Settings.Link then
            KeyInput.Text = Settings.Link
            if setclipboard then
                setclipboard(Settings.Link)
            end
        end
    end)

    DiscordButton.MouseButton1Click:Connect(function()
        if Settings.Discord then
            KeyInput.Text = Settings.Discord
            if setclipboard then
                setclipboard(Settings.Discord)
            end
            -- Attempt to join Discord through app
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

    -- Load saved key if available
    if Settings.SaveKey and readfile and isfile and isfile(Settings["Title"]:gsub(" ",""):lower() .. ".key") then
        local CurrentKeyInput = readfile(Settings["Title"]:gsub(" ",""):lower() .. ".key") 
        _5432Key543Entered7654= pcall(Settings.Verify,CurrentKeyInput)
        if Settings.Debug == true then
            if _5432Key543Entered7654 then
                print("✅[Key System] Saved key is valid"..(" (%s)"):format(CurrentKeyInput))
            else
                print("⛔[Key System] Saved key is invalid"..(" (%s)"):format(CurrentKeyInput))
            end
        end
    end

    -- Handles key validation and UI lifecycle
    if _5432Key543Entered7654 then
        return true
    else
        repeat wait() until _5432Key543Entered7654 == true or not KeySystem.Parent
        
        if Settings.SaveKey and _5432Key543Entered7654 and writefile then
            writefile(Settings["Title"]:gsub(" ",""):lower() .. ".key", KeyInput.Text) 
        end
        
        TS:Create(MainContainer, TweenInfo.new(0.3), {
            GroupTransparency=1
        }):Play()
        wait(0.3)
        KeySystem:Destroy()
        
        return _5432Key543Entered7654
    end
end

-- Sets library to global environment
getgenv().Lib=Lib
return Lib

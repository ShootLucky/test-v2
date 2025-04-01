-- Creates main UI components
local KeySystem = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("ImageButton")
local ContentFrame = Instance.new("Frame")
local KeyInputFrame = Instance.new("Frame")
local KeyInputBox = Instance.new("TextBox")
local KeyInputPlaceholder = Instance.new("TextLabel")
local Underline = Instance.new("Frame")
local ButtonFrame = Instance.new("Frame")
local GetKeyButton = Instance.new("TextButton")
local DiscordButton = Instance.new("TextButton")
local MoonGlow = Instance.new("ImageLabel")

-- Configures ScreenGui properties
KeySystem.Name = "LunarKeySystem"
KeySystem.DisplayOrder = 999
KeySystem.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeySystem.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main frame with elegant lunar styling
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35) -- Deep space blue
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Parent = KeySystem

-- Soft rounded corners
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Top bar with title and close button
TopBar.Name = "TopBar"
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50) -- Slightly lighter than main
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.Parent = MainFrame

-- Elegant title text
Title.Name = "Title"
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.5, 0, 0.5, 0)
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = Settings.Title or "LUNAR KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(220, 230, 255) -- Moon glow white
Title.TextSize = 18
Title.TextTransparency = 0.1
Title.Parent = TopBar

-- Minimal close button
CloseButton.Name = "CloseButton"
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -10, 0.5, 0)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Image = "rbxassetid://3926305904" -- Simple X icon
CloseButton.ImageColor3 = Color3.fromRGB(180, 190, 220)
CloseButton.ImageRectOffset = Vector2.new(284, 4)
CloseButton.ImageRectSize = Vector2.new(24, 24)
CloseButton.Parent = TopBar

-- Content area
ContentFrame.Name = "ContentFrame"
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Parent = MainFrame

-- Key input area with modern styling
KeyInputFrame.Name = "KeyInputFrame"
KeyInputFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeyInputFrame.BackgroundTransparency = 1
KeyInputFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
KeyInputFrame.Size = UDim2.new(0.8, 0, 0, 50)
KeyInputFrame.Parent = ContentFrame

-- Key input box with clean design
KeyInputBox.Name = "KeyInputBox"
KeyInputBox.AnchorPoint = Vector2.new(0.5, 0.5)
KeyInputBox.BackgroundTransparency = 1
KeyInputBox.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyInputBox.Size = UDim2.new(1, 0, 1, 0)
KeyInputBox.Font = Enum.Font.Gotham
KeyInputBox.PlaceholderColor3 = Color3.fromRGB(150, 160, 180)
KeyInputBox.Text = ""
KeyInputBox.TextColor3 = Color3.fromRGB(220, 230, 255)
KeyInputBox.TextSize = 16
KeyInputBox.TextXAlignment = Enum.TextXAlignment.Left
KeyInputBox.Parent = KeyInputFrame

-- Floating placeholder text
KeyInputPlaceholder.Name = "KeyInputPlaceholder"
KeyInputPlaceholder.AnchorPoint = Vector2.new(0, 0.5)
KeyInputPlaceholder.BackgroundTransparency = 1
KeyInputPlaceholder.Position = UDim2.new(0, 0, 0.5, 0)
KeyInputPlaceholder.Size = UDim2.new(1, 0, 1, 0)
KeyInputPlaceholder.Font = Enum.Font.Gotham
KeyInputPlaceholder.Text = "Enter your key"
KeyInputPlaceholder.TextColor3 = Color3.fromRGB(150, 160, 180)
KeyInputPlaceholder.TextSize = 16
KeyInputPlaceholder.TextXAlignment = Enum.TextXAlignment.Left
KeyInputPlaceholder.Parent = KeyInputBox

-- Animated underline effect
Underline.Name = "Underline"
Underline.AnchorPoint = Vector2.new(0.5, 1)
Underline.BackgroundColor3 = Color3.fromRGB(100, 150, 255) -- Soft blue
Underline.BorderSizePixel = 0
Underline.Position = UDim2.new(0.5, 0, 1, -5)
Underline.Size = UDim2.new(0, 0, 0, 2)
Underline.Parent = KeyInputFrame

-- Button container
ButtonFrame.Name = "ButtonFrame"
ButtonFrame.AnchorPoint = Vector2.new(0.5, 1)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Position = UDim2.new(0.5, 0, 1, -20)
ButtonFrame.Size = UDim2.new(0.8, 0, 0, 40)
ButtonFrame.Parent = ContentFrame

-- Get Key button with modern styling
GetKeyButton.Name = "GetKeyButton"
GetKeyButton.AnchorPoint = Vector2.new(0.5, 0.5)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
GetKeyButton.BackgroundTransparency = 0.5
GetKeyButton.Position = UDim2.new(0.3, 0, 0.5, 0)
GetKeyButton.Size = UDim2.new(0.4, 0, 0.8, 0)
GetKeyButton.Font = Enum.Font.GothamMedium
GetKeyButton.Text = "GET KEY"
GetKeyButton.TextColor3 = Color3.fromRGB(180, 200, 255)
GetKeyButton.TextSize = 14
GetKeyButton.Parent = ButtonFrame

-- Discord button with matching style
DiscordButton.Name = "DiscordButton"
DiscordButton.AnchorPoint = Vector2.new(0.5, 0.5)
DiscordButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DiscordButton.BackgroundTransparency = 0.5
DiscordButton.Position = UDim2.new(0.7, 0, 0.5, 0)
DiscordButton.Size = UDim2.new(0.4, 0, 0.8, 0)
DiscordButton.Font = Enum.Font.GothamMedium
DiscordButton.Text = "DISCORD"
DiscordButton.TextColor3 = Color3.fromRGB(180, 200, 255)
DiscordButton.TextSize = 14
DiscordButton.Parent = ButtonFrame

-- Subtle moon glow effect in background
MoonGlow.Name = "MoonGlow"
MoonGlow.AnchorPoint = Vector2.new(0.5, 0.5)
MoonGlow.BackgroundTransparency = 1
MoonGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
MoonGlow.Size = UDim2.new(1, 100, 1, 100)
MoonGlow.Image = "rbxassetid://8573754371" -- Soft glow texture
MoonGlow.ImageColor3 = Color3.fromRGB(30, 50, 100)
MoonGlow.ImageTransparency = 0.9
MoonGlow.ScaleType = Enum.ScaleType.Slice
MoonGlow.SliceCenter = Rect.new(100, 100, 100, 100)
MoonGlow.ZIndex = -1
MoonGlow.Parent = MainFrame

-- Add corner rounding to buttons
for _, button in pairs({GetKeyButton, DiscordButton}) do
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(100, 150, 200)
    buttonStroke.Transparency = 0.7
    buttonStroke.Thickness = 1
    buttonStroke.Parent = button
end

-- Add hover effects to buttons
for _, button in pairs({GetKeyButton, DiscordButton}) do
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.3,
            TextColor3 = Color3.fromRGB(200, 220, 255)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.5,
            TextColor3 = Color3.fromRGB(180, 200, 255)
        }):Play()
    end)
end

-- Text box focus effects
KeyInputBox.Focused:Connect(function()
    KeyInputPlaceholder.TextTransparency = 1
    game:GetService("TweenService"):Create(Underline, TweenInfo.new(0.3), {
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = Color3.fromRGB(150, 200, 255)
    }):Play()
end)

KeyInputBox.FocusLost:Connect(function()
    if KeyInputBox.Text == "" then
        KeyInputPlaceholder.TextTransparency = 0
    end
    game:GetService("TweenService"):Create(Underline, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 2),
        BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    }):Play()
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    wait(0.3)
    KeySystem:Destroy()
end)

-- Make the window draggable
local UserInputService = game:GetService("UserInputService")
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Button functionality
GetKeyButton.MouseButton1Click:Connect(function()
    if Settings.Link then
        KeyInputBox.Text = Settings.Link
        if setclipboard then
            setclipboard(Settings.Link)
        end
    end
end)

DiscordButton.MouseButton1Click:Connect(function()
    if Settings.Discord then
        KeyInputBox.Text = Settings.Discord
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
                    Body = game:GetService("HttpService"):JSONEncode({
                        cmd = "INVITE_BROWSER",
                        args = {code = invite},
                        nonce = game:GetService("HttpService"):GenerateGUID(false)
                    })
                })
            end)
        end
    end
end)

-- Initial animation
MainFrame.Size = UDim2.new(0, 0, 0, 0)
game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 400, 0, 250)
}):Play()

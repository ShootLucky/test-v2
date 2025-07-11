-- [[ // Error Handling // ]]
local Passed, Statement = pcall(function()
	-- [[ // Libraries // ]]
	local library = {
		Renders = {},
		Connections = {},
		Folder = "PuppyWare", -- Change if wanted
		Assets = "Assets", -- Change if wanted
		Configs = "Configs" -- Change if wanted
	}
	local utility = {}
	-- [[ // Tables // ]]
	local pages = {}
	local sections = {}
	-- [[ // Indexes // ]]
	do
		library.__index = library
		pages.__index = pages
		sections.__index = sections
	end

	
	-- [[ // Variables // ]] 
	local tws = game:GetService("TweenService")
	local uis = game:GetService("UserInputService")
	local cre = game:GetService("CoreGui")
	-- [[ // Functions // ]]
	function utility:RenderObject(RenderType, RenderProperties, RenderHidden)
		local Render = Instance.new(RenderType)
		--
		if RenderProperties and typeof(RenderProperties) == "table" then
			for Property, Value in pairs(RenderProperties) do
				if Property ~= "RenderTime" then
					Render[Property] = Value
				end
			end
		end
		--
		library.Renders[#library.Renders + 1] = {Render, RenderProperties, RenderHidden, RenderProperties["RenderTime"] or nil}
		--
		return Render
	end
	--
	function utility:CreateConnection(ConnectionType, ConnectionCallback)
		local Connection = ConnectionType:Connect(ConnectionCallback)
		--
		library.Connections[#library.Connections + 1] = Connection
		--
		return Connection
	end
	--
	function utility:MouseLocation()
		return uis:GetMouseLocation()
	end
	--
	function utility:Serialise(Table)
		local Serialised = ""
		--
		for Index, Value in pairs(Table) do
			Serialised = Serialised .. Value .. ", "
		end
		--
		return Serialised:sub(0, #Serialised - 2)
	end
	--
	function utility:Sort(Table1, Table2)
		local Table3 = {}
		--
		for Index, Value in pairs(Table2) do
			if table.find(Table1, Index) then
				Table3[#Table3 + 1] = Value
			end
		end
		--
		return Table3
	end
	-- [[ // UI Functions // ]]
function library:CreateWindow(Properties)
    Properties = Properties or {}
    --
    local Window = {
        Pages = {},
        Accent = Color3.fromRGB(255, 120, 30),
        Enabled = true,
        Key = Enum.KeyCode.Z
    }
    --
    do
        local ScreenGui = utility:RenderObject("ScreenGui", {
            DisplayOrder = 9999,
            Enabled = true,
            IgnoreGuiInset = true,
            Parent = cre,
            ResetOnSpawn = false,
            ZIndexBehavior = "Global"
        })
        -- Adicionar o watermark com maior visibilidade
        local TweenService = game:GetService("TweenService")

        -- Criar o contêiner do watermark
        local Watermark = utility:RenderObject("Frame", {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Parent = ScreenGui, -- Anexado ao ScreenGui para ficar na tela
            Position = UDim2.new(1, -10, 0, 10),
            Size = UDim2.new(0, 100, 0, 20),
            ZIndex = 5,
            AnchorPoint = Vector2.new(1, 0)
        })

        -- Texto do watermark
        local Text = "Skeet.cc"
        local Letters = {}

        -- Criar um TextLabel para cada letra
        for i = 1, #Text do
            local char = Text:sub(i, i)
            local Letter = utility:RenderObject("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                BackgroundTransparency = 1,
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                BorderSizePixel = 0,
                Parent = Watermark,
                Position = UDim2.new(0, (i - 1) * 10, 0, 0), -- Aumentei o espaçamento entre letras
                Size = UDim2.new(0, 10, 1, 0), -- Aumentei a largura por letra
                ZIndex = 5,
                Font = "Code",
                Text = char,
                TextColor3 = Color3.fromRGB(255, 255, 255), -- Branco puro
                TextSize = 10, -- Aumentei o tamanho do texto
                TextTransparency = 0, -- Reduzi a transparência inicial para 0 (totalmente visível)
                TextXAlignment = "Left",
                AnchorPoint = Vector2.new(0, 0)
            })
            Letters[i] = Letter
        end

        -- Ajustar o tamanho do contêiner com base no número de letras
        local TotalWidth = #Letters * 10 -- Cada letra tem largura 10
        Watermark.Size = UDim2.new(0, TotalWidth, 0, 20) -- Ajustar o tamanho do Frame

        -- Efeito de onda letra por letra, da esquerda para a direita
        local function CreateWaveEffect()
            for i, Letter in ipairs(Letters) do
                -- Animação de transparência e cor
                local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, (i - 1) * 0.15)
                local tweenTransparency = TweenService:Create(Letter, tweenInfo, {TextTransparency = 0.3}) -- Reduzi o ofuscamento máximo
                local tweenColor = TweenService:Create(Letter, tweenInfo, {TextColor3 = Color3.fromRGB(0, 255, 0)}) -- Azul mais claro e vibrante
                tweenTransparency:Play()
                tweenColor:Play()
            end
        end

        -- Iniciar o efeito de onda
        CreateWaveEffect()
        -- //
        local ScreenGui_MainFrame = utility:RenderObject("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
            BackgroundTransparency = 0,
            BorderColor3 = Color3.fromRGB(12, 12, 12),
            BorderMode = "Inset",
            BorderSizePixel = 1,
            Parent = ScreenGui,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 660, 0, 560)
        })
        -- //
        local ScreenGui_MainFrame_InnerBorder = utility:RenderObject("Frame", {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            BackgroundTransparency = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Parent = ScreenGui_MainFrame,
            Position = UDim2.new(0, 1, 0, 1),
            Size = UDim2.new(1, -2, 1, -2)
        })
        -- //
        local MainFrame_InnerBorder_InnerFrame = utility:RenderObject("Frame", {
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BackgroundTransparency = 0,
            BorderColor3 = Color3.fromRGB(60, 60, 60),
            BorderMode = "Inset",
            BorderSizePixel = 1,
            Parent = ScreenGui_MainFrame,
            Position = UDim2.new(0, 3, 0, 3),
            Size = UDim2.new(1, -6, 1, -6)
        })
        -- //
        local InnerBorder_InnerFrame_Tabs = utility:RenderObject("Frame", {
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BackgroundTransparency = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Parent = MainFrame_InnerBorder_InnerFrame,
            Position = UDim2.new(0, 0, 0, 4),
            Size = UDim2.new(0, 74, 1, -4)
        })
        --
        local InnerBorder_InnerFrame_Pages = utility:RenderObject("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Parent = MainFrame_InnerBorder_InnerFrame,
            Position = UDim2.new(1, 0, 0, 4),
            Size = UDim2.new(1, -73, 1, -4)
        })
        --
        local InnerBorder_InnerFrame_TopGradient = utility:RenderObject("Frame", {
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BackgroundTransparency = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Parent = MainFrame_InnerBorder_InnerFrame,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 0, 4)
        })
        -- Adicionar o botão de arrastar
        local DragButton = utility:RenderObject("TextButton", {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Parent = InnerBorder_InnerFrame_TopGradient,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            Text = "",
            ZIndex = 10
        })
        -- //
        local InnerFrame_Tabs_List = utility:RenderObject("UIListLayout", {
            Padding = UDim.new(0, 4),
            Parent = InnerBorder_InnerFrame_Tabs,
            FillDirection = "Vertical",
            HorizontalAlignment = "Left",
            VerticalAlignment = "Top"
        })
        --
        local InnerFrame_Tabs_Padding = utility:RenderObject("UIPadding", {
            Parent = InnerBorder_InnerFrame_Tabs,
            PaddingTop = UDim.new(0, 9)
        })
        --
        local InnerFrame_Pages_InnerBorder = utility:RenderObject("Frame", {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45),
            BackgroundTransparency = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Parent = InnerBorder_InnerFrame_Pages,
            Position = UDim2.new(0, 1, 0, 0),
            Size = UDim2.new(1, -1, 1, 0)
        })
        --
        local InnerBorder_InnerFrame_TopGradient_Gradient = utility:RenderObject("ImageLabel", {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Parent = InnerBorder_InnerFrame_TopGradient,
            Position = UDim2.new(0, 1, 0, 1),
            Size = UDim2.new(1, -2, 1, -2),
            Image = "rbxassetid://8508019876",
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        })
        -- //
        local Pages_InnerBorder_InnerFrame = utility:RenderObject("Frame", {
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            BackgroundTransparency = 0,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Parent = InnerFrame_Pages_InnerBorder,
            Position = UDim2.new(0, 1, 0, 0),
            Size = UDim2.new(1, -1, 1, 0)
        })
        -- //
        local InnerBorder_InnerFrame_Folder = utility:RenderObject("Folder", {
            Parent = Pages_InnerBorder_InnerFrame
        })
        --
        local InnerBorder_InnerFrame_Pattern = utility:RenderObject("ImageLabel", {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Parent = Pages_InnerBorder_InnerFrame,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            Image = "rbxassetid://8547666218",
            ImageColor3 = Color3.fromRGB(12, 12, 12),
            ScaleType = "Tile",
            TileSize = UDim2.new(0, 8, 0, 8)
        })
        --
        do -- // Functions
            function Window:SetPage(Page)
                for index, page in pairs(Window.Pages) do
                    if page.Open and page ~= Page then
                        page:Set(false)
                    end
                end
            end
            --
            function Window:Fade(state)
                for index, render in pairs(library.Renders) do
                    if not render[3] then
                        if render[1].ClassName == "Frame" and (render[2]["BackgroundTransparency"] or 0) ~= 1 then
                            tws:Create(render[1], TweenInfo.new(render[4] or 0.25, Enum.EasingStyle["Linear"], state and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {BackgroundTransparency = state and (render[2]["BackgroundTransparency"] or 0) or 1}):Play()
                        elseif render[1].ClassName == "ImageLabel" then
                            if (render[2]["BackgroundTransparency"] or 0) ~= 1 then
                                tws:Create(render[1], TweenInfo.new(render[4] or 0.25, Enum.EasingStyle["Linear"], state and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {BackgroundTransparency = state and (render[2]["BackgroundTransparency"] or 0) or 1}):Play()
                            end
                            --
                            if (render[2]["ImageTransparency"] or 0) ~= 1 then
                                tws:Create(render[1], TweenInfo.new(render[4] or 0.25, Enum.EasingStyle["Linear"], state and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {ImageTransparency = state and (render[2]["ImageTransparency"] or 0) or 1}):Play()
                            end
                        elseif render[1].ClassName == "TextLabel" then
                            if (render[2]["BackgroundTransparency"] or 0) ~= 1 then
                                tws:Create(render[1], TweenInfo.new(render[4] or 0.25, Enum.EasingStyle["Linear"], state and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {BackgroundTransparency = state and (render[2]["BackgroundTransparency"] or 0) or 1}):Play()
                            end
                            --
                            if (render[2]["TextTransparency"] or 0) ~= 1 then
                                tws:Create(render[1], TweenInfo.new(render[4] or 0.25, Enum.EasingStyle["Linear"], state and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {TextTransparency = state and (render[2]["TextTransparency"] or 0) or 1}):Play()
                            end
                        elseif render[1].ClassName == "ScrollingFrame" then
                            if (render[2]["BackgroundTransparency"] or 0) ~= 1 then
                                tws:Create(render[1], TweenInfo.new(render[4] or 0.25, Enum.EasingStyle["Linear"], state and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {BackgroundTransparency = state and (render[2]["BackgroundTransparency"] or 0) or 1}):Play()
                            end
                            --
                            if (render[2]["ScrollBarImageTransparency"] or 0) ~= 1 then
                                tws:Create(render[1], TweenInfo.new(render[4] or 0.25, Enum.EasingStyle["Linear"], state and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {ScrollBarImageTransparency = state and (render[2]["ScrollBarImageTransparency"] or 0) or 1}):Play()
                            end
                        end
                    end
                end
            end
            --
            function Window:Unload()
                ScreenGui:Remove()
                --
                for index, connection in pairs(library.Connections) do
                    connection:Disconnect()
                end
                --
                library = nil
                utility = nil
            end
        end
        --
        do -- // Index Setting
            Window["TabsHolder"] = InnerBorder_InnerFrame_Tabs
            Window["PagesHolder"] = InnerBorder_InnerFrame_Folder
            Window["MainFrame"] = ScreenGui_MainFrame
        end
        --
        do -- // Connections
            utility:CreateConnection(uis.InputBegan, function(Input)
                if Input.KeyCode and Input.KeyCode == Window.Key then
                    Window.Enabled = not Window.Enabled
                    --
                    Window:Fade(Window.Enabled)
                elseif Input.KeyCode and Input.KeyCode == Enum.KeyCode.X then
                    Window:Unload()
                end
            end)
            -- Lógica de arrastar
            local Dragging = false
            local DragStartPos = nil
            local StartFramePos = nil
            utility:CreateConnection(DragButton.MouseButton1Down, function()
                Dragging = true
                DragStartPos = utility:MouseLocation()
                StartFramePos = Window.MainFrame.Position
            end)
            utility:CreateConnection(uis.InputChanged, function(Input)
                if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
                    local MousePos = utility:MouseLocation()
                    local Delta = MousePos - DragStartPos
                    Window.MainFrame.Position = UDim2.new(
                        StartFramePos.X.Scale,
                        StartFramePos.X.Offset + Delta.X,
                        StartFramePos.Y.Scale,
                        StartFramePos.Y.Offset + Delta.Y
                    )
                end
            end)
            utility:CreateConnection(uis.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false
                    DragStartPos = nil
                    StartFramePos = nil
                end
            end)
        end
    end
    --
    return setmetatable(Window, library)
end
	--
	function library:CreatePage(Properties)
		Properties = Properties or {}
		--
		local Page = {
			Image = (Properties.image or Properties.Image or Properties.icon or Properties.Icon),
			Size = (Properties.size or Properties.Size or UDim2.new(0, 50, 0, 50)),
			Open = false,
			Window = self
		}
		--
		do
			local Page_Tab = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Page.Window["TabsHolder"],
				Size = UDim2.new(1, 0, 0, 72)
			})
			-- //
			local Page_Tab_Border = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 0,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Page_Tab,
				Size = UDim2.new(1, 0, 1, 0),
				Visible = false,
				ZIndex = 2,
				RenderTime = 0.15
			})
			--
			local Page_Tab_Image = utility:RenderObject("ImageLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Page_Tab,
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = Page.Size,
				ZIndex = 2,
				Image = Page.Image,
				ImageColor3 = Color3.fromRGB(100, 100, 100)
			})
			--
			local Page_Tab_Button = utility:RenderObject("TextButton", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Page_Tab,
				Size = UDim2.new(1, 0, 1, 0),
				Text = ""
			})
			-- //
			local Tab_Border_Inner = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(40, 40, 40),
				BackgroundTransparency = 0,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Page_Tab_Border,
				Position = UDim2.new(0, 0, 0, 1),
				Size = UDim2.new(1, 1, 1, -2),
				ZIndex = 2,
				RenderTime = 0.15
			})
			-- //
			local Border_Inner_Inner = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				BackgroundTransparency = 0,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Tab_Border_Inner,
				Position = UDim2.new(0, 0, 0, 1),
				Size = UDim2.new(1, 0, 1, -2),
				ZIndex = 2,
				RenderTime = 0.15
			})
			--
			local Inner_Inner_Pattern = utility:RenderObject("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Border_Inner_Inner,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(1, 0, 1, 0),
				Image = "rbxassetid://8509210785",
				ImageColor3 = Color3.fromRGB(12, 12, 12),
				ScaleType = "Tile",
				TileSize = UDim2.new(0, 8, 0, 8),
				ZIndex = 2
			})
			-- //
			local Page_Page = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Page.Window["PagesHolder"],
				Position = UDim2.new(0, 20, 0, 20),
				Size = UDim2.new(1, -40, 1, -40),
				Visible = false
			})
			-- //
			local Page_Page_Left = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Page_Page,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(0.5, -10, 1, 0)
			})
			--
			local Page_Page_Right = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Page_Page,
				Position = UDim2.new(0.5, 10, 0, 0),
				Size = UDim2.new(0.5, -10, 1, 0)
			})
			-- //
			local Page_Left_List = utility:RenderObject("UIListLayout", {
				Padding = UDim.new(0, 18),
				Parent = Page_Page_Left,
				FillDirection = "Vertical",
				HorizontalAlignment = "Left",
				VerticalAlignment = "Top"
			})
			--
			local Page_Right_List = utility:RenderObject("UIListLayout", {
				Padding = UDim.new(0, 18),
				Parent = Page_Page_Right,
				FillDirection = "Vertical",
				HorizontalAlignment = "Left",
				VerticalAlignment = "Top"
			})
			--
			do -- // Index Setting
				Page["Page"] = Page_Page
				Page["Left"] = Page_Page_Left
				Page["Right"] = Page_Page_Right
			end
			--
			do -- // Functions
				function Page:Set(state)
					Page.Open = state
					--
					Page_Page.Visible = Page.Open
					Page_Tab_Border.Visible = Page.Open
					Page_Tab_Image.ImageColor3 = Page.Open and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(90, 90, 90)
					--
					if Page.Open then
						Page.Window:SetPage(Page)
					end
				end
			end
			--
			do -- // Connections
				utility:CreateConnection(Page_Tab_Button.MouseButton1Click, function(Input)
					if not Page.Open then
						Page:Set(true)
					end
				end)
				--
				utility:CreateConnection(Page_Tab_Button.MouseEnter, function(Input)
					Page_Tab_Image.ImageColor3 = Color3.fromRGB(172, 172, 172)
				end)
				--
				utility:CreateConnection(Page_Tab_Button.MouseLeave, function(Input)
					Page_Tab_Image.ImageColor3 = Page.Open and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(90, 90, 90)
				end)
			end
		end
		--
		if #Page.Window.Pages == 0 then Page:Set(true) end
		Page.Window.Pages[#Page.Window.Pages + 1] = Page
		return setmetatable(Page, pages)
	end
	--
	function pages:CreateSection(Properties)
		Properties = Properties or {}
		--
		local Section = {
			Name = (Properties.name or Properties.Name or Properties.title or Properties.Title or "New Section"),
			Size = (Properties.size or Properties.Size or 150),
			Side = (Properties.side or Properties.Side or "Left"),
			Content = {},
			Window = self.Window,
			Page = self
		}
		--
		do
			local Section_Holder = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(40, 40, 40),
				BackgroundTransparency = 0,
				BorderColor3 = Color3.fromRGB(12, 12, 12),
				BorderMode = "Inset",
				BorderSizePixel = 1,
				Parent = Section.Page[Section.Side],
				Size = UDim2.new(1, 0, 0, Section.Size),
				ZIndex = 2
			})
			-- //
			local Section_Holder_Extra = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder,
				Position = UDim2.new(0, 1, 0, 1),
				Size = UDim2.new(1, -2, 1, -2),
				ZIndex = 2
			})
			--
			local Section_Holder_Frame = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(23, 23, 23),
				BackgroundTransparency = 0,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder,
				Position = UDim2.new(0, 1, 0, 1),
				Size = UDim2.new(1, -2, 1, -2),
				ZIndex = 2
			})
			--
			local Section_Holder_TitleInline = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(23, 23, 23),
				BackgroundTransparency = 0,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder,
				Position = UDim2.new(0, 9, 0, -1),
				Size = UDim2.new(0, 0, 0, 2),
				ZIndex = 5
			})
			--
			local Section_Holder_Title = utility:RenderObject("TextLabel", {
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder,
				Position = UDim2.new(0, 12, 0, 0),
				Size = UDim2.new(1, -26, 0, 15),
				ZIndex = 5,
				Font = "Code",
				RichText = true,
				Text = "<b>" .. Section.Name .. "</b>",
				TextColor3 = Color3.fromRGB(205, 205, 205),
				TextSize = 11,
				TextStrokeTransparency = 1,
				TextXAlignment = "Left"
			})
			-- //
			local Holder_Extra_Gradient1 = utility:RenderObject("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder_Extra,
				Position = UDim2.new(0, 1, 0, 1),
				Rotation = 180,
				Size = UDim2.new(1, -2, 0, 20),
				Visible = false,
				ZIndex = 4,
				Image = "rbxassetid://7783533907",
				ImageColor3 = Color3.fromRGB(23, 23, 23)
			})
			--
			local Holder_Extra_Gradient2 = utility:RenderObject("ImageLabel", {
				AnchorPoint = Vector2.new(0, 1),
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder_Extra,
				Position = UDim2.new(0, 0, 1, 0),
				Size = UDim2.new(1, -2, 0, 20),
				Visible = false,
				ZIndex = 4,
				Image = "rbxassetid://7783533907",
				ImageColor3 = Color3.fromRGB(23, 23, 23)
			})
			--
			local Holder_Extra_ArrowUp = utility:RenderObject("TextButton", {
				BackgroundColor3 = Color3.fromRGB(255, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder_Extra,
				Position = UDim2.new(1, -21, 0, 0),
				Size = UDim2.new(0, 7 + 8, 0, 6 + 8),
				Text = "",
                Visible = false,
				ZIndex = 4
			})
			--
			local Holder_Extra_ArrowDown = utility:RenderObject("TextButton", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder_Extra,
				Position = UDim2.new(1, -21, 1, -(6 + 8)),
				Size = UDim2.new(0, 7 + 8, 0, 6 + 8),
				Text = "",
                Visible = false,
				ZIndex = 4
			})
			-- //
			local Extra_ArrowUp_Image = utility:RenderObject("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Holder_Extra_ArrowUp,
				Position = UDim2.new(0, 4, 0, 4),
				Size = UDim2.new(0, 7, 0, 6),
				Visible = true,
				ZIndex = 4,
				Image = "rbxassetid://8548757311",
				ImageColor3 = Color3.fromRGB(205, 205, 205)
			})
			--
			local Extra_ArrowDown_Image = utility:RenderObject("ImageLabel", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Holder_Extra_ArrowDown,
				Position = UDim2.new(0, 4, 0, 4),
				Size = UDim2.new(0, 7, 0, 6),
				Visible = true,
				ZIndex = 4,
				Image = "rbxassetid://8548723563",
				ImageColor3 = Color3.fromRGB(205, 205, 205)
			})
			--
			local Holder_Extra_Bar = utility:RenderObject("Frame", {
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.fromRGB(45, 45, 45),
				BackgroundTransparency = 0,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder_Extra,
				Position = UDim2.new(1, 0, 0, 0),
				Size = UDim2.new(0, 6, 1, 0),
				Visible = false,
				ZIndex = 4
			})
			--
			local Holder_Extra_Line = utility:RenderObject("Frame", {
				BackgroundColor3 = Color3.fromRGB(45, 45, 45),
				BackgroundTransparency = 0,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder_Extra,
				Position = UDim2.new(0, 0, 0, -1),
				Size = UDim2.new(1, 0, 0, 1),
				ZIndex = 4
			})
			--
			local Holder_Frame_ContentHolder = utility:RenderObject("ScrollingFrame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Parent = Section_Holder_Frame,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 4,
				AutomaticCanvasSize = "Y",
				BottomImage = "rbxassetid://7783554086",
				CanvasSize = UDim2.new(0, 0, 0, 0),
				MidImage = "rbxassetid://7783554086",
				ScrollBarImageColor3 = Color3.fromRGB(65, 65, 65),
				ScrollBarImageTransparency = 0,
				ScrollBarThickness = 5,
				TopImage = "rbxassetid://7783554086",
				VerticalScrollBarInset = "None"
			})
			-- //
			local Frame_ContentHolder_List = utility:RenderObject("UIListLayout", {
				Padding = UDim.new(0, 0),
				Parent = Holder_Frame_ContentHolder,
				FillDirection = "Vertical",
				HorizontalAlignment = "Center",
				VerticalAlignment = "Top"
			})
			--
			local Frame_ContentHolder_Padding = utility:RenderObject("UIPadding", {
				Parent = Holder_Frame_ContentHolder,
				PaddingTop = UDim.new(0, 15),
				PaddingBottom = UDim.new(0, 15)
			})
			--
			do -- // Section Init
				Section_Holder_TitleInline.Size = UDim2.new(0, Section_Holder_Title.TextBounds.X + 6, 0, 2)
			end
			--
			do -- // Index Setting
				Section["Holder"] = Holder_Frame_ContentHolder
				Section["Extra"] = Section_Holder_Extra
			end
			--
			do -- // Functions
				function Section:CloseContent()
					if Section.Content.Open then
						Section.Content:Close()
						--
						Section.Content = {}
					end
				end
			end
			--
			do -- // Connections
				utility:CreateConnection(Holder_Frame_ContentHolder:GetPropertyChangedSignal("AbsoluteCanvasSize"), function()
					Holder_Extra_Gradient1.Visible = Holder_Frame_ContentHolder.AbsoluteCanvasSize.Y > Holder_Frame_ContentHolder.AbsoluteWindowSize.Y
					Holder_Extra_Gradient2.Visible = Holder_Frame_ContentHolder.AbsoluteCanvasSize.Y > Holder_Frame_ContentHolder.AbsoluteWindowSize.Y
					Holder_Extra_Bar.Visible = Holder_Frame_ContentHolder.AbsoluteCanvasSize.Y > Holder_Frame_ContentHolder.AbsoluteWindowSize.Y
                    --
                    if (Holder_Frame_ContentHolder.AbsoluteCanvasSize.Y > Holder_Frame_ContentHolder.AbsoluteWindowSize.Y) then
                        Holder_Extra_ArrowUp.Visible = (Holder_Frame_ContentHolder.CanvasPosition.Y > 5)
                        Holder_Extra_ArrowDown.Visible = (Holder_Frame_ContentHolder.CanvasPosition.Y + 5 < (Holder_Frame_ContentHolder.AbsoluteCanvasSize.Y - Holder_Frame_ContentHolder.AbsoluteSize.Y))
                    end
				end)
				--
				utility:CreateConnection(Holder_Frame_ContentHolder:GetPropertyChangedSignal("CanvasPosition"), function()
					if Section.Content.Open then
						Section.Content:Close()
						--
						Section.Content = {}
					end
                    --
                    Holder_Extra_ArrowUp.Visible = (Holder_Frame_ContentHolder.CanvasPosition.Y > 1)
                    Holder_Extra_ArrowDown.Visible = (Holder_Frame_ContentHolder.CanvasPosition.Y + 1 < (Holder_Frame_ContentHolder.AbsoluteCanvasSize.Y - Holder_Frame_ContentHolder.AbsoluteSize.Y))
				end)
                --
                utility:CreateConnection(Holder_Extra_ArrowUp.MouseButton1Click, function()
					Holder_Frame_ContentHolder.CanvasPosition = Vector2.new(0, math.clamp(Holder_Frame_ContentHolder.CanvasPosition.Y - 10, 0, Holder_Frame_ContentHolder.AbsoluteCanvasSize.Y - Holder_Frame_ContentHolder.AbsoluteSize.Y))
				end)
                --
                utility:CreateConnection(Holder_Extra_ArrowDown.MouseButton1Click, function()
					Holder_Frame_ContentHolder.CanvasPosition = Vector2.new(0, math.clamp(Holder_Frame_ContentHolder.CanvasPosition.Y + 10, 0, Holder_Frame_ContentHolder.AbsoluteCanvasSize.Y - Holder_Frame_ContentHolder.AbsoluteSize.Y))
				end)
			end
		end
		--
		return setmetatable(Section, sections)
	end
	--
	do -- // Content
		function sections:CreateToggle(Properties)
			Properties = Properties or {}
			--
			local Content = {
				Name = (Properties.name or Properties.Name or Properties.title or Properties.Title or "New Toggle"),
				State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or false),
				Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
				Window = self.Window,
				Page = self.Page,
				Section = self
			}
			--
			do
				local Content_Holder = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content.Section.Holder,
					Size = UDim2.new(1, 0, 0, 8 + 10),
					ZIndex = 3
				})
				-- //
				local Content_Holder_Outline = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(12, 12, 12),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 20, 0, 5),
					Size = UDim2.new(0, 8, 0, 8),
					ZIndex = 3
				})
				--
				local Content_Holder_Title = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 0),
					Size = UDim2.new(1, -41, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = Content.Name,
					TextColor3 = Color3.fromRGB(205, 205, 205),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextXAlignment = "Left"
				})
				--
				local Content_Holder_Title2 = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 0),
					Size = UDim2.new(1, -41, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = Content.Name,
					TextColor3 = Color3.fromRGB(205, 205, 205),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextTransparency = 0.5,
					TextXAlignment = "Left"
				})
				--
				local Content_Holder_Button = utility:RenderObject("TextButton", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Size = UDim2.new(1, 0, 1, 0),
					Text = ""
				})
				-- //
				local Holder_Outline_Frame = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(77, 77, 77),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder_Outline,
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(1, -2, 1, -2),
					ZIndex = 3
				})
				-- //
				local Outline_Frame_Gradient = utility:RenderObject("UIGradient", {
					Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(140, 140, 140)),
					Enabled = true,
					Rotation = 90,
					Parent = Holder_Outline_Frame
				})
				--
				do -- // Functions
					function Content:Set(state)
						Content.State = state
						--
						Holder_Outline_Frame.BackgroundColor3 = Content.State and Content.Window.Accent or Color3.fromRGB(77, 77, 77)
						--
						Content.Callback(Content:Get())
					end
					--
					function Content:Get()
						return Content.State
					end
				end
				--
				do -- // Connections
					utility:CreateConnection(Content_Holder_Button.MouseButton1Click, function(Input)
						Content:Set(not Content:Get())
					end)
					--
					utility:CreateConnection(Content_Holder_Button.MouseEnter, function(Input)
						Outline_Frame_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(180, 180, 180))
					end)
					--
					utility:CreateConnection(Content_Holder_Button.MouseLeave, function(Input)
						Outline_Frame_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(140, 140, 140))
					end)
				end
				--
				Content:Set(Content.State)
			end
			--
			return Content
		end
		--
		function sections:CreateSlider(Properties)
			Properties = Properties or {}
			--
			local Content = {
				Name = (Properties.name or Properties.Name or Properties.title or Properties.Title or nil),
				State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or false),
				Min = (Properties.min or Properties.Min or Properties.minimum or Properties.Minimum or 0),
				Max = (Properties.max or Properties.Max or Properties.maxmimum or Properties.Maximum or 100),
				Ending = (Properties.ending or Properties.Ending or Properties.suffix or Properties.Suffix or ""),
				Decimals = (1 / (Properties.decimals or Properties.Decimals or Properties.tick or Properties.Tick or 1)),
				Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
				Holding = false,
				Window = self.Window,
				Page = self.Page,
				Section = self
			}
			--
			do
				local Content_Holder = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content.Section.Holder,
					Size = UDim2.new(1, 0, 0, (Content.Name and 24 or 13) + 5),
					ZIndex = 3
				})
				-- //
				local Content_Holder_Outline = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(12, 12, 12),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 40, 0, Content.Name and 18 or 5),
					Size = UDim2.new(1, -99, 0, 7),
					ZIndex = 3
				})
				--
				if Content.Name then
					local Content_Holder_Title = utility:RenderObject("TextLabel", {
						AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = Color3.fromRGB(0, 0, 0),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Parent = Content_Holder,
						Position = UDim2.new(0, 41, 0, 4),
						Size = UDim2.new(1, -41, 0, 10),
						ZIndex = 3,
						Font = "Code",
						RichText = true,
						Text = Content.Name,
						TextColor3 = Color3.fromRGB(205, 205, 205),
						TextSize = 9,
						TextStrokeTransparency = 1,
						TextXAlignment = "Left"
					})
					--
					local Content_Holder_Title2 = utility:RenderObject("TextLabel", {
						AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = Color3.fromRGB(0, 0, 0),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Parent = Content_Holder,
						Position = UDim2.new(0, 41, 0, 4),
						Size = UDim2.new(1, -41, 0, 10),
						ZIndex = 3,
						Font = "Code",
						RichText = true,
						Text = Content.Name,
						TextColor3 = Color3.fromRGB(205, 205, 205),
						TextSize = 9,
						TextStrokeTransparency = 1,
						TextTransparency = 0.5,
						TextXAlignment = "Left"
					})
				end
				--
				local Content_Holder_Button = utility:RenderObject("TextButton", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Size = UDim2.new(1, 0, 1, 0),
					Text = ""
				})
				-- //
				local Holder_Outline_Frame = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(71, 71, 71),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder_Outline,
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(1, -2, 1, -2),
					ZIndex = 3
				})
				-- //
				local Outline_Frame_Slider = utility:RenderObject("Frame", {
					BackgroundColor3 = Content.Window.Accent,
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Holder_Outline_Frame,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0, 0, 1, 0),
					ZIndex = 3
				})
				--
				local Outline_Frame_Gradient = utility:RenderObject("UIGradient", {
					Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(175, 175, 175)),
					Enabled = true,
					Rotation = 270,
					Parent = Holder_Outline_Frame
				})
                -- //
                local Frame_Slider_Gradient = utility:RenderObject("UIGradient", {
					Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(175, 175, 175)),
					Enabled = true,
					Rotation = 90,
					Parent = Outline_Frame_Slider
				})
				-- //
				local Frame_Slider_Title = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Outline_Frame_Slider,
					Position = UDim2.new(1, 0, 0.5, 1),
					Size = UDim2.new(0, 2, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 11,
					TextStrokeTransparency = 0.5,
					TextXAlignment = "Center",
					RenderTime = 0.15
				})
				--
				local Frame_Slider_Title2 = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Outline_Frame_Slider,
					Position = UDim2.new(1, 0, 0.5, 1),
					Size = UDim2.new(0, 2, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 11,
					TextStrokeTransparency = 0.5,
					TextTransparency = 0,
					TextXAlignment = "Center",
					RenderTime = 0.15
				})
				--
				do -- // Functions
					function Content:Set(state)
						Content.State = math.clamp(math.round(state * Content.Decimals) / Content.Decimals, Content.Min, Content.Max)
						--
						Frame_Slider_Title.Text = "<b>" .. Content.State .. Content.Ending .. "</b>"
						Outline_Frame_Slider.Size = UDim2.new((1 - ((Content.Max - Content.State) / (Content.Max - Content.Min))), 0, 1, 0)
						--
						Content.Callback(Content:Get())
					end
					--
					function Content:Refresh()
						local Mouse = utility:MouseLocation()
						--
						Content:Set(math.clamp(math.floor((Content.Min + (Content.Max - Content.Min) * math.clamp(Mouse.X - Outline_Frame_Slider.AbsolutePosition.X, 0, Holder_Outline_Frame.AbsoluteSize.X) / Holder_Outline_Frame.AbsoluteSize.X) * Content.Decimals) / Content.Decimals, Content.Min, Content.Max))
					end
					--
					function Content:Get()
						return Content.State
					end
				end
				--
				do -- // Connections
					utility:CreateConnection(Content_Holder_Button.MouseButton1Down, function(Input)
						Content:Refresh()
						--
						Content.Holding = true
                        --
                        Outline_Frame_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(215, 215, 215))
                        Frame_Slider_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(215, 215, 215))
					end)
                    --
					utility:CreateConnection(Content_Holder_Button.MouseEnter, function(Input)
						Outline_Frame_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(215, 215, 215))
                        Frame_Slider_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(215, 215, 215))
					end)
					--
					utility:CreateConnection(Content_Holder_Button.MouseLeave, function(Input)
						Outline_Frame_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Content.Holding and Color3.fromRGB(215, 215, 215) or Color3.fromRGB(175, 175, 175))
                        Frame_Slider_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Content.Holding and Color3.fromRGB(215, 215, 215) or Color3.fromRGB(175, 175, 175))
					end)
					--
					utility:CreateConnection(uis.InputChanged, function(Input)
						if Content.Holding then
							Content:Refresh()
						end
					end)
					--
					utility:CreateConnection(uis.InputEnded, function(Input)
						if Content.Holding and Input.UserInputType == Enum.UserInputType.MouseButton1 then
							Content.Holding = false
                            --
                            Outline_Frame_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(175, 175, 175))
                        	Frame_Slider_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(175, 175, 175))
						end
					end)
				end
				--
				Content:Set(Content.State)
			end
			--
			return Content
		end
		--
		function sections:CreateDropdown(Properties)
			Properties = Properties or {}
			--
			local Content = {
				Name = (Properties.name or Properties.Name or Properties.title or Properties.Title or "New Dropdown"),
				State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or 1),
				Options = (Properties.options or Properties.Options or Properties.list or Properties.List or {1, 2, 3}),
				Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
				Content = {
					Open = false
				},
				Window = self.Window,
				Page = self.Page,
				Section = self
			}
			--
			do
				local Content_Holder = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content.Section.Holder,
					Size = UDim2.new(1, 0, 0, 34 + 5),
					ZIndex = 3
				})
				-- //
				local Content_Holder_Outline = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(12, 12, 12),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 40, 0, 15),
					Size = UDim2.new(1, -98, 0, 20),
					ZIndex = 3
				})
				--
				local Content_Holder_Title = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 4),
					Size = UDim2.new(1, -41, 0, 10),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = Content.Name,
					TextColor3 = Color3.fromRGB(205, 205, 205),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextXAlignment = "Left"
				})
				--
				local Content_Holder_Title2 = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 4),
					Size = UDim2.new(1, -41, 0, 10),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = Content.Name,
					TextColor3 = Color3.fromRGB(205, 205, 205),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextTransparency = 0.5,
					TextXAlignment = "Left"
				})
				--
				local Content_Holder_Button = utility:RenderObject("TextButton", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Size = UDim2.new(1, 0, 1, 0),
					Text = ""
				})
				-- //
				local Holder_Outline_Frame = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(36, 36, 36),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder_Outline,
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(1, -2, 1, -2),
					ZIndex = 3
				})
				-- //
				local Outline_Frame_Gradient = utility:RenderObject("UIGradient", {
					Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(220, 220, 220)),
					Enabled = true,
					Rotation = 270,
					Parent = Holder_Outline_Frame
				})
				--
				local Outline_Frame_Title = utility:RenderObject("TextLabel", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Holder_Outline_Frame,
					Position = UDim2.new(0, 8, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = "",
					TextColor3 = Color3.fromRGB(155, 155, 155),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextXAlignment = "Left"
				})
				--
				local Outline_Frame_Title2 = utility:RenderObject("TextLabel", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Holder_Outline_Frame,
					Position = UDim2.new(0, 8, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = "",
					TextColor3 = Color3.fromRGB(155, 155, 155),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextTransparency = 0,
					TextXAlignment = "Left"
				})
				--
				local Outline_Frame_Arrow = utility:RenderObject("ImageLabel", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Holder_Outline_Frame,
					Position = UDim2.new(1, -11, 0.5, -4),
					Size = UDim2.new(0, 7, 0, 6),
					Image = "rbxassetid://8532000591",
					ImageColor3 = Color3.fromRGB(255, 255, 255),
					ZIndex = 3
				})
				--
				do -- // Functions
					function Content:Set(state)
						Content.State = state
						--
						Outline_Frame_Title.Text = Content.Options[Content:Get()]
						Outline_Frame_Title2.Text = Content.Options[Content:Get()]
						--
						Content.Callback(Content:Get())
						--
						if Content.Content.Open then
							Content.Content:Refresh(Content:Get())
						end
					end
					--
					function Content:Get()
						return Content.State
					end
					--
					function Content:Open()
						Content.Section:CloseContent()
						--
						local Open = {}
						local Connections = {}
						--
						local InputCheck
						--
						local Content_Open_Holder = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(0, 0, 0),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Content.Section.Extra,
							Position = UDim2.new(0, Content_Holder_Outline.AbsolutePosition.X - Content.Section.Extra.AbsolutePosition.X, 0, Content_Holder_Outline.AbsolutePosition.Y - Content.Section.Extra.AbsolutePosition.Y + 21),
							Size = UDim2.new(1, -98, 0, (18 * #Content.Options) + 2),
							ZIndex = 6
						})
						-- //
						local Open_Holder_Outline = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(12, 12, 12),
							BackgroundTransparency = 0,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Content_Open_Holder,
							Position = UDim2.new(0, 0, 0, 0),
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 6
						})
						-- //
						local Open_Holder_Outline_Frame = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(35, 35, 35),
							BackgroundTransparency = 0,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Open_Holder_Outline,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, -2, 1, -2),
							ZIndex = 6
						})
						-- //
						for Index, Option in pairs(Content.Options) do
							local Outline_Frame_Option = utility:RenderObject("Frame", {
								BackgroundColor3 = Color3.fromRGB(35, 35, 35),
								BackgroundTransparency = 0,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Parent = Open_Holder_Outline_Frame,
								Position = UDim2.new(0, 0, 0, 18 * (Index - 1)),
								Size = UDim2.new(1, 0, 1 / #Content.Options, 0),
								ZIndex = 6
							})
							-- //
							local Frame_Option_Title = utility:RenderObject("TextLabel", {
								BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Parent = Outline_Frame_Option,
								Position = UDim2.new(0, 8, 0, 0),
								Size = UDim2.new(1, 0, 1, 0),
								ZIndex = 6,
								Font = "Code",
								RichText = true,
								Text = tostring(Option),
								TextColor3 = Index == Content.State and Content.Window.Accent or Color3.fromRGB(205, 205, 205),
								TextSize = 9,
								TextStrokeTransparency = 1,
								TextXAlignment = "Left"
							})
							--
							local Frame_Option_Title2 = utility:RenderObject("TextLabel", {
								BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Parent = Outline_Frame_Option,
								Position = UDim2.new(0, 8, 0, 0),
								Size = UDim2.new(1, 0, 1, 0),
								ZIndex = 6,
								Font = "Code",
								RichText = true,
								Text = tostring(Option),
								TextColor3 = Index == Content.State and Content.Window.Accent or Color3.fromRGB(205, 205, 205),
								TextSize = 9,
								TextStrokeTransparency = 1,
								TextTransparency = 0.5,
								TextXAlignment = "Left"
							})
							--
							local Frame_Option_Button = utility:RenderObject("TextButton", {
								BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Parent = Outline_Frame_Option,
								Size = UDim2.new(1, 0, 1, 0),
								Text = "",
								ZIndex = 6
							})
							--
							do -- // Connections
								local Clicked = utility:CreateConnection(Frame_Option_Button.MouseButton1Click, function(Input)
									Content:Set(Index)
								end)
								--
								local Entered = utility:CreateConnection(Frame_Option_Button.MouseEnter, function(Input)
									Outline_Frame_Option.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
								end)
								--
								local Left = utility:CreateConnection(Frame_Option_Button.MouseLeave, function(Input)
									Outline_Frame_Option.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
								end)
								--
								Connections[#Connections + 1] = Clicked
								Connections[#Connections + 1] = Entered
								Connections[#Connections + 1] = Left
							end
							--
							Open[#Open + 1] = {Index, Frame_Option_Title, Frame_Option_Title2, Outline_Frame_Option, Frame_Option_Button}
						end
						--
						do -- // Functions
							function Content.Content:Close()
								Content.Content.Open = false
								--
								Holder_Outline_Frame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
								--
								for Index, Value in pairs(Connections) do
									Value:Disconnect()
								end
								--
								InputCheck:Disconnect()
								--
								for Index, Value in pairs(Open) do
									Value[2]:Remove()
									Value[3]:Remove()
									Value[4]:Remove()
									Value[5]:Remove()
								end
								--
								Content_Open_Holder:Remove()
								Open_Holder_Outline:Remove()
								Open_Holder_Outline_Frame:Remove()
								--
								function Content.Content:Refresh() end
								--
								InputCheck = nil
								Connections = nil
								Open = nil
							end
							--
							function Content.Content:Refresh(state)
								for Index, Value in pairs(Open) do
									Value[2].TextColor3 = Value[1] == Content.State and Content.Window.Accent or Color3.fromRGB(205, 205, 205)
									Value[3].TextColor3 = Value[1] == Content.State and Content.Window.Accent or Color3.fromRGB(205, 205, 205)
								end
							end
						end
						--
						Content.Content.Open = true
						Content.Section.Content = Content.Content
						--
						Holder_Outline_Frame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
						--
						do -- // Connections
							task.wait()
							--
							InputCheck = utility:CreateConnection(uis.InputBegan, function(Input)
								if Content.Content.Open and Input.UserInputType == Enum.UserInputType.MouseButton1 then
									local Mouse = utility:MouseLocation()
									--
									if not (Mouse.X > Content_Open_Holder.AbsolutePosition.X  and Mouse.Y > (Content_Open_Holder.AbsolutePosition.Y + 36) and Mouse.X < (Content_Open_Holder.AbsolutePosition.X + Content_Open_Holder.AbsoluteSize.X) and Mouse.Y < (Content_Open_Holder.AbsolutePosition.Y + Content_Open_Holder.AbsoluteSize.Y + 36)) then
										Content.Section:CloseContent()
									end
								end
							end)
						end
					end
				end
				--
				do -- // Connections
					utility:CreateConnection(Content_Holder_Button.MouseButton1Down, function(Input)
						if Content.Content.Open then
							Content.Section:CloseContent()
						else
							Content:Open()
						end
					end)
					--
					utility:CreateConnection(Content_Holder_Button.MouseEnter, function(Input)
						Holder_Outline_Frame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
					end)
					--
					utility:CreateConnection(Content_Holder_Button.MouseLeave, function(Input)
						Holder_Outline_Frame.BackgroundColor3 = Content.Content.Open and Color3.fromRGB(46, 46, 46) or Color3.fromRGB(36, 36, 36)
					end)
				end
				--
				Content:Set(Content.State)
			end
			--
			return Content
		end
		--
		function sections:CreateMultibox(Properties)
			Properties = Properties or {}
			--
			local Content = {
				Name = (Properties.name or Properties.Name or Properties.title or Properties.Title or "New Dropdown"),
				State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or {1}),
				Options = (Properties.options or Properties.Options or Properties.list or Properties.List or {1, 2, 3}),
				Minimum = (Properties.min or Properties.Min or Properties.minimum or Properties.Minimum or 0),
				Maximum = (Properties.max or Properties.Max or Properties.maximum or Properties.Maximum or 1000),
				Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
				Content = {
					Open = false
				},
				Window = self.Window,
				Page = self.Page,
				Section = self
			}
			--
			do
				local Content_Holder = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content.Section.Holder,
					Size = UDim2.new(1, 0, 0, 34 + 5),
					ZIndex = 3
				})
				-- //
				local Content_Holder_Outline = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(12, 12, 12),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 40, 0, 15),
					Size = UDim2.new(1, -98, 0, 20),
					ZIndex = 3
				})
				--
				local Content_Holder_Title = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 4),
					Size = UDim2.new(1, -41, 0, 10),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = Content.Name,
					TextColor3 = Color3.fromRGB(205, 205, 205),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextXAlignment = "Left"
				})
				--
				local Content_Holder_Title2 = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 4),
					Size = UDim2.new(1, -41, 0, 10),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = Content.Name,
					TextColor3 = Color3.fromRGB(205, 205, 205),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextTransparency = 0.5,
					TextXAlignment = "Left"
				})
				--
				local Content_Holder_Button = utility:RenderObject("TextButton", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Size = UDim2.new(1, 0, 1, 0),
					Text = ""
				})
				-- //
				local Holder_Outline_Frame = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(36, 36, 36),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder_Outline,
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(1, -2, 1, -2),
					ZIndex = 3
				})
				-- //
				local Outline_Frame_Gradient = utility:RenderObject("UIGradient", {
					Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(220, 220, 220)),
					Enabled = true,
					Rotation = 270,
					Parent = Holder_Outline_Frame
				})
				--
				local Outline_Frame_Title = utility:RenderObject("TextLabel", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Holder_Outline_Frame,
					Position = UDim2.new(0, 8, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = "",
					TextColor3 = Color3.fromRGB(155, 155, 155),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextXAlignment = "Left"
				})
				--
				local Outline_Frame_Title2 = utility:RenderObject("TextLabel", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Holder_Outline_Frame,
					Position = UDim2.new(0, 8, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = "",
					TextColor3 = Color3.fromRGB(155, 155, 155),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextTransparency = 0,
					TextXAlignment = "Left"
				})
				--
				local Outline_Frame_Arrow = utility:RenderObject("ImageLabel", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Holder_Outline_Frame,
					Position = UDim2.new(1, -11, 0.5, -4),
					Size = UDim2.new(0, 7, 0, 6),
					Image = "rbxassetid://8532000591",
					ImageColor3 = Color3.fromRGB(255, 255, 255),
					ZIndex = 3
				})
				--
				do -- // Functions
					function Content:Set(state)
						table.sort(state)
						Content.State = state
						--
						local Serialised = utility:Serialise(utility:Sort(Content:Get(), Content.Options))
						--
						Serialised = Serialised == "" and "-" or Serialised
						--
						Outline_Frame_Title.Text = Serialised
						Outline_Frame_Title2.Text = Serialised
						--
						Content.Callback(Content:Get())
						--
						if Content.Content.Open then
							Content.Content:Refresh(Content:Get())
						end
					end
					--
					function Content:Get()
						return Content.State
					end
					--
					function Content:Open()
						Content.Section:CloseContent()
						--
						local Open = {}
						local Connections = {}
						--
						local InputCheck
						--
						local Content_Open_Holder = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(0, 0, 0),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Content.Section.Extra,
							Position = UDim2.new(0, Content_Holder_Outline.AbsolutePosition.X - Content.Section.Extra.AbsolutePosition.X, 0, Content_Holder_Outline.AbsolutePosition.Y - Content.Section.Extra.AbsolutePosition.Y + 21),
							Size = UDim2.new(1, -98, 0, (18 * #Content.Options) + 2),
							ZIndex = 6
						})
						-- //
						local Open_Holder_Outline = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(12, 12, 12),
							BackgroundTransparency = 0,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Content_Open_Holder,
							Position = UDim2.new(0, 0, 0, 0),
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 6
						})
						-- //
						local Open_Holder_Outline_Frame = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(21, 21, 21),
							BackgroundTransparency = 0,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Open_Holder_Outline,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, -2, 1, -2),
							ZIndex = 6
						})
						-- //
						for Index, Option in pairs(Content.Options) do
							local Outline_Frame_Option = utility:RenderObject("Frame", {
								BackgroundColor3 = Color3.fromRGB(35, 35, 35),
								BackgroundTransparency = 0,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Parent = Open_Holder_Outline_Frame,
								Position = UDim2.new(0, 0, 0, 18 * (Index - 1)),
								Size = UDim2.new(1, 0, 1 / #Content.Options, 0),
								ZIndex = 6
							})
							-- //
							local Frame_Option_Title = utility:RenderObject("TextLabel", {
								BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Parent = Outline_Frame_Option,
								Position = UDim2.new(0, 8, 0, 0),
								Size = UDim2.new(1, 0, 1, 0),
								ZIndex = 6,
								Font = "Code",
								RichText = true,
								Text = tostring(Option),
								TextColor3 = table.find(Content.State, Index) and Content.Window.Accent or Color3.fromRGB(205, 205, 205),
								TextSize = 9,
								TextStrokeTransparency = 1,
								TextXAlignment = "Left"
							})
							--
							local Frame_Option_Title2 = utility:RenderObject("TextLabel", {
								BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Parent = Outline_Frame_Option,
								Position = UDim2.new(0, 8, 0, 0),
								Size = UDim2.new(1, 0, 1, 0),
								ZIndex = 6,
								Font = "Code",
								RichText = true,
								Text = tostring(Option),
								TextColor3 = table.find(Content.State, Index) and Content.Window.Accent or Color3.fromRGB(205, 205, 205),
								TextSize = 9,
								TextStrokeTransparency = 1,
								TextTransparency = 0.5,
								TextXAlignment = "Left"
							})
							--
							local Frame_Option_Button = utility:RenderObject("TextButton", {
								BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Parent = Outline_Frame_Option,
								Size = UDim2.new(1, 0, 1, 0),
								Text = "",
								ZIndex = 6
							})
							--
							do -- // Connections
								local Clicked = utility:CreateConnection(Frame_Option_Button.MouseButton1Click, function(Input)
									local NewTable = Content:Get()
									--
									if table.find(NewTable, Index) then
										if (#NewTable - 1) >= Content.Minimum then
											table.remove(NewTable, table.find(NewTable, Index))
										end
									else
										if (#NewTable + 1) <= Content.Maximum then
											table.insert(NewTable, Index)
										end
									end
									--
									Content:Set(NewTable)
								end)
								--
								local Entered = utility:CreateConnection(Frame_Option_Button.MouseEnter, function(Input)
									Outline_Frame_Option.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
								end)
								--
								local Left = utility:CreateConnection(Frame_Option_Button.MouseLeave, function(Input)
									Outline_Frame_Option.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
								end)
								--
								Connections[#Connections + 1] = Clicked
								Connections[#Connections + 1] = Entered
								Connections[#Connections + 1] = Left
							end
							--
							Open[#Open + 1] = {Index, Frame_Option_Title, Frame_Option_Title2, Outline_Frame_Option, Frame_Option_Button}
						end
						--
						do -- // Functions
							function Content.Content:Close()
								Content.Content.Open = false
                                --
								Holder_Outline_Frame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
								--
								for Index, Value in pairs(Connections) do
									Value:Disconnect()
								end
								--
								InputCheck:Disconnect()
								--
								for Index, Value in pairs(Open) do
									Value[2]:Remove()
									Value[3]:Remove()
									Value[4]:Remove()
									Value[5]:Remove()
								end
								--
								Content_Open_Holder:Remove()
								Open_Holder_Outline:Remove()
								Open_Holder_Outline_Frame:Remove()
								--
								function Content.Content:Refresh() end
								--
								InputCheck = nil
								Connections = nil
								Open = nil
							end
							--
							function Content.Content:Refresh(state)
								for Index, Value in pairs(Open) do
									Value[2].TextColor3 = table.find(Content.State, Value[1]) and Content.Window.Accent or Color3.fromRGB(205, 205, 205)
									Value[3].TextColor3 = table.find(Content.State, Value[1]) and Content.Window.Accent or Color3.fromRGB(205, 205, 205)
								end
							end
						end
						--
						Content.Content.Open = true
						Content.Section.Content = Content.Content
                        --
						Holder_Outline_Frame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
						--
						do -- // Connections
							task.wait()
							--
							InputCheck = utility:CreateConnection(uis.InputBegan, function(Input)
								if Content.Content.Open and Input.UserInputType == Enum.UserInputType.MouseButton1 then
									local Mouse = utility:MouseLocation()
									--
									if not (Mouse.X > Content_Open_Holder.AbsolutePosition.X and Mouse.Y > (Content_Open_Holder.AbsolutePosition.Y + 36) and Mouse.X < (Content_Open_Holder.AbsolutePosition.X + Content_Open_Holder.AbsoluteSize.X) and Mouse.Y < (Content_Open_Holder.AbsolutePosition.Y + Content_Open_Holder.AbsoluteSize.Y + 36)) then
										Content.Section:CloseContent()
									end
								end
							end)
						end
					end
				end
				--
				do -- // Connections
					utility:CreateConnection(Content_Holder_Button.MouseButton1Down, function(Input)
						if Content.Content.Open then
							Content.Section:CloseContent()
						else
							Content:Open()
						end
					end)
                    --
					utility:CreateConnection(Content_Holder_Button.MouseEnter, function(Input)
						Holder_Outline_Frame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
					end)
					--
					utility:CreateConnection(Content_Holder_Button.MouseLeave, function(Input)
						Holder_Outline_Frame.BackgroundColor3 = Content.Content.Open and Color3.fromRGB(46, 46, 46) or Color3.fromRGB(36, 36, 36)
					end)
				end
				--
				Content:Set(Content.State)
			end
			--
			return Content
		end
		--
		function sections:CreateKeybind(Properties)
			Properties = Properties or {}
			--
			local Content = {
				Name = (Properties.name or Properties.Name or Properties.title or Properties.Title or "New Toggle"),
				State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or nil),
                Mode = (Properties.mode or Properties.Mode or "Hold"),
				Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
                Active = false,
                Holding = false,
				Window = self.Window,
				Page = self.Page,
				Section = self
			}
            --
            local Keys = {
                KeyCodes = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M", "One", "Two", "Three", "Four", "Five", "Six", "Seveen", "Eight", "Nine", "0", "Insert", "Tab", "Home", "End", "LeftAlt", "LeftControl", "LeftShift", "RightAlt", "RightControl", "RightShift", "CapsLock"},
                Inputs = {"MouseButton1", "MouseButton2", "MouseButton3"},
                Shortened = {["MouseButton1"] = "M1", ["MouseButton2"] = "M2", ["MouseButton3"] = "M3", ["Insert"] = "INS", ["LeftAlt"] = "LA", ["LeftControl"] = "LC", ["LeftShift"] = "LS", ["RightAlt"] = "RA", ["RightControl"] = "RC", ["RightShift"] = "RS", ["CapsLock"] = "CL"}
            }
			--
			do
				local Content_Holder = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content.Section.Holder,
					Size = UDim2.new(1, 0, 0, 8 + 10),
					ZIndex = 3
				})
				-- //
				local Content_Holder_Title = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 0),
					Size = UDim2.new(1, -41, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = Content.Name,
					TextColor3 = Color3.fromRGB(205, 205, 205),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextXAlignment = "Left"
				})
				--
				local Content_Holder_Title2 = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 0),
					Size = UDim2.new(1, -41, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = Content.Name,
					TextColor3 = Color3.fromRGB(205, 205, 205),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextTransparency = 0.5,
					TextXAlignment = "Left"
				})
				--
				local Content_Holder_Button = utility:RenderObject("TextButton", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Size = UDim2.new(1, 0, 1, 0),
					Text = ""
				})
                -- //
                local Content_Holder_Value = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 0),
					Size = UDim2.new(1, -61, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text =  "",
					TextColor3 = Color3.fromRGB(114, 114, 114),
                    TextStrokeColor3 = Color3.fromRGB(15, 15, 15),
					TextSize = 9,
					TextStrokeTransparency = 0,
					TextXAlignment = "Right"
				})
				--
				do -- // Functions
					function Content:Set(state)
						Content.State = state or {}
                        Content.Active = false
                        --
                        Content_Holder_Value.Text = "[" .. (#Content:Get() > 0 and Content:Shorten(Content:Get()[2]) or "-") .. "]"
						--
						Content.Callback(Content:Get())
					end
					--
					function Content:Get()
						return Content.State
					end
                    --
                    function Content:Shorten(Str)
                        for Index, Value in pairs(Keys.Shortened) do
                            Str = string.gsub(Str, Index, Value)
                        end
                        --
                        return Str
                    end
                    --
                    function Content:Change(Key)
                        if Key.EnumType then
                            if Key.EnumType == Enum.KeyCode or Key.EnumType == Enum.UserInputType then
                                if table.find(Keys.KeyCodes, Key.Name) or table.find(Keys.Inputs, Key.Name) then
                                    Content:Set({Key.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType", Key.Name})
                                    return true
                                end
                            end
                        end
                    end
				end
				--
				do -- // Connections
					utility:CreateConnection(Content_Holder_Button.MouseButton1Click, function(Input)
						Content.Holding = true
                        --
                        Content_Holder_Value.TextColor3 = Color3.fromRGB(255, 0, 0)
					end)
                    --
                    utility:CreateConnection(Content_Holder_Button.MouseButton2Click, function(Input)
						Content:Set()
					end)
                    --
					utility:CreateConnection(Content_Holder_Button.MouseEnter, function(Input)
						Content_Holder_Value.TextColor3 = Color3.fromRGB(164, 164, 164)
					end)
					--
					utility:CreateConnection(Content_Holder_Button.MouseLeave, function(Input)
						Content_Holder_Value.TextColor3 = Content.Holding and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(114, 114, 114)
					end)
                    --
                    utility:CreateConnection(uis.InputBegan, function(Input)
                        if Content.Holding then
                            local Success = Content:Change(Input.KeyCode.Name ~= "Unknown" and Input.KeyCode or Input.UserInputType)
                            --
                            if Success then
                                Content.Holding = false
                                --
                                Content_Holder_Value.TextColor3 = Color3.fromRGB(114, 114, 114)
                            end
                        end
                        --
                        if Content:Get()[1] and Content:Get()[2] then
                            if Input.KeyCode == Enum[Content:Get()[1]][Content:Get()[2]] or Input.UserInputType == Enum[Content:Get()[1]][Content:Get()[2]] then
                                if Content.Mode == "Hold" then
                                    Content.Active = true
                                elseif Content.Mode == "Toggle" then
                                    Content.Active = not Content.Active
                                end
                            end
                        end
                    end)
                    --
                    utility:CreateConnection(uis.InputEnded, function(Input)
                        if Content:Get()[1] and Content:Get()[2] then
                            if Input.KeyCode == Enum[Content:Get()[1]][Content:Get()[2]] or Input.UserInputType == Enum[Content:Get()[1]][Content:Get()[2]] then
                                if Content.Mode == "Hold" then
                                    Content.Active = false
                                end
                            end
                        end
                    end)
				end
				--
				Content:Set(Content.State)
			end
			--
			return Content
		end
		--
		function sections:CreateColorpicker(Properties)
			Properties = Properties or {}
			--
			local Content = {
				Name = (Properties.name or Properties.Name or Properties.title or Properties.Title or "New Toggle"),
				State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or Color3.fromRGB(255, 255, 255)),
				Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
				Content = {
					Open = false
				},
				Window = self.Window,
				Page = self.Page,
				Section = self
			}
			--
			do
				local Content_Holder = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content.Section.Holder,
					Size = UDim2.new(1, 0, 0, 8 + 10),
					ZIndex = 3
				})
				-- //
				local Content_Holder_Outline = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(12, 12, 12),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(1, -38, 0, 4),
					Size = UDim2.new(0, 17, 0, 9),
					ZIndex = 3
				})
				--
				local Content_Holder_Title = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 0),
					Size = UDim2.new(1, -41, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = Content.Name,
					TextColor3 = Color3.fromRGB(205, 205, 205),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextXAlignment = "Left"
				})
				--
				local Content_Holder_Title2 = utility:RenderObject("TextLabel", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Position = UDim2.new(0, 41, 0, 0),
					Size = UDim2.new(1, -41, 1, 0),
					ZIndex = 3,
					Font = "Code",
					RichText = true,
					Text = Content.Name,
					TextColor3 = Color3.fromRGB(205, 205, 205),
					TextSize = 9,
					TextStrokeTransparency = 1,
					TextTransparency = 0.5,
					TextXAlignment = "Left"
				})
				--
				local Content_Holder_Button = utility:RenderObject("TextButton", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder,
					Size = UDim2.new(1, 0, 1, 0),
					Text = ""
				})
				-- //
				local Holder_Outline_Frame = utility:RenderObject("Frame", {
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Parent = Content_Holder_Outline,
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(1, -2, 1, -2),
					ZIndex = 3
				})
				-- //
				local Outline_Frame_Gradient = utility:RenderObject("UIGradient", {
					Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(140, 140, 140)),
					Enabled = true,
					Rotation = 90,
					Parent = Holder_Outline_Frame
				})
				--
				do -- // Functions
					function Content:Set(state)
						Content.State = state
						--
						Holder_Outline_Frame.BackgroundColor3 = Content.State
						--
						Content.Callback(Content:Get())
					end
					--
					function Content:Get()
						return Content.State
					end
					--
					function Content:Open()
						Content.Section:CloseContent()
						--
						local Connections = {}
						--
						local InputCheck
						--
						local Content_Open_Holder = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(0, 0, 0),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Content.Section.Extra,
							Position = UDim2.new(0, Content_Holder_Outline.AbsolutePosition.X - Content.Section.Extra.AbsolutePosition.X, 0, Content_Holder_Outline.AbsolutePosition.Y - Content.Section.Extra.AbsolutePosition.Y + 10),
							Size = UDim2.new(0, 180, 0, 175),
							ZIndex = 6
						})
						-- //
						local Open_Holder_Button = utility:RenderObject("TextButton", {
							BackgroundColor3 = Color3.fromRGB(0, 0, 0),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Content_Open_Holder,
							Position = UDim2.new(0, -1, 0, -1),
							Size = UDim2.new(1, 2, 1, 2),
							Text = ""
						})
						-- //
						local Open_Holder_Outline = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(60, 60, 60),
							BackgroundTransparency = 0,
							BorderColor3 = Color3.fromRGB(12, 12, 12),
							BorderMode = "Inset",
							BorderSizePixel = 1,
							Parent = Content_Open_Holder,
							Position = UDim2.new(0, 0, 0, 0),
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 6
						})
						-- //
						local Open_Outline_Frame = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(40, 40, 40),
							BackgroundTransparency = 0,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Open_Holder_Outline,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, -2, 1, -2),
							ZIndex = 6
						})
						-- //
						local ValSat_Picker_Outline = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(12, 12, 12),
							BackgroundTransparency = 0,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Open_Outline_Frame,
							Position = UDim2.new(0, 2, 0, 2),
							Size = UDim2.new(0, 152, 0, 152),
							ZIndex = 6
						})
						--
						local Hue_Picker_Outline = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(12, 12, 12),
							BackgroundTransparency = 0,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Open_Outline_Frame,
							Position = UDim2.new(1, -19, 0, 2),
							Size = UDim2.new(0, 17, 0, 152),
							ZIndex = 6
						})
						--
						local Transparency_Picker_Outline = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(12, 12, 12),
							BackgroundTransparency = 0,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = Open_Outline_Frame,
							Position = UDim2.new(0, 2, 1, -14),
							Size = UDim2.new(0, 152, 0, 12),
							ZIndex = 6
						})
						-- //
						local ValSat_Picker_Color = utility:RenderObject("Frame", {
							BackgroundColor3 = Color3.fromRGB(255, 12, 12),
							BackgroundTransparency = 0,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Parent = ValSat_Picker_Outline,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, -2, 1, -2),
							ZIndex = 6
						})
						--
						do -- // Functions
							function Content.Content:Close()
								Content.Content.Open = false
								--
								for Index, Value in pairs(Connections) do
									Value:Disconnect()
								end
								--
								InputCheck:Disconnect()
								--
								Content_Open_Holder:Remove()
								--
								function Content.Content:Refresh() end
								--
								InputCheck = nil
								Connections = nil
							end
							--
							function Content.Content:Refresh(state)
							end
						end
						--
						Content.Content.Open = true
						Content.Section.Content = Content.Content
						--
						do -- // Connections
							InputCheck = utility:CreateConnection(uis.InputBegan, function(Input)
								if Content.Content.Open and Input.UserInputType == Enum.UserInputType.MouseButton1 then
									local Mouse = utility:MouseLocation()
									--
									if not (Mouse.X > Content_Open_Holder.AbsolutePosition.X and Mouse.Y > (Content_Open_Holder.AbsolutePosition.Y + 36) and Mouse.X < (Content_Open_Holder.AbsolutePosition.X + Content_Open_Holder.AbsoluteSize.X) and Mouse.Y < (Content_Open_Holder.AbsolutePosition.Y + Content_Open_Holder.AbsoluteSize.Y + 36)) then
										if not (Mouse.X > Content_Holder.AbsolutePosition.X and Mouse.Y > (Content_Holder.AbsolutePosition.Y) and Mouse.X < (Content_Holder.AbsolutePosition.X + Content_Holder.AbsoluteSize.X) and Mouse.Y < (Content_Holder.AbsolutePosition.Y + Content_Holder.AbsoluteSize.Y)) then
											if Content.Content.Open then
												Content.Section:CloseContent()
											end
										end
									end
								end
							end)
						end
					end
				end
				--
				do -- // Connections
					utility:CreateConnection(Content_Holder_Button.MouseButton1Click, function(Input)
						if Content.Content.Open then
							Content.Section:CloseContent()
						else
							Content:Open()
						end
					end)
					--
					utility:CreateConnection(Content_Holder_Button.MouseEnter, function(Input)
						Outline_Frame_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(180, 180, 180))
					end)
					--
					utility:CreateConnection(Content_Holder_Button.MouseLeave, function(Input)
						Outline_Frame_Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(140, 140, 140))
					end)
				end
				--
				Content:Set(Content.State)
			end
			--
			return Content
		end
	end
-- [[  // Main // ]]
local window = library:CreateWindow({})

-- Rage Page
local rage = window:CreatePage({Icon = "rbxassetid://8547236654"})
local rage_aimbot = rage:CreateSection({Name = "Aimbot", Size = 510, Side = "Left"})
local rage_other = rage:CreateSection({Name = "Other", Size = 510, Side = "Right"})

-- Rage Aimbot Section
rage_aimbot:CreateToggle({Name = "Enabled", State = false})
rage_aimbot:CreateKeybind({Name = "Aimbot Key"})
rage_aimbot:CreateDropdown({Name = "Hitbox", State = 1, Options = {"Head", "Chest", "Pelvis", "Nearest"}})
rage_aimbot:CreateSlider({Name = "FOV", State = 90, Max = 180, Min = 0, Decimals = 1, Suffix = "°"})
rage_aimbot:CreateSlider({Name = "Smoothness", State = 0, Max = 100, Min = 0, Decimals = 1, Suffix = "%"})
rage_aimbot:CreateToggle({Name = "Silent Aim", State = false})
rage_aimbot:CreateToggle({Name = "Wallbang", State = false})
rage_aimbot:CreateToggle({Name = "Autoshoot", State = false})
rage_aimbot:CreateToggle({Name = "Hitscan", State = false})
rage_aimbot:CreateSlider({Name = "Minimum Damage", State = 10, Max = 100, Min = 1, Decimals = 0, Suffix = "hp"})

-- Rage Other Section
rage_other:CreateToggle({Name = "Knife Bot", State = false})
rage_other:CreateToggle({Name = "Zeus Bot", State = false})
rage_other:CreateToggle({Name = "Auto Peek", State = false})
rage_other:CreateToggle({Name = "Edge Jump", State = false})
rage_other:CreateToggle({Name = "Quick Stop", State = false})
rage_other:CreateDropdown({Name = "Resolver", State = 1, Options = {"Off", "Basic", "Advanced"}})
rage_other:CreateToggle({Name = "Backtrack", State = false})
rage_other:CreateSlider({Name = "Backtrack Time", State = 200, Max = 400, Min = 0, Decimals = 0, Suffix = "ms"})

-- Anti-Aim Page
local antiaim = window:CreatePage({Icon = "rbxassetid://17321469922"})
local antiaim_angles = antiaim:CreateSection({Name = "Anti-aimbot angles", Size = 510, Side = "Left"})
local antiaim_fakelag = antiaim:CreateSection({Name = "Fake lag", Size = 245, Side = "Right"})
local antiaim_other = antiaim:CreateSection({Name = "Other", Size = 245, Side = "Right"})

-- Anti-Aimbot Angles Section
antiaim_angles:CreateToggle({Name = "Enabled", State = false})
antiaim_angles:CreateDropdown({Name = "Yaw Base", State = 1, Options = {"At Target", "Static", "Random"}})
antiaim_angles:CreateSlider({Name = "Yaw Offset", State = 0, Max = 180, Min = -180, Decimals = 1, Suffix = "°"})
antiaim_angles:CreateDropdown({Name = "Pitch", State = 1, Options = {"Off", "Down", "Up", "Fake Up", "Fake Down"}})
antiaim_angles:CreateToggle({Name = "Jitter", State = false})
antiaim_angles:CreateSlider({Name = "Jitter Angle", State = 30, Max = 180, Min = 0, Decimals = 1, Suffix = "°"})
antiaim_angles:CreateToggle({Name = "Spinbot", State = false})
antiaim_angles:CreateSlider({Name = "Spin Speed", State = 50, Max = 100, Min = 0, Decimals = 1, Suffix = "%"})

-- Fake Lag Section
antiaim_fakelag:CreateToggle({Name = "Enabled", State = false})
antiaim_fakelag:CreateDropdown({Name = "Mode", State = 1, Options = {"Static", "Adaptive", "Random"}})
antiaim_fakelag:CreateSlider({Name = "Limit", State = 6, Max = 14, Min = 1, Decimals = 0, Suffix = "ticks"})
antiaim_fakelag:CreateToggle({Name = "On Shot", State = false})

-- Anti-Aim Other Section
antiaim_other:CreateToggle({Name = "Fake Duck", State = false})
antiaim_other:CreateKeybind({Name = "Fake Duck Key"})
antiaim_other:CreateToggle({Name = "Slow Walk", State = false})
antiaim_other:CreateKeybind({Name = "Slow Walk Key"})
antiaim_other:CreateToggle({Name = "Legit AA on Knife", State = false})

-- Aimbot Page
local aimbot = window:CreatePage({Icon = "rbxassetid://8547249956"})
local aimbot_main = aimbot:CreateSection({Name = "Aimbot", Size = 510, Side = "Left"})
local aimbot_triggerbot = aimbot:CreateSection({Name = "Triggerbot", Size = 330, Side = "Right"})
local aimbot_other = aimbot:CreateSection({Name = "Other", Size = 160, Side = "Right"})

-- Aimbot Main Section
aimbot_main:CreateToggle({Name = "Enabled", State = false})
aimbot_main:CreateKeybind({Name = "Aimbot Key"})
aimbot_main:CreateDropdown({Name = "Hitbox", State = 1, Options = {"Head", "Chest", "Pelvis", "Multi-Hitbox"}})
aimbot_main:CreateSlider({Name = "FOV", State = 60, Max = 180, Min = 0, Decimals = 1, Suffix = "°"})
aimbot_main:CreateSlider({Name = "Smoothness", State = 20, Max = 100, Min = 0, Decimals = 1, Suffix = "%"})
aimbot_main:CreateToggle({Name = "Lock Target", State = false})
aimbot_main:CreateToggle({Name = "Visible Only", State = false})
aimbot_main:CreateToggle({Name = "Team Check", State = true})

-- Triggerbot Section
aimbot_triggerbot:CreateToggle({Name = "Enabled", State = false})
aimbot_triggerbot:CreateKeybind({Name = "Trigger Key"})
aimbot_triggerbot:CreateSlider({Name = "Delay", State = 0, Max = 500, Min = 0, Decimals = 0, Suffix = "ms"})
aimbot_triggerbot:CreateToggle({Name = "Hitchance", State = false})
aimbot_triggerbot:CreateSlider({Name = "Hitchance Percent", State = 80, Max = 100, Min = 0, Decimals = 1, Suffix = "%"})

-- Aimbot Other Section
aimbot_other:CreateToggle({Name = "Autowall", State = false})
aimbot_other:CreateToggle({Name = "Killshot", State = false})
aimbot_other:CreateToggle({Name = "Movement Prediction", State = false})

-- Visuals Page
local visuals = window:CreatePage({Icon = "rbxassetid://8547254518"})
local visuals_playeresp = visuals:CreateSection({Name = "Player ESP", Size = 330, Side = "Left"})
local visuals_coloredmodels = visuals:CreateSection({Name = "Colored models", Size = 158, Side = "Left"})
local visuals_otheresp = visuals:CreateSection({Name = "Other ESP", Size = 200, Side = "Right"})
local visuals_effects = visuals:CreateSection({Name = "Effects", Size = 288, Side = "Right"})

-- Player ESP Section
visuals_playeresp:CreateKeybind({Name = "Activation Type"})
visuals_playeresp:CreateToggle({Name = "Teammates", State = false})
visuals_playeresp:CreateColorpicker({Name = "Visualize aimbot", State = Color3.fromRGB(255, 0, 0)})
visuals_playeresp:CreateColorpicker({Name = "Bounding Box", State = Color3.fromRGB(50, 100, 200)})
visuals_playeresp:CreateColorpicker({Name = "Glow", State = Color3.fromRGB(25, 180, 75)})
visuals_playeresp:CreateToggle({Name = "Dormant", State = false})
visuals_playeresp:CreateToggle({Name = "Bounding Box", State = false})
visuals_playeresp:CreateToggle({Name = "Health Bar", State = false})
visuals_playeresp:CreateToggle({Name = "Name", State = false})
visuals_playeresp:CreateToggle({Name = "Flags", State = false})
visuals_playeresp:CreateToggle({Name = "Weapon Text", State = false})
visuals_playeresp:CreateToggle({Name = "Weapon Icon", State = false})
visuals_playeresp:CreateToggle({Name = "Ammo", State = false})
visuals_playeresp:CreateToggle({Name = "Distance", State = false})
visuals_playeresp:CreateToggle({Name = "Glow", State = false})
visuals_playeresp:CreateToggle({Name = "Hit Marker", State = false})
visuals_playeresp:CreateToggle({Name = "Hit Marker Sound", State = false})
visuals_playeresp:CreateToggle({Name = "Visualize sounds", State = false})
visuals_playeresp:CreateToggle({Name = "Line of sight", State = false})
visuals_playeresp:CreateToggle({Name = "Money", State = false})
visuals_playeresp:CreateToggle({Name = "Skeleton", State = false})
visuals_playeresp:CreateToggle({Name = "Out of FOV arrow", State = true})
visuals_playeresp:CreateSlider({Name = "Font Size", State = 12, Max = 30, Min = 1, Decimals = 1, Suffix = "px"})
visuals_playeresp:CreateSlider({Name = "Opacity", State = 100, Max = 100, Min = 1, Decimals = 1, Suffix = "%"})

-- Colored Models Section
visuals_coloredmodels:CreateToggle({Name = "Player", State = false})
visuals_coloredmodels:CreateToggle({Name = "Player behind wall", State = false})
visuals_coloredmodels:CreateToggle({Name = "Teammate", State = false})
visuals_coloredmodels:CreateToggle({Name = "Teammate behind wall", State = false})
visuals_coloredmodels:CreateToggle({Name = "Local player", State = false})
visuals_coloredmodels:CreateToggle({Name = "Local player fake", State = false})
visuals_coloredmodels:CreateToggle({Name = "Ragdolls", State = false})
visuals_coloredmodels:CreateToggle({Name = "Hands", State = false})
visuals_coloredmodels:CreateToggle({Name = "Weapon viewmodel", State = false})
visuals_coloredmodels:CreateToggle({Name = "Disable model occlusion", State = false})
visuals_coloredmodels:CreateToggle({Name = "Shadow", State = false})
visuals_coloredmodels:CreateToggle({Name = "Props", State = false})

-- Other ESP Section
visuals_otheresp:CreateToggle({Name = "Radar", State = false})
visuals_otheresp:CreateMultibox({Name = "Dropped weapons", State = {1, 3, 4}, Options = {"Icon", "Text", "Glow", "Ammo", "Distance"}})
visuals_otheresp:CreateToggle({Name = "Grenades", State = false})
visuals_otheresp:CreateToggle({Name = "Inaccuracy overlay", State = false})
visuals_otheresp:CreateToggle({Name = "Recoil overlay", State = false})
visuals_otheresp:CreateToggle({Name = "Crosshair", State = false})
visuals_otheresp:CreateToggle({Name = "Bomb", State = false})
visuals_otheresp:CreateToggle({Name = "Grenade trajectory", State = false})
visuals_otheresp:CreateToggle({Name = "Grenade proximity warning", State = false})
visuals_otheresp:CreateToggle({Name = "Spectators", State = false})
visuals_otheresp:CreateToggle({Name = "Penetration reticle", State = false})
visuals_otheresp:CreateToggle({Name = "Hostages", State = false})
visuals_otheresp:CreateToggle({Name = "Shared esp", State = false})
visuals_otheresp:CreateToggle({Name = "Upgrade tablet", State = false})
visuals_otheresp:CreateToggle({Name = "Danger Zone items", State = false})

-- Effects Section
visuals_effects:CreateToggle({Name = "Remove flashbang effects", State = false})
visuals_effects:CreateToggle({Name = "Remove smoke grenades", State = false})
visuals_effects:CreateToggle({Name = "Remove fog", State = false})
visuals_effects:CreateToggle({Name = "Remove grass", State = false})
visuals_effects:CreateToggle({Name = "Remove skybox", State = false})
visuals_effects:CreateDropdown({Name = "Visual Recoil Adjustment", State = 1, Options = {"Off", "Remove Shake", "Remove All"}})
visuals_effects:CreateSlider({Name = "Transparent walls", State = 50, Max = 100, Min = 0, Decimals = 1, Suffix = "%"})
visuals_effects:CreateSlider({Name = "Transparent props", State = 50, Max = 100, Min = 0, Decimals = 1, Suffix = "%"})
visuals_effects:CreateDropdown({Name = "Brightness Adjustment", State = 1, Options = {"Off", "Night Mode", "Full Bright"}})
visuals_effects:CreateToggle({Name = "Remove scope overlay", State = false})
visuals_effects:CreateToggle({Name = "Instant scope", State = false})
visuals_effects:CreateToggle({Name = "Disable post processing", State = false})
visuals_effects:CreateToggle({Name = "Force third person (alive)", State = false})
visuals_effects:CreateToggle({Name = "Force third person (dead)", State = false})
visuals_effects:CreateToggle({Name = "Disable rendering of teammates", State = false})
visuals_effects:CreateToggle({Name = "Bullet tracers", State = false})
visuals_effects:CreateToggle({Name = "Bullet impacts", State = false})
visuals_effects:CreateToggle({Name = "Override Skybox", State = false})

-- Settings Page
local setting = window:CreatePage({Icon = "rbxassetid://8547256547"})
local setting_misc = setting:CreateSection({Name = "Miscellaneous", Size = 510, Side = "Left"})
local setting_movement = setting:CreateSection({Name = "Movement", Size = 245, Side = "Right"})
local setting_settings = setting:CreateSection({Name = "Settings", Size = 245, Side = "Right"})

-- Miscellaneous Section
setting_misc:CreateToggle({Name = "Bunny Hop", State = false})
setting_misc:CreateToggle({Name = "Auto Strafe", State = false})
setting_misc:CreateDropdown({Name = "Strafe Mode", State = 1, Options = {"Silent", "Normal", "Rage"}})
setting_misc:CreateToggle({Name = "Fast Walk", State = false})
setting_misc:CreateToggle({Name = "Slide Walk", State = false})
setting_misc:CreateToggle({Name = "Kill Say", State = false})
setting_misc:CreateToggle({Name = "Clantag Changer", State = false})
setting_misc:CreateToggle({Name = "Chat Spam", State = false})

-- Movement Section
setting_movement:CreateToggle({Name = "Circle Strafe", State = false})
setting_movement:CreateKeybind({Name = "Circle Strafe Key"})
setting_movement:CreateToggle({Name = "Air Stuck", State = false})
setting_movement:CreateKeybind({Name = "Air Stuck Key"})
setting_movement:CreateToggle({Name = "Jump Bug", State = false})
setting_movement:CreateToggle({Name = "Edge Bug", State = false})

-- Settings Section
setting_settings:CreateToggle({Name = "Menu Accent", State = false})
setting_settings:CreateColorpicker({Name = "Menu Color", State = Color3.fromRGB(255, 255, 255)})
setting_settings:CreateKeybind({Name = "Menu Toggle Key"})
setting_settings:CreateToggle({Name = "Watermark", State = true})
setting_settings:CreateToggle({Name = "Show Keybinds", State = false})
setting_settings:CreateToggle({Name = "Show FPS", State = false})

-- Players Page
local players = window:CreatePage({Icon = "rbxassetid://8547269749"})
local players_main = players:CreateSection({Name = "Players", Size = 510, Side = "Left"})
local players_adjustments = players:CreateSection({Name = "Adjustments", Size = 510, Side = "Right"})

-- Players Main Section
players_main:CreateToggle({Name = "Friendly Fire", State = false})
players_main:CreateToggle({Name = "Override Resolver", State = false})
players_main:CreateDropdown({Name = "Player Priority", State = 1, Options = {"None", "High", "Low"}})
players_main:CreateToggle({Name = "Mark Players", State = false})

-- Players Adjustments Section
players_adjustments:CreateSlider({Name = "Health Filter", State = 100, Max = 100, Min = 0, Decimals = 0, Suffix = "hp"})
players_adjustments:CreateToggle({Name = "Ignore Dormant", State = false})
players_adjustments:CreateToggle({Name = "Ignore Friends", State = true})
players_adjustments:CreateToggle({Name = "Ignore Teammates", State = true})

-- Config Page
local config = window:CreatePage({Icon = "rbxassetid://11768914234"})
local config_presets = config:CreateSection({Name = "Presets", Size = 510, Side = "Left"})
local config_adjustments = config:CreateSection({Name = "Adjustments", Size = 510, Side = "Right"})

-- Presets Section
config_presets:CreateDropdown({Name = "Config List", State = 1, Options = {"Default", "Legit", "Rage", "Custom"}})
config_presets:CreateButton({Name = "Load Config"})
config_presets:CreateButton({Name = "Save Config"})
config_presets:CreateButton({Name = "Delete Config"})
config_presets:CreateTextbox({Name = "Config Name", Placeholder = "Enter config name"})

-- Adjustments Section
config_adjustments:CreateToggle({Name = "Load on startup", State = false})
config_adjustments:CreateToggle({Name = "Auto Save", State = false})
config_adjustments:CreateButton({Name = "Reset to Default"})
config_adjustments:CreateToggle({Name = "Cloud Config", State = false})

end)

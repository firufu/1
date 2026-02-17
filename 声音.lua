-- 获取本地玩家
local localPlayer = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")

-- ========== UI 代码 ==========
-- 创建主UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AimAssistUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- 主容器
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.3, 0, 0, 30)
mainFrame.Position = UDim2.new(0.35, 0, 0.05, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- 圆角
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = mainFrame

-- 标题栏
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundTransparency = 1
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Text = "声音之塔脚本"
title.TextColor3 = Color3.fromRGB(220, 220, 255)
title.TextSize = 12
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.Position = UDim2.new(0.05, 0, 0, 0)
title.Parent = titleBar

-- 折叠按钮
local foldButton = Instance.new("TextButton")
foldButton.Size = UDim2.new(0.3, 0, 0.7, 0)
foldButton.Position = UDim2.new(0.65, 0, 0.15, 0)
foldButton.Text = "▼"
foldButton.TextColor3 = Color3.fromRGB(180, 180, 255)
foldButton.TextSize = 14
foldButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
foldButton.BackgroundTransparency = 0.5
foldButton.AutoButtonColor = false
foldButton.Parent = titleBar

local foldCorner = Instance.new("UICorner")
foldCorner.CornerRadius = UDim.new(0, 4)
foldCorner.Parent = foldButton

-- 状态指示灯
local statusLight = Instance.new("Frame")
statusLight.Size = UDim2.new(0, 8, 0, 8)
statusLight.Position = UDim2.new(0.9, -14, 0.5, -4)
statusLight.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- 默认绿色表示就绪
statusLight.BorderSizePixel = 0
statusLight.Parent = titleBar

local lightCorner = Instance.new("UICorner")
lightCorner.CornerRadius = UDim.new(1, 0)
lightCorner.Parent = statusLight

-- 内容区域（默认折叠）
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 0, 0)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
contentFrame.BackgroundTransparency = 0.2
contentFrame.ClipsDescendants = true
contentFrame.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 6)
contentCorner.Parent = contentFrame

-- 创建按钮的函数
local function createButton(text, yPosition)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 22)
    button.Position = UDim2.new(0.05, 0, yPosition, 0)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(220, 220, 255)
    button.TextSize = 10
    button.Font = Enum.Font.Gotham
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    button.BackgroundTransparency = 0.3
    button.AutoButtonColor = true
    button.Parent = contentFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = button
    
    -- 悬停效果
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.15
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.3
        }):Play()
    end)
    
    return button
end

-- ========== 核心功能逻辑 ==========
-- 定义发送指令的函数
local function sendAwardCommand(awardType)
    -- 状态灯闪烁红色表示正在发送
    statusLight.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    
    local args = {
        "Award",
        awardType
    }
    
    -- 调用远程事件
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Send"):InvokeServer(unpack(args))
    end)
    
    -- 状态灯恢复绿色
    wait(0.5)
    statusLight.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
end

-- ========== 按钮事件绑定 ==========
-- 1. 获取生命值按钮
local getLifeButton = createButton("1. 获取生命值 (1Life)", 0.1)
getLifeButton.MouseButton1Click:Connect(function()
    sendAwardCommand("1Life")
end)

-- 2. 跳过关卡按钮
local skipLevelButton = createButton("2. 跳过关卡 (Skip)", 0.25)
skipLevelButton.MouseButton1Click:Connect(function()
    sendAwardCommand("Skip")
end)

-- 3. 获得速度项圈
local speedCoilButton = createButton("3. 获得速度项圈 (SpeedCoil)", 0.40)
speedCoilButton.MouseButton1Click:Connect(function()
    sendAwardCommand("SpeedCoil")
end)

-- 4. 身体交换
local bodySwapButton = createButton("4. 身体交换 (BodySwap)", 0.55)
bodySwapButton.MouseButton1Click:Connect(function()
    sendAwardCommand("BodySwap")
end)

-- 5. 融合项圈
local fusionCoilButton = createButton("5. 融合项圈 (FusionCoil)", 0.70)
fusionCoilButton.MouseButton1Click:Connect(function()
    sendAwardCommand("FusionCoil")
end)

-- 6. 获得胜利值
local winButton = createButton("6. 获得胜值 (Win)", 0.85)
winButton.MouseButton1Click:Connect(function()
    sendAwardCommand("Win")
end)

-- ========== 折叠功能 (已修复) ==========
-- 控制内容区域的展开与折叠 (已将高度调整为150以容纳6个按钮)
local isExpanded = false
foldButton.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    if isExpanded then
        foldButton.Text = "▲"
        -- 修改高度为150
        TweenService:Create(contentFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 150)}):Play()
    else
        foldButton.Text = "▼"
        TweenService:Create(contentFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
    end
end)

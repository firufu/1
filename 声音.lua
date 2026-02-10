-- 脚本名称：奥比跑酷工具界面
-- 作者：firufu
-- 功能：提供生命值、跳关、铲子获取功能

-- 创建屏幕GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ObbyToolsGUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- 创建主框架
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(200, 200, 200)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- 创建标题
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
TitleLabel.Text = "奥比跑酷工具"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 24
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = MainFrame

-- 创建关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "X"
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = TitleLabel

-- 创建功能按钮容器
local ButtonsContainer = Instance.new("Frame")
ButtonsContainer.Name = "ButtonsContainer"
ButtonsContainer.Size = UDim2.new(0.9, 0, 0.7, 0)
ButtonsContainer.Position = UDim2.new(0.05, 0, 0.15, 0)
ButtonsContainer.BackgroundTransparency = 1
ButtonsContainer.Parent = MainFrame

-- 创建按钮间距
local buttonHeight = 80
local buttonSpacing = 15

-- 函数：发送命令到服务器
local function sendCommand(commandType)
    local args = {
        "Award",
        commandType
    }
    
    local success, errorMsg = pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Send"):InvokeServer(unpack(args))
    end)
    
    if not success then
        warn("发送命令失败: " .. errorMsg)
    end
end

-- 1. 创建获得生命值按钮
local LifeButton = Instance.new("TextButton")
LifeButton.Name = "LifeButton"
LifeButton.Size = UDim2.new(1, 0, 0, buttonHeight)
LifeButton.Position = UDim2.new(0, 0, 0, 0)
LifeButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
LifeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LifeButton.Text = "获得生命值"
LifeButton.TextSize = 20
LifeButton.Font = Enum.Font.SourceSansBold
LifeButton.Parent = ButtonsContainer

-- 生命值按钮图标
local LifeIcon = Instance.new("ImageLabel")
LifeIcon.Name = "LifeIcon"
LifeIcon.Size = UDim2.new(0, 30, 0, 30)
LifeIcon.Position = UDim2.new(0.1, 0, 0.5, -15)
LifeIcon.BackgroundTransparency = 1
LifeIcon.Image = "rbxassetid://9751990722" -- 心形图标（可替换）
LifeIcon.Parent = LifeButton

-- 2. 创建跳过关卡按钮
local SkipButton = Instance.new("TextButton")
SkipButton.Name = "SkipButton"
SkipButton.Size = UDim2.new(1, 0, 0, buttonHeight)
SkipButton.Position = UDim2.new(0, 0, 0, buttonHeight + buttonSpacing)
SkipButton.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
SkipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SkipButton.Text = "跳过一个关卡"
SkipButton.TextSize = 20
SkipButton.Font = Enum.Font.SourceSansBold
SkipButton.Parent = ButtonsContainer

-- 跳关按钮图标
local SkipIcon = Instance.new("ImageLabel")
SkipIcon.Name = "SkipIcon"
SkipIcon.Size = UDim2.new(0, 30, 0, 30)
SkipIcon.Position = UDim2.new(0.1, 0, 0.5, -15)
SkipIcon.BackgroundTransparency = 1
SkipIcon.Image = "rbxassetid://9752000267" -- 跳跃图标（可替换）
SkipIcon.Parent = SkipButton

-- 3. 创建获得铲子按钮
local TrowelButton = Instance.new("TextButton")
TrowelButton.Name = "TrowelButton"
TrowelButton.Size = UDim2.new(1, 0, 0, buttonHeight)
TrowelButton.Position = UDim2.new(0, 0, 0, (buttonHeight + buttonSpacing) * 2)
TrowelButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
TrowelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TrowelButton.Text = "获得铲子"
TrowelButton.TextSize = 20
TrowelButton.Font = Enum.Font.SourceSansBold
TrowelButton.Parent = ButtonsContainer

-- 铲子按钮图标
local TrowelIcon = Instance.new("ImageLabel")
TrowelIcon.Name = "TrowelIcon"
TrowelIcon.Size = UDim2.new(0, 30, 0, 30)
TrowelIcon.Position = UDim2.new(0.1, 0, 0.5, -15)
TrowelIcon.BackgroundTransparency = 1
TrowelIcon.Image = "rbxassetid://9752012345" -- 工具图标（可替换）
TrowelIcon.Parent = TrowelButton

-- 创建状态标签
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0.9, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "选择功能开始使用"
StatusLabel.TextColor3 = Color3.fromRGB(50, 50, 50)
StatusLabel.TextSize = 16
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.Parent = MainFrame

-- 按钮点击事件处理
LifeButton.MouseButton1Click:Connect(function()
    sendCommand("1Life")
    StatusLabel.Text = "已发送：获得生命值"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 150, 0)
    
    -- 按钮点击反馈
    LifeButton.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
    wait(0.1)
    LifeButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
end)

SkipButton.MouseButton1Click:Connect(function()
    sendCommand("Skip")
    StatusLabel.Text = "已发送：跳过关卡"
    StatusLabel.TextColor3 = Color3.fromRGB(200, 120, 0)
    
    -- 按钮点击反馈
    SkipButton.BackgroundColor3 = Color3.fromRGB(235, 160, 0)
    wait(0.1)
    SkipButton.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
end)

TrowelButton.MouseButton1Click:Connect(function()
    sendCommand("Trowel")
    StatusLabel.Text = "已发送：获得铲子"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 100, 200)
    
    -- 按钮点击反馈
    TrowelButton.BackgroundColor3 = Color3.fromRGB(0, 130, 230)
    wait(0.1)
    TrowelButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
end)

-- 关闭按钮事件
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 创建显示/隐藏快捷键（可选）
local UserInputService = game:GetService("UserInputService")
local isVisible = true

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightControl then -- 右Ctrl键切换显示
        isVisible = not isVisible
        ScreenGui.Enabled = isVisible
    end
end)

-- 初始化完成提示
print("奥比跑酷工具已加载！")
print("使用方法：")
print("1. 点击按钮获取相应功能")
print("2. 拖动标题栏移动窗口")
print("3. 点击X关闭窗口")
print("4. 按右Ctrl键切换显示/隐藏")
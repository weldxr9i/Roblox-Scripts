if not game:IsLoaded() then game.Loaded:Wait() end
local Players, CoreGui, TweenService = game:GetService("Players"), game:GetService("CoreGui"), game:GetService("TweenService")
if CoreGui:FindFirstChild("WG_Premium_Tracker") then CoreGui["WG_Premium_Tracker"]:Destroy() end

local ServerDatabase, UIEntries = {}, {}
local function FormatTime(s)
    return string.format("%02d:%02d:%02d", math.floor(s/3600), math.floor((s%3600)/60), s%60)
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "WG_Premium_Tracker"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size, MainFrame.Position = UDim2.new(0, 460, 0, 420), UDim2.new(0.15, 0, 0.2, 0)
MainFrame.BackgroundTransparency = 1 
MainFrame.Active, MainFrame.Draggable = true, true

-- الصورة الخلفية للسكربت
local BackgroundImage = Instance.new("ImageLabel", MainFrame)
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://120125603923365"
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 0
Instance.new("UICorner", BackgroundImage).CornerRadius = UDim.new(0, 10)

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Header = Instance.new("Frame", MainFrame)
Header.Size, Header.BackgroundTransparency, Header.ZIndex = UDim2.new(1, 0, 0, 45), 1, 2

-- تعديل النص ليكون أبيض ساطع كقاعدة أساسية قبل التدرج
local Title = Instance.new("TextLabel", Header)
Title.Size, Title.Position, Title.Text = UDim2.new(0, 380, 1, 0), UDim2.new(0, 20, 0, 0), "WG ON TOP tracker"
Title.TextColor3 = Color3.fromRGB(255, 255, 255) 
Title.TextSize, Title.Font, Title.TextXAlignment, Title.BackgroundTransparency, Title.ZIndex = 18, Enum.Font.SourceSansBold, Enum.TextXAlignment.Left, 1, 3
Title.TextStrokeTransparency = 0.1 
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- التدرج النيوني الساطع
local TitleGradient = Instance.new("UIGradient", Title)
local BrightNeonPurple = Color3.fromRGB(160, 0, 255) 
local PureWhite = Color3.fromRGB(255, 255, 255)

TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, BrightNeonPurple), 
    ColorSequenceKeypoint.new(0.5, PureWhite),       
    ColorSequenceKeypoint.new(1, BrightNeonPurple)  
})

-- محرك تحريك حركة النيون الانسيابية
task.spawn(function()
    local offset = 0
    while task.wait(0.01) and ScreenGui.Parent do
        offset = (offset + 0.015) % 2
        TitleGradient.Offset = Vector2.new(-1 + offset, 0)
    end
end)

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size, CloseBtn.Position, CloseBtn.Text = UDim2.new(0, 30, 0, 30), UDim2.new(1, -40, 0, 7), "X"
CloseBtn.TextColor3, CloseBtn.BackgroundTransparency, CloseBtn.Font, CloseBtn.TextSize, CloseBtn.ZIndex = Color3.fromRGB(180, 180, 180), 1, Enum.Font.GothamBold, 16, 3
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Divider = Instance.new("Frame", MainFrame)
Divider.Size, Divider.Position, Divider.BackgroundColor3, Divider.BorderSizePixel, Divider.ZIndex = UDim2.new(1, -40, 0, 1), UDim2.new(0, 20, 0, 45), Color3.fromRGB(50, 50, 50), 0, 2

local SearchBox = Instance.new("TextBox", MainFrame)
SearchBox.Size, SearchBox.Position, SearchBox.BackgroundColor3, SearchBox.Text, SearchBox.PlaceholderText = UDim2.new(1, -40, 0, 32), UDim2.new(0, 20, 0, 55), Color3.fromRGB(22, 22, 22), "", "Search player username..."
SearchBox.TextColor3, SearchBox.PlaceholderColor3, SearchBox.Font, SearchBox.TextSize, SearchBox.TextXAlignment, SearchBox.ClearTextOnFocus, SearchBox.ZIndex = Color3.fromRGB(235, 235, 235), Color3.fromRGB(120, 120, 120), Enum.Font.GothamSemibold, 12, Enum.TextXAlignment.Left, false, 2
Instance.new("UIPadding", SearchBox).PaddingLeft = UDim.new(0, 12)
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 6)

local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size, ScrollFrame.Position, ScrollFrame.BackgroundTransparency, ScrollFrame.ZIndex = UDim2.new(1, -40, 0, 290), UDim2.new(0, 20, 0, 105), 1, 2
ScrollFrame.ScrollBarThickness, ScrollFrame.ScrollBarImageColor3, ScrollFrame.ScrollingDirection, ScrollFrame.AutomaticCanvasSize = 5, BrightNeonPurple, Enum.ScrollingDirection.Y, Enum.AutomaticSize.Y

local UIList = Instance.new("UIListLayout", ScrollFrame)
UIList.Padding = UDim.new(0, 8)

local function CreatePlayerRow(username, userId)
    if UIEntries[username] then return end
    local Row = Instance.new("Frame", ScrollFrame)
    Row.Size, Row.BackgroundColor3, Row.BorderSizePixel, Row.ZIndex = UDim2.new(1, -10, 0, 50), Color3.fromRGB(22, 22, 22), 0, 2
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)

    local Img = Instance.new("ImageLabel", Row)
    Img.Size, Img.Position, Img.BackgroundTransparency, Img.Image, Img.ZIndex = UDim2.new(0, 36, 0, 36), UDim2.new(0, 8, 0, 7), 1, "rbxassetid://0", 3
    Instance.new("UICorner", Img).CornerRadius = UDim.new(1, 0)
    task.spawn(pcall, function() Img.Image = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48) end)

    local Name = Instance.new("TextLabel", Row)
    Name.Size, Name.Position, Name.Text, Name.TextColor3, Name.Font, Name.TextSize, Name.TextXAlignment, Name.BackgroundTransparency, Name.ZIndex = UDim2.new(0, 220, 0, 20), UDim2.new(0, 55, 0, 6), username, Color3.fromRGB(235, 235, 235), Enum.Font.GothamBold, 13, Enum.TextXAlignment.Left, 1, 3

    local Stats = Instance.new("TextLabel", Row)
    Stats.Size, Stats.Position, Stats.TextColor3, Stats.Font, Stats.TextSize, Stats.TextXAlignment, Stats.BackgroundTransparency, Stats.ZIndex = UDim2.new(1, -115, 0, 18), UDim2.new(0, 55, 0, 24), Color3.fromRGB(160, 160, 160), Enum.Font.GothamSemibold, 11, Enum.TextXAlignment.Left, 1, 3

    local Toggle = Instance.new("TextButton", Row)
    Toggle.Size, Toggle.Position, Toggle.Text, Toggle.TextSize, Toggle.BackgroundColor3, Toggle.TextColor3, Toggle.Font, Toggle.ZIndex = UDim2.new(0, 45, 0, 24), UDim2.new(1, -65, 0, 13), "ON", 11, Color3.fromRGB(20, 40, 25), Color3.fromRGB(100, 255, 100), Enum.Font.GothamBold, 3
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 4)
    Toggle.MouseButton1Click:Connect(function()
        local d = ServerDatabase[username]
        if d then
            d.TrackingDisabled = not d.TrackingDisabled
            Toggle.Text = d.TrackingDisabled and "OFF" or "ON"
            Toggle.BackgroundColor3 = d.TrackingDisabled and Color3.fromRGB(40, 20, 20) or Color3.fromRGB(20, 40, 25)
            Toggle.TextColor3 = d.TrackingDisabled and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(100, 255, 100)
            
            if d.TrackingDisabled then 
                if d.IsPresent then
                    d.PastSeconds = d.PastSeconds + (os.time() - d.TimeJoined) 
                end
                Stats.Text = "TRACKING DISABLED" 
            else 
                if d.IsPresent then
                    d.TimeJoined = os.time() 
                else
                    Stats.Text = string.format("hariba stute: %d | l9wad hrb: %d | status: %s | %s", d.JoinsCount, d.LeavesCount, d.Status, FormatTime(d.PastSeconds))
                end
            end
        end
    end)

    local Ind = Instance.new("Frame", Row)
    Ind.Size, Ind.Position, Ind.BackgroundColor3, Ind.BorderSizePixel, Ind.ZIndex = UDim2.new(0, 3, 1, -16), UDim2.new(1, -10, 0, 8), Color3.fromRGB(0, 200, 100), 0, 3
    Instance.new("UICorner", Ind).CornerRadius = UDim.new(1, 0)
    UIEntries[username] = {Frame = Row, TextLabel = Stats, Indicator = Ind}
end

local function Setup(p, isNew)
    if not p then return end
    local d = ServerDatabase[p.Name]
    ServerDatabase[p.Name] = {UserId = p.UserId, TimeJoined = os.time(), PastSeconds = d and d.PastSeconds or 0, JoinsCount = d and (d.JoinsCount+1) or 1, LeavesCount = d and d.LeavesCount or 0, IsPresent = true, Status = isNew and "rj3" or "active", TrackingDisabled = d and d.TrackingDisabled or false}
    CreatePlayerRow(p.Name, p.UserId)
    if isNew then task.spawn(function() task.wait(3) local cur = ServerDatabase[p.Name] if cur and cur.IsPresent and not cur.TrackingDisabled then cur.Status = "active" end end) end
end

for _, p in pairs(Players:GetPlayers()) do Setup(p, false) end
Players.PlayerAdded:Connect(function(p) Setup(p, true) end)

Players.PlayerRemoving:Connect(function(p)
    local d, ui = ServerDatabase[p.Name], UIEntries[p.Name]
    if d and d.IsPresent then
        d.IsPresent = false
        if d.TrackingDisabled then return end
        d.PastSeconds = d.PastSeconds + (os.time() - d.TimeJoined)
        d.LeavesCount, d.Status = d.LeavesCount + 1, "w333 hrb"
        if ui then ui.Indicator.BackgroundColor3 = Color3.fromRGB(255, 40, 40) ui.TextLabel.Text = string.format("hariba stute: %d | l9wad hrb: %d | status: %s | %s", d.JoinsCount, d.LeavesCount, d.Status, FormatTime(d.PastSeconds)) end
    end
end)

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    for name, ui in pairs(UIEntries) do ui.Frame.Visible = string.find(string.lower(name), string.lower(SearchBox.Text)) ~= nil end
end)

task.spawn(function()
    while task.wait(1) and ScreenGui.Parent do
        for name, d in pairs(ServerDatabase) do
            local ui = UIEntries[name]
            if ui and d.IsPresent and not d.TrackingDisabled then
                ui.TextLabel.Text = string.format("hariba stute: %d | l9wad hrb: %d | status: %s | %s", d.JoinsCount, d.LeavesCount, d.Status, FormatTime(d.PastSeconds + (os.time() - d.TimeJoined)))
                ui.Indicator.BackgroundColor3 = d.Status == "rj3" and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(0, 200, 100)
            end
        end
    end
end)

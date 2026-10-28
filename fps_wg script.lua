if not game:IsLoaded() then game.Loaded:Wait() end
local Players, CoreGui, TweenService, RunService, Workspace = game:GetService("Players"), game:GetService("CoreGui"), game:GetService("TweenService"), game:GetService("RunService"), game:GetService("Workspace")

if CoreGui:FindFirstChild("WG_LowLag_Hub") then CoreGui["WG_LowLag_Hub"]:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "WG_LowLag_Hub"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size, MainFrame.Position = UDim2.new(0, 360, 0, 340), UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundTransparency = 1
MainFrame.Active, MainFrame.Draggable = true, true

-- وضع الصورة المخصصة كخلفية بديلة وحيدة للـ GUI بالكامل
local BackgroundImage = Instance.new("ImageLabel", MainFrame)
BackgroundImage.Name = "GUI_Background_Image"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.Image = "rbxassetid://125086374911002"
BackgroundImage.ImageTransparency = 0
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 0

-- بناء التصميم القوطي الحقيقي (Gothic Bracket Design) باستخدام خطوط حادة في الزوايا
local function CreateGothicLine(pos, size, color)
    local line = Instance.new("Frame", MainFrame)
    line.Position = pos
    line.Size = size
    line.BackgroundColor3 = color
    line.BorderSizePixel = 0
    line.ZIndex = 3
    return line
end

-- الألوان القوطية الغامقة المتناسقة (رمادي حديدي غامق)
local GothicColor = Color3.fromRGB(45, 45, 45)
local GothicDark = Color3.fromRGB(20, 20, 20)

-- الزاوية العلوية اليسرى
CreateGothicLine(UDim2.new(0, -2, 0, -2), UDim2.new(0, 20, 0, 3), GothicColor)
CreateGothicLine(UDim2.new(0, -2, 0, -2), UDim2.new(0, 3, 0, 20), GothicColor)

-- الزاوية العلوية اليمنى
CreateGothicLine(UDim2.new(1, -18, 0, -2), UDim2.new(0, 20, 0, 3), GothicColor)
CreateGothicLine(UDim2.new(1, -1, 0, -2), UDim2.new(0, 3, 0, 20), GothicColor)

-- الزاوية السفلية اليسرى
CreateGothicLine(UDim2.new(0, -2, 1, -1), UDim2.new(0, 20, 0, 3), GothicColor)
CreateGothicLine(UDim2.new(0, -2, 1, -18), UDim2.new(0, 3, 0, 20), GothicColor)

-- الزاوية السفلية اليمنى
CreateGothicLine(UDim2.new(1, -18, 1, -1), UDim2.new(0, 20, 0, 3), GothicColor)
CreateGothicLine(UDim2.new(1, -1, 1, -18), UDim2.new(0, 3, 0, 20), GothicColor)

-- إطار خارجي دقيق جداً كخلفية حادة
local SharpOutline = Instance.new("UIStroke", MainFrame)
SharpOutline.Color = GothicDark
SharpOutline.Thickness = 1
SharpOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local Header = Instance.new("Frame", MainFrame)
Header.Size, Header.BackgroundTransparency = UDim2.new(1, 0, 0, 40), 1
Header.ZIndex = 2

local Title = Instance.new("TextLabel", Header)
Title.Size, Title.Position, Title.Text = UDim2.new(1, -40, 0, 20), UDim2.new(0, 15, 0, 5), "WAR GODS // ENGINE"
Title.TextColor3, Title.TextSize, Title.Font, Title.TextXAlignment, Title.BackgroundTransparency = Color3.fromRGB(160, 32, 240), 13, Enum.Font.GothamBold, Enum.TextXAlignment.Left, 1
Title.ZIndex = 2

task.spawn(function()
    while task.wait(0.5) and ScreenGui.Parent do
        TweenService:Create(Title, TweenInfo.new(0.4), {TextColor3 = Color3.fromRGB(60, 10, 100)}):Play()
        task.wait(0.5)
        TweenService:Create(Title, TweenInfo.new(0.4), {TextColor3 = Color3.fromRGB(200, 50, 255)}):Play()
    end
end)

local Subtitle = Instance.new("TextLabel", Header)
Subtitle.Size, Subtitle.Position, Subtitle.Text = UDim2.new(1, -40, 0, 15), UDim2.new(0, 15, 0, 22), "by kai"
Subtitle.TextColor3, Subtitle.TextSize, Subtitle.Font, Subtitle.TextXAlignment, Subtitle.BackgroundTransparency = Color3.fromRGB(150, 150, 150), 10, Enum.Font.GothamSemibold, Enum.TextXAlignment.Left, 1
Subtitle.ZIndex = 2

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size, CloseBtn.Position, CloseBtn.Text = UDim2.new(0, 30, 0, 30), UDim2.new(1, -35, 0, 5), "X"
CloseBtn.TextColor3, CloseBtn.BackgroundTransparency, CloseBtn.Font, CloseBtn.TextSize = Color3.fromRGB(150, 150, 150), 1, Enum.Font.GothamBold, 14
CloseBtn.ZIndex = 2
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local FPSLabel = Instance.new("TextLabel", MainFrame)
FPSLabel.Size, FPSLabel.Position = UDim2.new(1, -30, 0, 25), UDim2.new(0, 15, 0, 40)
FPSLabel.BackgroundTransparency = 1
FPSLabel.TextColor3, FPSLabel.TextSize, FPSLabel.Font, FPSLabel.TextXAlignment = Color3.fromRGB(200, 200, 200), 11, Enum.Font.GothamBold, Enum.TextXAlignment.Left
FPSLabel.ZIndex = 2

task.spawn(function()
    local lastUpdate = os.clock()
    local frameCount = 0
    
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local now = os.clock()
        local delta = now - lastUpdate
        
        if delta >= 1.0 then
            local cur = math.round(frameCount / delta)
            frameCount = 0
            lastUpdate = now
            
            local txt, col = "[MODERATE]", "rgb(255,200,0)"
            if cur >= 55 then txt, col = "[EXCELLENT]", "rgb(100,255,100)"
            elseif cur < 30 then txt, col = "[LAGGING]", "rgb(255,80,80)" end
            
            FPSLabel.Text = string.format("FPS: %d | Status: <font color='%s'>%s</font>", cur, col, txt)
            FPSLabel.RichText = true
        end
    end)
end)

-- فاصل حاد مخصص للتصميم القوطي الـ Grunge
local Divider = Instance.new("Frame", MainFrame)
Divider.Size, Divider.Position, Divider.BackgroundColor3, Divider.BorderSizePixel = UDim2.new(1, -30, 0, 1), UDim2.new(0, 15, 0, 70), Color3.fromRGB(45, 45, 45), 0
Divider.ZIndex = 2

local ContentFrame = Instance.new("ScrollingFrame", MainFrame)
ContentFrame.Size, ContentFrame.Position, ContentFrame.BackgroundTransparency = UDim2.new(1, -20, 1, -85), UDim2.new(0, 10, 0, 75), 1
ContentFrame.CanvasSize, ContentFrame.ScrollBarThickness, ContentFrame.ScrollBarImageColor3 = UDim2.new(0, 0, 0, 420), 2, Color3.fromRGB(45, 45, 45)
ContentFrame.ZIndex = 2

local UIList = Instance.new("UIListLayout", ContentFrame)
UIList.Padding, UIList.SortOrder = UDim.new(0, 6), Enum.SortOrder.LayoutOrder

local Config = {PurgeAvatars = false, FreezeWeather = false, AntiExplosions = false, BaseplateOnly = false, UltimateBoost = false, ClearEffects = false, AntiSit = false, AntiFling = false}

local function CreateToggle(text, order, callback)
    local Row = Instance.new("Frame", ContentFrame)
    Row.Size, Row.BackgroundColor3, Row.LayoutOrder = UDim2.new(1, -10, 0, 38), Color3.fromRGB(15, 15, 15), order
    Row.BackgroundTransparency = 0.4
    Row.ZIndex = 2
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 4) -- حواف حادة وأكثر استقامة لتتناسب مع الطابع القوطي الهندسي
    
    local RowStroke = Instance.new("UIStroke", Row)
    RowStroke.Color = Color3.fromRGB(35, 35, 35)
    RowStroke.Thickness = 1
    RowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    local Label = Instance.new("TextLabel", Row)
    Label.Size, Label.Position, Label.Text = UDim2.new(1, -70, 1, 0), UDim2.new(0, 12, 0, 0), text
    Label.TextColor3, Label.TextSize, Label.Font, Label.TextXAlignment, Label.BackgroundTransparency = Color3.fromRGB(200, 200, 200), 11, Enum.Font.GothamSemibold, Enum.TextXAlignment.Left, 1
    Label.ZIndex = 2
    
    local Btn = Instance.new("TextButton", Row)
    Btn.Size, Btn.Position, Btn.Text, Btn.TextSize, Btn.Font = UDim2.new(0, 50, 0, 22), UDim2.new(1, -62, 0, 8), "OFF", 10, Enum.Font.GothamBold
    Btn.BackgroundColor3, Btn.TextColor3 = Color3.fromRGB(30, 20, 20), Color3.fromRGB(180, 70, 70)
    Btn.ZIndex = 2
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    
    local active = false
    Btn.MouseButton1Click:Connect(function()
        active = not active
        Btn.Text = active and "ON" or "OFF"
        Btn.BackgroundColor3 = active and Color3.fromRGB(20, 35, 25) or Color3.fromRGB(30, 20, 20)
        Btn.TextColor3 = active and Color3.fromRGB(80, 200, 100) or Color3.fromRGB(180, 70, 70)
        callback(active)
    end)
end

local function StripCharacter(char)
    if not char or not Config.PurgeAvatars or Players:GetPlayerFromCharacter(char) == Players.LocalPlayer then return end
    task.wait(0.1)
    for _, obj in pairs(char:GetDescendants()) do
        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") or obj:IsA("CharacterMesh") or obj:IsA("BodyColors") then pcall(function() obj:Destroy() end)
        elseif obj:IsA("BasePart") then obj.Material, obj.CastShadow, obj.Reflectance = Enum.Material.SmoothPlastic, false, 0 end
        if obj:IsA("Animator") or obj:IsA("AnimationTrack") then pcall(function() obj:Stop() end) end
    end
    if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.All end
end

CreateToggle("Invisible Identity Purge (Names Only)", 1, function(state)
    Config.PurgeAvatars = state
    if state then for _, p in pairs(Players:GetPlayers()) do if p.Character then task.spawn(StripCharacter, p.Character) end end end
end)
Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(char) if Config.PurgeAvatars then task.spawn(StripCharacter, char) end end) end)

RunService.RenderStepped:Connect(function()
    if Config.FreezeWeather then
        local Lighting = game:GetService("Lighting")
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = false
        Lighting.ShadowSoftness = 0
        Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Lighting.FogEnd = 999999
    end
end)

local function ExtremeSkyClean()
    local targets = {game:GetService("Lighting"), Workspace}
    if Workspace.CurrentCamera then table.insert(targets, Workspace.CurrentCamera) end
    for _, container in pairs(targets) do
        for _, obj in pairs(container:GetChildren()) do
if obj:IsA("Atmosphere") or obj:IsA("Sky") or obj:IsA("Clouds") or obj:IsA("BlurEffect") or obj:IsA("SunRaysEffect") or obj:IsA("BloomEffect") then
pcall(function() obj:Destroy() end)
end
end
end
end
CreateToggle("Lock Server Time (12 PM) & Weather", 2, function(state)
Config.FreezeWeather = state
if state then ExtremeSkyClean() end
end)
local function OptimizeWorldObject(obj)
if not obj then return end
if obj:IsA("Explosion") and Config.AntiExplosions then
obj.BlastPressure, obj.BlastRadius = 0, 0
for _, p in pairs(obj:GetChildren()) do if p:IsA("ParticleEmitter") or p:IsA("Fire") or p:IsA("Smoke") then p:Destroy() end end
elseif Config.AntiExplosions and (obj:IsA("Decal") or obj:IsA("Texture")) then
pcall(function() obj:Destroy() end)
elseif Config.AntiExplosions and (obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Sparkles")) then
obj.Enabled = false
end
if Config.UltimateBoost and obj:IsA("BasePart") and not Players:GetPlayerFromCharacter(obj.Parent) then
obj.Material = Enum.Material.SmoothPlastic
obj.CastShadow = false
obj.Reflectance = 0
end
if Config.ClearEffects then
if obj:IsA("ParticleEmitter") or obj:IsA("Sparkles") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
obj.Enabled = false
elseif obj:IsA("Light") then
obj.Enabled = false
obj.Shadows = false
end
end
end
Workspace.DescendantAdded:Connect(function(item)
pcall(OptimizeWorldObject, item)
end)
CreateToggle("Anti-Explosion Shield & Texture", 3, function(state)
Config.AntiExplosions = state
if state then
task.spawn(function()
for _, item in pairs(Workspace:GetDescendants()) do
pcall(OptimizeWorldObject, item)
if #Workspace:GetDescendants() % 200 == 0 then task.wait() end
end
end)
end
end)
local function PurgeMapToBaseplate()
if not Config.BaseplateOnly then return end
for _, item in pairs(Workspace:GetChildren()) do
if item ~= Workspace.CurrentCamera and not Players:GetPlayerFromCharacter(item) and item.Name ~= "Baseplate" then
pcall(function() item:Destroy() end)
end
end
end
CreateToggle("Baseplate Only (Purge Map)", 4, function(state)
Config.BaseplateOnly = state
if state then PurgeMapToBaseplate() end
end)
Workspace.ChildAdded:Connect(function() if Config.BaseplateOnly then PurgeMapToBaseplate() end end)
CreateToggle("Ultimate FPS Boost (Smooth Plastic)", 5, function(state)
Config.UltimateBoost = state
if state then
task.spawn(function()
for _, item in pairs(Workspace:GetDescendants()) do
pcall(OptimizeWorldObject, item)
if #Workspace:GetDescendants() % 200 == 0 then task.wait() end
end
end)
end
end)
CreateToggle("Clear Map Effects & Debris", 6, function(state)
Config.ClearEffects = state
if state then
task.spawn(function()
for _, item in pairs(Workspace:GetDescendants()) do
pcall(OptimizeWorldObject, item)
if #Workspace:GetDescendants() % 200 == 0 then task.wait() end
end
end)
end
end)
local function ApplyAntiSit(char)
local hum = char:WaitForChild("Humanoid", 5)
if not hum then return end
hum:SetStateEnabled(Enum.HumanoidStateType.Seated, not Config.AntiSit)
if Config.AntiSit and hum.Sit then
hum.Sit = false
end
end
CreateToggle("Anti-Sit (No Shake / No-Clip Seats)", 7, function(state)
Config.AntiSit = state
local char = Players.LocalPlayer.Character
if char then ApplyAntiSit(char) end
end)
CreateToggle("Anti-Fling Shield", 8, function(state)
Config.AntiFling = state
end)
Players.LocalPlayer.CharacterAdded:Connect(function(char)
if Config.AntiSit then task.spawn(ApplyAntiSit, char) end
end)
RunService.Heartbeat:Connect(function()
local char = Players.LocalPlayer.Character
if not char then return end
local hum = char:FindFirstChildOfClass("Humanoid")
local root = char:FindFirstChild("HumanoidRootPart")
if Config.AntiSit and hum then
if hum.Sit then hum.Sit = false end
hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
end
if Config.AntiFling and root then
root.Velocity = Vector3.new(root.Velocity.X, math.clamp(root.Velocity.Y, -100, 100), root.Velocity.Z)
root.RotVelocity = Vector3.new(0, 0, 0)
end
end)
task.spawn(function()
while task.wait(5) do
if Config.FreezeWeather then pcall(ExtremeSkyClean) end
end
end)

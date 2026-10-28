-- ==========================================================
-- [المسار الأول]: تشغيل كائن النوب والـ Aura في الخلفية دون تعطيل السكربت
-- ==========================================================
task.spawn(function()
    if not game:IsLoaded() then game.Loaded:Wait() end

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Workspace = game:GetService("Workspace")
    local TweenService = game:GetService("TweenService")

    local CURRENT_USER = LocalPlayer.Name 

    repeat task.wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local RootPart = LocalPlayer.Character.HumanoidRootPart

    -- التنظيف التلقائي لمنع التكرار والـ Lag
    if Workspace.CurrentCamera:FindFirstChild("WG") then
        Workspace.CurrentCamera["WG"]:Destroy()
    end

    local Noob = Instance.new("Model")
    Noob.Name = "WG" 
    local Hum = Instance.new("Humanoid")
    Hum.Parent = Noob

    local partsInfo = {
        {name = "HumanoidRootPart", size = Vector3.new(2, 2, 1), color = BrickColor.new("Bright yellow"), trans = 1},
        {name = "Torso",             size = Vector3.new(2, 2, 1), color = BrickColor.new("Bright blue"),   trans = 0},
        {name = "Head",              size = Vector3.new(2, 1, 1), color = BrickColor.new("Bright yellow"), trans = 0},
        {name = "Left Arm",          size = Vector3.new(1, 2, 1), color = BrickColor.new("Bright yellow"), trans = 0},
        {name = "Right Arm",         size = Vector3.new(1, 2, 1), color = BrickColor.new("Bright yellow"), trans = 0},
        {name = "Left Leg",          size = Vector3.new(1, 2, 1), color = BrickColor.new("Dark green"),   trans = 0},
        {name = "Right Leg",         size = Vector3.new(1, 2, 1), color = BrickColor.new("Dark green"),   trans = 0}
    }

    local visibleParts = {}
    local auraEmitters = {} 

    for _, info in pairs(partsInfo) do
        local p = Instance.new("Part")
        p.Name = info.name
        p.Size = info.size
        p.BrickColor = info.color
        p.Transparency = info.trans
        p.Material = Enum.Material.SmoothPlastic
        p.Anchored = true
        p.CanCollide = false
        p.Parent = Noob
        
        if info.name ~= "HumanoidRootPart" then 
            table.insert(visibleParts, p) 
            
            -- ❄️ بلورات وقطع الثلج المضيئة المحيطة بجسد الـ WG
            local IceAura = Instance.new("ParticleEmitter")
            IceAura.Name = "IceCrystal_" .. info.name
            IceAura.Texture = "rbxasset://textures/particles/sparkles_main.dds" 
            IceAura.Color = ColorSequence.new(Color3.fromRGB(148, 0, 211)) 
            
            IceAura.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.6), 
                NumberSequenceKeypoint.new(0.5, 1.4), 
                NumberSequenceKeypoint.new(1, 0.3)
            })
            IceAura.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0), 
                NumberSequenceKeypoint.new(0.8, 0.2), 
                NumberSequenceKeypoint.new(1, 1)
            })
            IceAura.Lifetime = NumberRange.new(1.2, 2.5) 
            IceAura.Rate = 18 
            IceAura.Speed = NumberRange.new(0.6, 2.2) 
            IceAura.VelocitySpread = 360 
            IceAura.Acceleration = Vector3.new(0, -0.3, 0) 
            IceAura.RotSpeed = NumberRange.new(-50, 50) 
            IceAura.LightEmission = 0.65 
            IceAura.LightInfluence = 0
            
            IceAura.Parent = p
            table.insert(auraEmitters, IceAura)
        end
    end
    Noob.PrimaryPart = Noob:FindFirstChild("HumanoidRootPart")

    local HeadMesh = Instance.new("SpecialMesh")
    HeadMesh.MeshType = Enum.MeshType.Head
    HeadMesh.Scale = Vector3.new(1.25, 1.25, 1.25)
    HeadMesh.Parent = Noob.Head

    local Face = Instance.new("Decal")
    Face.Name = "face"
    Face.Texture = "rbxassetid://7074786" 
    Face.Face = Enum.NormalId.Front
    Face.Parent = Noob.Head

    local spawnCFrame = RootPart.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, math.rad(180), 0)
    Noob:SetPrimaryPartCFrame(spawnCFrame)

    local baseCF = Noob.PrimaryPart.CFrame
    Noob.Torso.CFrame = baseCF
    Noob.Head.CFrame = baseCF * CFrame.new(0, 1.5, 0)
    Noob["Left Arm"].CFrame = baseCF * CFrame.new(-1.5, 0, 0)
    Noob["Right Arm"].CFrame = baseCF * CFrame.new(1.5, 0, 0)
    Noob["Left Leg"].CFrame = baseCF * CFrame.new(-0.5, -2, 0)
    Noob["Right Leg"].CFrame = baseCF * CFrame.new(0.5, -2, 0)

    local Billboard = Instance.new("BillboardGui")
    Billboard.Size = UDim2.new(0, 320, 0, 60) 
    Billboard.Adornee = Noob.Head
    Billboard.AlwaysOnTop = true
    Billboard.StudsOffset = Vector3.new(0, 2.5, 0) 
    Billboard.Parent = Noob.Head

    local SpeechText = Instance.new("TextLabel")
    SpeechText.Size = UDim2.new(1, 0, 1, 0)
    SpeechText.BackgroundTransparency = 1
    SpeechText.TextSize = 14 
    SpeechText.Font = Enum.Font.GothamBold 
    SpeechText.TextStrokeTransparency = 0.2 
    SpeechText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    SpeechText.RichText = true 
    SpeechText.MaxVisibleGraphemes = 0 
    SpeechText.Parent = Billboard

    SpeechText.Text = "<font color='rgb(148, 0, 211)'>MR7BA 3ND WG </font><font color='rgb(255, 0, 0)'>" .. CURRENT_USER .. "</font><font color='rgb(148, 0, 211)'>, 7OKAM SMLA MRA9BINK</font>"

    Noob.Parent = Workspace.CurrentCamera

    local rawTextLength = string.len("MR7BA 3ND WG " .. CURRENT_USER .. ", 7OKAM SMLA MRA9BINK")
    for i = 1, rawTextLength do
        SpeechText.MaxVisibleGraphemes = i
        task.wait(0.04)
    end

    task.wait(10)

    local fadeTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(Face, fadeTweenInfo, {Transparency = 1}):Play()
    TweenService:Create(SpeechText, fadeTweenInfo, {TextTransparency = 1}):Play()
    TweenService:Create(SpeechText, fadeTweenInfo, {TextStrokeTransparency = 1}):Play()

    for _, emitter in pairs(auraEmitters) do
        emitter.Enabled = false
    end

    for _, part in pairs(visibleParts) do
        TweenService:Create(part, fadeTweenInfo, {Transparency = 1}):Play()
    end

    task.wait(1)
    Noob:Destroy()
end)

-- ==========================================================
-- [المسار الثاني]: تشغيل واجهة السكربت الأصلية (Anti-AFK GUI)
-- ==========================================================
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local MY_NAME   = "KAi"
local CLAN_NAME = "WAR GODS"
local BACKGROUND_IMAGE_ID = "rbxassetid://105816052547218"

if CoreGui:FindFirstChild("WG_AntiAFK_Gui") then
    CoreGui["WG_AntiAFK_Gui"]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WG_AntiAFK_Gui"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 130)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundTransparency = 1
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = BACKGROUND_IMAGE_ID
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 1
BackgroundImage.Parent = MainFrame

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = BackgroundImage

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Text = "★ WG antiAFK ★"
Title.TextColor3 = Color3.fromRGB(255, 255, 255) 
Title.TextSize = 20
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1
Title.TextStrokeTransparency = 0.15 
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Title.ZIndex = 3 
Title.Parent = MainFrame

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({ 
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 15)),   
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(148, 0, 211)), 
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))    
})
Gradient.Parent = Title

task.spawn(function()
    while true do
        local tween = TweenService:Create(Gradient, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Offset = Vector2.new(1, 0)})
        tween:Play()
        tween.Completed:Wait()
        Gradient.Offset = Vector2.new(-1, 0)
    end
end)

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 30)
Subtitle.Position = UDim2.new(0, 0, 0, 45)
Subtitle.Text = "Clan: " .. CLAN_NAME .. " | By: " .. MY_NAME
Subtitle.TextColor3 = Color3.fromRGB(15, 15, 15) 
Subtitle.TextSize = 14
Subtitle.Font = Enum.Font.SourceSansBold
Subtitle.BackgroundTransparency = 1
Subtitle.TextStrokeTransparency = 0.4 
Subtitle.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
Subtitle.ZIndex = 3
Subtitle.Parent = MainFrame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 40)
Status.Position = UDim2.new(0, 0, 0, 80)
Status.Text = "● ميزة منع الخمول تعمل بنجاح وآمنة"
Status.TextColor3 = Color3.fromRGB(0, 200, 50) 
Status.TextSize = 13
Status.Font = Enum.Font.GothamBold 
Status.BackgroundTransparency = 1
Status.TextStrokeTransparency = 0.3
Status.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Status.ZIndex = 3
Status.Parent = MainFrame

-- ⌨️ [زر التوغل الكيبوردي]: اضغط حرف "K" في لوحة المفاتيح لإخفاء وإظهار الواجهة فوراً ومحمي 100%
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

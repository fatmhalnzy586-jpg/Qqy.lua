--[[
    ═══════════════════════════════════════════════════════════════
    💀 DOA IBU x xc9 UNDERGROUND ELITE HUB - BLOCK SPIN
    🔥 Custom Vibe Edition | Crash-Free Safe Server Hop
    👑 Owner & Developer: xc9
    ═══════════════════════════════════════════════════════════════
--]]

-- حماية النظام وعزل البيئة
do
    pcall(function()
        local mt = getrawmetatable(game)
        if mt and setreadonly then setreadonly(mt, false) end
    end)
end

local Players = Service or game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- تحميل واجهة WindUI بنسخة مخصصة
local WindUI
do
    local ok, res = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)
    if ok and res then WindUI = res end
end

if not WindUI then
    player:Kick("[xc9 Security]: UI Failed to load.")
    return
end

local CONFIG = {
    Title = "DOA IBU | xc9 Underground",
    Author = "Special Edition by xc9",
    ImageId = "rbxassetid://134171679514822",
}

-- ثيم مخصص مستوحى من أجواء الكوميونيتي (أحمر دموي + أسود فاحم + ذهبي)
local DoaTheme = "DoaIbu_Underground"

WindUI:AddTheme({
    Name = DoaTheme,
    Accent = WindUI:Gradient({ ["0"] = "#4A0000", ["50"] = "#FF1E1E", ["100"] = "#FFA500" }, 45),
    Background = WindUI:Gradient({
        ["0"] = { Color = "#000000", Transparency = 0.03 },
        ["50"] = { Color = "#0A0505", Transparency = 0.06 },
        ["100"] = { Color = "#150000", Transparency = 0.09 },
    }, 135),
    Outline = WindUI:Gradient({ ["0"] = "#FF1E1E", ["50"] = "#8B0000", ["100"] = "#300000" }, 90),
    Button = WindUI:Gradient({ ["0"] = "#0D0D0D", ["50"] = "#260000", ["100"] = "#050505" }, 90),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#FFA0A0"),
    Icon = Color3.fromHex("#FF4500"),
})

WindUI:SetTheme(DoaTheme)

local Window = WindUI:CreateWindow({
    Title = CONFIG.Title,
    Icon = CONFIG.ImageId,
    Author = CONFIG.Author,
    Folder = "DoaIbu_xc9_Hub",
    Size = UDim2.fromOffset(700, 520),
    MinSize = Vector2.new(550, 450),
    ToggleKey = Enum.KeyCode.F3,
    Transparent = true,
    Theme = DoaTheme,
    Resizable = true,
    SideBarWidth = 210,
    HideSearchBar = true,
    Acrylic = true,
    Topbar = { Height = 50, ButtonsType = "Mac" },
    OpenButton = {
        Title = "Doa Ibu Hub",
        Icon = CONFIG.ImageId,
        CornerRadius = UDim.new(1, 0),
        Draggable = true,
        Enabled = true,
        Color = ColorSequence.new(Color3.fromRGB(5, 5, 5), Color3.fromRGB(180, 0, 0)),
    },
    User = {
        Enabled = true,
        Image = CONFIG.ImageId,
        Callback = function()
            WindUI:Notify({ Title = "Doa Ibu x xc9", Content = "User: " .. player.Name, Duration = 3 })
        end,
    },
})

-- ═══════════════════════════════════════════════════════
--  1. تبويب السيرفر الآمن (CRASH-FREE SAFE SERVER HOP)
-- ═══════════════════════════════════════════════════════
local HopTab = Window:Tab({ Title = "السيرفرات والتقارير", Icon = "server" })
HopTab:Section({ Title = "🌐 نظام السيرفر الفارغ (بدون كراش)" })

local isHopping = false

local function SafeServerHop()
    if isHopping then return end
    isHopping = true
    
    WindUI:Notify({ Title = "🔄 Server Hop", Content = "جاري البحث عن سيرفر فاضي بأمان...", Duration = 3 })
    
    task.spawn(function()
        local success, err = pcall(function()
            local cursor = ""
            local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100", game.PlaceId)
            
            local req = game:HttpGet(url)
            local data = HttpService:JSONDecode(req)
            
            if data and data.data then
                for _, server in ipairs(data.data) do
                    -- التأكد أنه ليس السيرفر الحالي وأن عدد اللاعبين قليل جداً أو فاضي (مثلاً أقل من 3 لاعبين)
                    if server.id ~= game.JobId and server.playing < (server.maxPlayers or 20) then
                        if server.playing <= 2 then -- يفضل سيرفرات فاضية تماماً
                            WindUI:Notify({ Title = "✅ تم العثور", Content = "تمت إفادة الانتقال لسيرفر فيه " .. server.playing .. " لاعبين", Duration = 2 })
                            task.wait(0.5)
                            TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, player)
                            isHopping = false
                            return
                        end
                    end
                end
                
                -- لو ما حصل سيرفر فاضي تماماً، ياخذ أول سيرفر خفيف متاح
                for _, server in ipairs(data.data) do
                    if server.id ~= game.JobId and server.playing < server.maxPlayers then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, player)
                        isHopping = false
                        return
                    end
                end
            end
        end)
        
        if not success then
            warn("[Hop Error]: " .. tostring(err))
            WindUI:Notify({ Title = "❌ خطأ", Content = "فشل الانتقال، جرب مرة أخرى", Duration = 3 })
        end
        isHopping = false
    end)
end

HopTab:Button({
    Title = "📭 الدخول لسيرفر فاضي (آمن وخالي من الكراش)",
    Desc = "يبحث عن سيرفر هادئ وينقلك له بدون تجميد اللعبة",
    Callback = function()
        SafeServerHop()
    end,
})

-- ═══════════════════════════════════════════════════════
--  2. تبويب الصيد الخارق (DOA IBU FISHING)
-- ═══════════════════════════════════════════════════════
local FishTab = Window:Tab({ Title = "صيد Doa Ibu", Icon = "fish" })
FishTab:Section({ Title = "⚡ ميزات صيد الـ Elite" })

local FishCfg = { Cast = false, Reel = false, Delay = 0.8 }

FishTab:Toggle({
    Title = "🎣 رمي الصنارة تلقائياً (Auto Cast)",
    Default = false,
    Callback = function(v) FishCfg.Cast = v end,
})

FishTab:Toggle({
    Title = "🐟 سحب السمكة الفوري (Instant Reel)",
    Default = false,
    Callback = function(v) FishCfg.Reel = v end,
})

task.spawn(function()
    while true do
        task.wait(0.1)
        if FishCfg.Cast then
            pcall(function()
                local char = player.Character
                if char then
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool and (string.find(tool.Name:lower(), "rod") or string.find(tool.Name:lower(), "fish")) then
                        tool:Activate()
                        task.wait(FishCfg.Delay)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if FishCfg.Reel then
            pcall(function()
                local gui = playerGui:FindFirstChild("FishingMinigame") or playerGui:FindFirstChild("Reel")
                if gui then
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(0.01)
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    task.wait(0.1)
                end
            end)
        end
    end
end)

-- ═══════════════════════════════════════════════════════
--  3. تبويب المتاجر والسيارات (DOA STORE & CARS)
-- ═══════════════════════════════════════════════════════
local StoreTab = Window:Tab({Title = "المتجر والسيارات", Icon = "shopping-cart"})
StoreTab:Section({Title = "🛒 خدمات Doa Ibu التلقائية"})

StoreTab:Toggle({
    Title = "💰 بيع كل الأسماك والعناصر تلقائياً",
    Default = false,
    Callback = function(v)
        _G.DoaSell = v
        task.spawn(function()
            while _G.DoaSell do
                pcall(function()
                    local ev = ReplicatedStorage:FindFirstChild("SellShopEvent")
                    if ev then ev:FireServer("SellAll") ev:FireServer("All") end
                end)
                task.wait(1.5)
            end
        end)
    end,
})

StoreTab:Button({
    Title = "🚗 استدعاء سيارة Hurricane الفورية",
    Callback = function()
        pcall(function()
            local ev = ReplicatedStorage:FindFirstChild("SpawnCarEvent")
            if ev then firesignal(ev.OnClientEvent, "INIT_DATA", {Hurricane = 99}, "Hurricane") end
            WindUI:Notify({Title = "Doa Ibu", Content = "تم جلب السيارة بنجاح!", Duration = 2})
        end)
    end,
})

-- ═══════════════════════════════════════════════════════
--  4. حقوق الملكية (CREDITS)
-- ═══════════════════════════════════════════════════════
local InfoTab = Window:Tab({Title = "الحقوق", Icon = "info"})
InfoTab:Section({Title = "معلومات النسخة الخاصة"})

InfoTab:Button({
    Title = "نسخ حقوق الملكية (xc9 & Doa Ibu Vibe)",
    Callback = function()
        if setclipboard then
            setclipboard("Doa Ibu Underground Hub - Developed by xc9")
            WindUI:Notify({Title = "تم النسخ", Content = "تم نسخ الحقوق بنجاح", Duration = 2})
        end
    end,
})

task.spawn(function()
    task.wait(1)
    WindUI:Notify({
        Title = "🔥 Doa Ibu x xc9",
        Content = "تم تفعيل النسخة الخاصة بنجاح يا " .. player.Name,
        Duration = 4,
    })
end)

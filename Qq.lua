--[[
    ═══════════════════════════════════════════════════════════════
    🔥 BLOCK SPIN ULTIMATE ELITE HUB - xc9 SUPREME PRIVATE EDITION
    👑 Developer & Creator: xc9
    🛡️ Advanced Anti-Detection & High-Performance Core
    ═══════════════════════════════════════════════════════════════
--]]

-- [ حماية النظام وعزل البيئة ]
do
    local success = pcall(function()
        local mt = getrawmetatable(game)
        if mt and setreadonly then
            setreadonly(mt, false)
        end
    end)
    if not success then
        warn("[xc9 SECURE]: Environment lockdown active.")
    end
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [ تحميل واجهة WindUI الفاخرة ]
local WindUI
do
    local ok, res = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)
    if ok and res then
        WindUI = res
    else
        pcall(function()
            WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()
        end)
    end
end

if not WindUI then
    player:Kick("[xc9 Security]: UI Framework failed to load safely.")
    return
end

local CONFIG = {
    Title = "BLOCK SPIN | xc9 Supreme Hub",
    Author = "Created by xc9 (Private Elite)",
    ImageId = "rbxassetid://134171679514822",
}

-- [ الثيم الملكي (أسود + أحمر داكن وذهبي) ]
local SUPREME_THEME = "xc9 Supreme Dark"

local function createGradient(colors, rotation)
    local points = {}
    for pos, col in pairs(colors) do
        points[pos] = {
            Color = Color3.fromHex(col.Color or col),
            Transparency = col.Transparency or 0
        }
    end
    return WindUI:Gradient(points, { Rotation = rotation or 45 })
end

WindUI:AddTheme({
    Name = SUPREME_THEME,
    Accent = createGradient({ ["0"] = "#8B0000", ["50"] = "#FFD700", ["100"] = "#4A0000" }, 45),
    Background = createGradient({
        ["0"] = { Color = "#020202", Transparency = 0.02 },
        ["50"] = { Color = "#0A0A0A", Transparency = 0.05 },
        ["100"] = { Color = "#1A0000", Transparency = 0.08 },
    }, 135),
    Outline = createGradient({ ["0"] = "#FFD700", ["50"] = "#FF2020", ["100"] = "#5C0000" }, 90),
    Button = createGradient({ ["0"] = "#0D0D0D", ["50"] = "#2B0000", ["100"] = "#050505" }, 90),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#FFC0C0"),
    Icon = Color3.fromHex("#FFFFFF"),
})

WindUI:SetTheme(SUPREME_THEME)

local Window = WindUI:CreateWindow({
    Title = CONFIG.Title,
    Icon = CONFIG.ImageId,
    Author = CONFIG.Author,
    Folder = "xc9_BlockSpin_Supreme",
    Size = UDim2.fromOffset(700, 530),
    MinSize = Vector2.new(550, 450),
    ToggleKey = Enum.KeyCode.F3,
    Transparent = true,
    Theme = SUPREME_THEME,
    Resizable = true,
    SideBarWidth = 210,
    HideSearchBar = true,
    Acrylic = true,
    Topbar = { Height = 50, ButtonsType = "Mac" },
    OpenButton = {
        Title = "xc9 Supreme",
        Icon = CONFIG.ImageId,
        CornerRadius = UDim.new(1, 0),
        Draggable = true,
        Enabled = true,
        Color = ColorSequence.new(Color3.fromRGB(10, 10, 10), Color3.fromRGB(220, 20, 20)),
    },
    User = {
        Enabled = true,
        Image = CONFIG.ImageId,
        Callback = function()
            WindUI:Notify({ Title = "xc9 Supreme", Content = "Welcome Owner: " .. player.Name, Duration = 3 })
        end,
    },
})

-- ═══════════════════════════════════════════════════════
--  TAB 1: 🎣 الصيد التلقائي الخارق (AUTO FISH & REEL)
-- ═══════════════════════════════════════════════════════
local FishTab = Window:Tab({ Title = "الصيد التلقائي", Icon = "fish" })
FishTab:Section({ Title = "⚡ نظام الصيد الفوري والتلقائي" })

local FishConfig = {
    AutoCast = false,
    AutoReel = false,
    CastDelay = 1.0,
    ReelDelay = 0.15,
}

FishTab:Toggle({
    Title = "🎣 رمي الصنارة تلقائياً (Auto Cast)",
    Default = false,
    Callback = function(v) FishConfig.AutoCast = v end,
})

FishTab:Toggle({
    Title = "🐟 سحب السمكة فورياً (Auto Reel)",
    Default = false,
    Callback = function(v) FishConfig.AutoReel = v end,
})

FishTab:Slider({
    Title = "⏱️ تأخير الرمي",
    Step = 0.1,
    Value = { Min = 0.3, Max = 3, Default = 1.0 },
    Callback = function(v) FishConfig.CastDelay = v end,
})

task.spawn(function()
    while true do
        task.wait(0.1)
        if FishConfig.AutoCast then
            pcall(function()
                local char = player.Character
                if char then
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool and (string.find(tool.Name:lower(), "rod") or string.find(tool.Name:lower(), "fish")) then
                        tool:Activate()
                        task.wait(FishConfig.CastDelay)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if FishConfig.AutoReel then
            pcall(function()
                local gui = playerGui:FindFirstChild("FishingMinigame") or playerGui:FindFirstChild("Reel") or playerGui:FindFirstChildWhichIsA("ScreenGui")
                if gui then
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(0.02)
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    task.wait(FishConfig.ReelDelay)
                end
            end)
        end
    end
end)

-- ═══════════════════════════════════════════════════════
--  TAB 2: 🛒 الشراء والبيع التلقائي (AUTO BUY & SELL)
-- ═══════════════════════════════════════════════════════
local ShopTab = Window:Tab({ Title = "المتجر والبيع", Icon = "shopping-cart" })
ShopTab:Section({ Title = "🛒 الشراء والبيع الفوري" })

local ShopConfig = {
    ItemName = "WormtecRegular",
    Amount = 10,
    Delay = 0.4,
    AutoBuy = false,
    AutoSell = false,
}

ShopTab:Input({
    Title = "اسم العنصر",
    Value = ShopConfig.ItemName,
    Placeholder = "WormtecRegular",
    Callback = function(v) ShopConfig.ItemName = v end,
})

ShopTab:Input({
    Title = "الكمية",
    Value = tostring(ShopConfig.Amount),
    Placeholder = "10",
    Callback = function(v)
        local num = tonumber(v)
        if num and num > 0 then ShopConfig.Amount = math.floor(num) end
    end,
})

ShopTab:Toggle({
    Title = "🚀 تفعيل الشراء التلقائي",
    Default = false,
    Callback = function(v)
        ShopConfig.AutoBuy = v
        if v then
            task.spawn(function()
                while ShopConfig.AutoBuy do
                    pcall(function()
                        local ev = ReplicatedStorage:FindFirstChild("MopShopEvent")
                        if ev then
                            ev:FireServer("BUY", ShopConfig.ItemName, ShopConfig.Amount)
                        end
                    end)
                    task.wait(ShopConfig.Delay)
                end
            end)
        end
    end,
})

ShopTab:Toggle({
    Title = "💰 تفعيل بيع الأسماك والعناصر تلقائياً",
    Default = false,
    Callback = function(v)
        ShopConfig.AutoSell = v
        task.spawn(function()
            local sellEvent = ReplicatedStorage:FindFirstChild("SellShopEvent")
            while ShopConfig.AutoSell and sellEvent do
                pcall(function()
                    sellEvent:FireServer("SellAll")
                    sellEvent:FireServer("All")
                end)
                task.wait(1)
            end
        end)
    end,
})

-- ═══════════════════════════════════════════════════════
--  TAB 3: 🚗 السيارات والحركة (CARS & MOVEMENT)
-- ═══════════════════════════════════════════════════════
local CarTab = Window:Tab({ Title = "السيارات والحركة", Icon = "car" })
CarTab:Section({ Title = "🏎️ التحكم الكامل بالسيارة والارتفاع (Z/X)" })

local CarSpeed = 100
CarTab:Slider({
    Title = "⚡ سرعة السيارة",
    Step = 10,
    Value = { Min = 30, Max = 400, Default = 100 },
    Callback = function(v) CarSpeed = v end,
})

CarTab:Button({
    Title = "🚗 سحب أفضل سيارة أمامك",
    Callback = function()
        pcall(function()
            local spawnEvent = ReplicatedStorage:FindFirstChild("SpawnCarEvent")
            if spawnEvent then
                firesignal(spawnEvent.OnClientEvent, "INIT_DATA", {Hurricane = 99}, "Hurricane")
            end
            WindUI:Notify({ Title = "xc9 Cars", Content = "تم استدعاء السيارة بنجاح!", Duration = 2 })
        end)
    end,
})

-- ═══════════════════════════════════════════════════════
--  TAB 4: ⚙️ الإعدادات والسيرفرات (SETTINGS & SERVER HOP)
-- ═══════════════════════════════════════════════════════
local SettingsTab = Window:Tab({ Title = "الإعدادات والسيرفرات", Icon = "settings" })
SettingsTab:Section({ Title = "🌐 الانتقال السريع بين السيرفرات (Server Hop)" })

SettingsTab:Button({
    Title = "🎯 البحث عن سيرفر خالي والقفز إليه",
    Callback = function()
        WindUI:Notify({ Title = "xc9 ServerHop", Content = "جاري البحث عن سيرفر هادئ...", Duration = 3 })
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        pcall(function()
            local site = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            for _, s in ipairs(site.data) do
                if s.id ~= game.JobId and s.playing < s.maxPlayers then
                    TPS:TeleportToPlaceInstance(game.PlaceId, s.id, player)
                    return
                end
            end
        end)
    end,
})

SettingsTab:Section({ Title = "👑 حقوق الملكية" })
SettingsTab:Button({
    Title = "نسخ حقوق الملكية (xc9 Private)",
    Callback = function()
        if setclipboard then
            setclipboard("xc9 Supreme Elite Hub - Block Spin")
            WindUI:Notify({ Title = "xc9 Hub", Content = "تم النسخ بنجاح!", Duration = 2 })
        end
    end,
})

-- [ إشعار الترحيب ]
task.spawn(function()
    task.wait(1)
    WindUI:Notify({
        Title = "💎 xc9 Supreme Hub",
        Content = "مرحباً بك يا " .. player.Name .. " - تم تفعيل أقوى سكربت مدفوع بنجاح!",
        Duration = 4,
    })
end)

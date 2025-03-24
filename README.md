local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "BasicHub",
    SaveConfig = true,
    ConfigFolder = "CarlosHub2025",
    Icon = "rbxassetid://72722747636378" -- Logo do CarlosHub2025
})

-- Criando Abas
local ESP_Tab = Window:MakeTab({ Name = "ESP", Icon = "rbxassetid://4483345998" })
local Settings_Tab = Window:MakeTab({ Name = "Configurações", Icon = "rbxassetid://4483345998" })

-- Variáveis do ESP
local ESPEnabled = false
local ESPColor = Color3.fromRGB(255, 0, 0)
local ESPTransparency = 0.3
local ESPFriendsOnly = false

-- Função para criar ESP
local function createESP(player)
    if player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") and not part:FindFirstChild("ESPBox") then
                local box = Instance.new("BoxHandleAdornment")
                box.Size = part.Size + Vector3.new(0.1, 0.1, 0.1)
                box.Adornee = part
                box.Color3 = ESPColor
                box.Transparency = ESPTransparency
                box.ZIndex = 5
                box.AlwaysOnTop = true
                box.Parent = part
                box.Name = "ESPBox"
            end
        end
    end
end

-- Função para ativar/desativar ESP
local function toggleESP()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and (not ESPFriendsOnly or game.Players.LocalPlayer:IsFriendsWith(player.UserId)) then
                createESP(player)
            end
        end
        OrionLib:MakeNotification({ Name = "CarlosHub2025", Content = "ESP Ativado!", Time = 3 })
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") and part:FindFirstChild("ESPBox") then
                        part.ESPBox:Destroy()
                    end
                end
            end
        end
        OrionLib:MakeNotification({ Name = "CarlosHub2025", Content = "ESP Desativado!", Time = 3 })
    end
end

-- Adicionando botões e opções na aba ESP
ESP_Tab:AddButton({ Name = "Ativar/Desativar ESP", Callback = toggleESP })
ESP_Tab:AddToggle({
    Name = "Somente Amigos",
    Default = false,
    Callback = function(value) ESPFriendsOnly = value end
})
ESP_Tab:AddColorpicker({
    Name = "Cor do ESP",
    Default = ESPColor,
    Callback = function(color) ESPColor = color end
})
ESP_Tab:AddSlider({
    Name = "Transparência do ESP",
    Min = 0,
    Max = 1,
    Default = 0.3,
    Increment = 0.05,
    Callback = function(value) ESPTransparency = value end
})

-- Configurações e atalhos
Settings_Tab:AddLabel("Atalhos:")
Settings_Tab:AddBind({
    Name = "Ativar/Desativar ESP",
    Default = Enum.KeyCode.E,
    Callback = toggleESP
})

-- Atualiza o ESP quando novos jogadores entram no jogo
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        if ESPEnabled then
            createESP(player)
        end
    end)
end)

-- Iniciando a interface Orion
OrionLib:Init()

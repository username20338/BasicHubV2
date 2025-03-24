-- Carregar a Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Criar a Janela Principal com o nome do script
local Window = OrionLib:MakeWindow({Name = "xFruitsHub", HidePremium = false, SaveConfig = true, ConfigFolder = "BloxFruits"})

-- Criar a Aba de Auto Farm
local AutoFarmTab = Window:MakeTab({Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Criar a Aba de Frutas
local FruitTab = Window:MakeTab({Name = "Frutas", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Criar a Aba de Teleporte
local TeleportTab = Window:MakeTab({Name = "Teleport", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Criar a Aba de PvP
local PvPTab = Window:MakeTab({Name = "PvP", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Criar a Aba de ESP
local ESPTab = Window:MakeTab({Name = "ESP", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Criar a Aba de Informações (para o Discord)
local InfoTab = Window:MakeTab({Name = "Informações", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Aba de Auto Farm
AutoFarmTab:AddToggle({
    Name = "Auto Farm NPCs",
    Default = false,
    Callback = function(Value)
        AutoFarm = Value
        while AutoFarm do
            task.wait(0.1)
            local player = game.Players.LocalPlayer
            local char = player.Character
            local humanoidRootPart = char and char:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart then
                for _, npc in pairs(game.Workspace.Enemies:GetChildren()) do
                    if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") then
                        humanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Combat", npc)
                        break
                    end
                end
            end
        end
    end
})

-- Aba de Frutas
FruitTab:AddButton({
    Name = "Puxar Todas as Frutas",
    Callback = function()
        for _, fruta in pairs(game.Workspace:GetChildren()) do
            if string.find(fruta.Name, "Fruit") then
                fruta.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end
})

FruitTab:AddToggle({
    Name = "Auto Comprar Fruta Aleatória",
    Default = false,
    Callback = function(Value)
        AutoRandomFruit = Value
        while AutoRandomFruit do
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
            for i = 1, 7200 do
                if not AutoRandomFruit then break end
                task.wait(1)
            end
        end
    end
})

-- Aba de Teleporte
TeleportTab:AddButton({
    Name = "Teleport para Ilha Principal",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(100, 10, 100) -- Ajuste as coordenadas conforme necessário
        end
    end
})

TeleportTab:AddButton({
    Name = "Teleport para Ilha de Farm",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(500, 10, 500) -- Ajuste as coordenadas conforme necessário
        end
    end
})

-- Aba de PvP
PvPTab:AddButton({
    Name = "Auto PvP (Atacar Jogadores)",
    Callback = function()
        local player = game.Players.LocalPlayer
        while true do
            task.wait(0.1)
            if not player.Character then continue end
            for _, target in pairs(game.Players:GetChildren()) do
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    -- Ataque o jogador (Exemplo básico de ataque)
                    local humanoidRootPart = target.Character.HumanoidRootPart
                    player.Character.HumanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Combat", target.Character)
                    break
                end
            end
        end
    end
})

-- Aba de ESP
ESPTab:AddButton({
    Name = "Ativar ESP de Frutas",
    Callback = function()
        for _, fruit in pairs(game.Workspace:GetChildren()) do
            if string.find(fruit.Name, "Fruit") then
                local highlight = Instance.new("Highlight")
                highlight.Parent = fruit
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        end
    end
})

-- Aba de Informações (Discord Link)
InfoTab:AddLabel("Discord: https://discord.gg/nR8s3qxk") -- Link para o Discord
InfoTab:AddButton({
    Name = "Entrar no Discord",
    Callback = function()
        -- Abrir o link do Discord
        setclipboard("https://discord.gg/nR8s3qxk") -- Copiar o link para área de transferência
        OrionLib:MakeNotification({
            Name = "Link Copiado!",
            Content = "O link do seu Discord foi copiado para a área de transferência.",
            Time = 3
        })
    end
})

-- Finalizar a UI
OrionLib:Init()
